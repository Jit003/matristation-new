import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {
  static const String _tokenKey = 'token';

  static Future<void> saveToken (String token) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<void> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token =  prefs.getString(_tokenKey);
    print('the token is $token');
  }
}