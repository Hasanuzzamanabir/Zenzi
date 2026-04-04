import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _accessToken = 'access';
  static const String _refreshToken = 'refresh';
  static const String _userEmail = 'email';

  static Future<bool> saveAccessToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_accessToken, token);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> saveRefreshToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_refreshToken, token);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> saveUserEmail(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_userEmail, email);
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_accessToken);
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getRefreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_refreshToken);
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getUserEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userEmail);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> clearTokens() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_accessToken);
      await prefs.remove(_refreshToken);
      await prefs.remove(_userEmail);
      return true;
    } catch (e) {
      return false;
    }
  }
}
