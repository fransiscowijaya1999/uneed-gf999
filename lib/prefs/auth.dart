import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefs {
  Future<void> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('auth_token', token);
  }
}