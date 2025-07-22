import 'dart:convert';
import 'package:matri_station/utility/constant.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<Map<String, dynamic>> registerUser(Map<String, String> body) async {
    try {
      final url = Uri.parse("$baseURL/register");
      print("📤 Sending POST to: $url");
      print("📦 Body: $body");

      final response = await http.post(url, body: body);

      print("📥 Response Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'status': 'error',
          'message': 'Server Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      print("❌ Exception during registerUser: $e");
      return {
        'status': 'error',
        'message': 'Something went wrong. Please try again later.',
        'error': e.toString(),
      };
    }
  }
}
