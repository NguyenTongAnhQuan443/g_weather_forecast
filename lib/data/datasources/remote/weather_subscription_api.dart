import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherSubscriptionApi {
  static const String baseUrl = "https://ola-chat-backend-latest.onrender.com/ola-chat/api/subscribe";

  // Đăng ký nhận thông báo
  static Future<bool> subscribe(String email, double lat, double lng) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'latitude': lat,
        'longitude': lng,
      }),
    );
    return response.statusCode == 200;
  }

  // Hủy nhận thông báo
  static Future<bool> unsubscribe(String email) async {
    final uri = Uri.parse("$baseUrl?email=$email");
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }
}
