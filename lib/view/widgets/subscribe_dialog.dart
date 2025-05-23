import 'package:flutter/material.dart';
import '../../core/constants/app_styles.dart';

// Widget hiển thị hộp thoại đăng ký nhận thông báo thời tiết
class SubscribeDialog extends StatefulWidget {
  final void Function(String email, bool subscribe) onSubmit;
  const SubscribeDialog({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<SubscribeDialog> createState() => _SubscribeDialogState();
}

class _SubscribeDialogState extends State<SubscribeDialog> {
  final TextEditingController emailController = TextEditingController();

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
                onPressed: () {
                  final email = emailController.text.trim();
                  if (email.isEmpty || !email.contains('@')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid email!')),
                    );
                    return;
                  }
                  widget.onSubmit(email, false); // Unsubscribe
                },
                child: Text('Unsubscribe'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.grayapp,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  if (email.isEmpty || !email.contains('@')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid email!')),
                    );
                    return;
                  }
                  widget.onSubmit(email, true); // Subscribe
                },
                child: Text('Subscribe'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
