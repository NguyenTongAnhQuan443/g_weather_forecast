import 'package:flutter/material.dart';
import '../../core/constants/app_styles.dart';
import '../../data/datasources/local/email_prefs.dart';
import '../../data/datasources/remote/weather_subscription_api.dart';
import '../../data/datasources/local/email_prefs.dart';
import 'package:geolocator/geolocator.dart';

// Widget hiển thị hộp thoại đăng ký nhận thông báo thời tiết
class SubscribeDialog extends StatefulWidget {
  final void Function(String email, bool subscribe) onSubmit;
  const SubscribeDialog({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<SubscribeDialog> createState() => _SubscribeDialogState();
}

class _SubscribeDialogState extends State<SubscribeDialog> {
  final TextEditingController emailController = TextEditingController();
  bool isLoadingSubscribe = false;
  bool isLoadingUnsubscribe = false;

  @override
  void initState() {
    super.initState();
    EmailPrefs.loadEmail().then((email) {
      if (email != null) {
        emailController.text = email;
      }
    });
  }

  // Regex Email
  bool _isValidEmail(String email) {
    final RegExp regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(email);
  }

  // handle đăng ký và hủy đăng ký
  Future<void> _handleSubscribe(bool subscribe) async {
    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email!')),
      );
      return;
    }

    setState(() {
      if (subscribe) {
        isLoadingSubscribe = true;
      } else {
        isLoadingUnsubscribe = true;
      }
    });

    if (subscribe) {
      // Lấy vị trí hiện tại để gửi cùng email
      try {
        final pos = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium);
        final result = await WeatherSubscriptionApi.subscribe(
            email, pos.latitude, pos.longitude);
        if (result) {
          await EmailPrefs.saveEmail(email);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Registration successful! Please check your confirmation email.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed, try again later.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cannot get current location!')),
        );
      }
    } else {
      final result = await WeatherSubscriptionApi.unsubscribe(email);
      if (result) {
        await EmailPrefs.removeEmail();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unsubscribe successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cancellation failed, try again later.')),
        );
      }
    }

    setState(() {
      isLoadingSubscribe = false;
      isLoadingUnsubscribe = false;
    });
    widget.onSubmit(email, subscribe);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Weather Notification Subscription'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter your email to receive daily weather notifications:',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 12),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'your@email.com',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: (isLoadingSubscribe || isLoadingUnsubscribe)
                    ? null
                    : () => _handleSubscribe(false),
                child: isLoadingUnsubscribe
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text('Unsubscribe'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.grayapp,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: (isLoadingSubscribe || isLoadingUnsubscribe)
                    ? null
                    : () => _handleSubscribe(true),
                child: isLoadingSubscribe
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Text('Subscribe'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
