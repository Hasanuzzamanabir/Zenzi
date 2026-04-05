import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _accessToken = 'access';
  static const String _refreshToken = 'refresh';
  static const String _userEmail = 'email';
  static const String _uid = "uidB64";
  static const String _token = "token";

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

  static Future<bool> savePasswordResetData(String uidB64, String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_uid, uidB64);
      await prefs.setString(_token, token);
      return true;
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

  static Future<String?> getUid() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_uid);
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getResetToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_token);
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
      await prefs.remove(_uid);
      await prefs.remove(_token);
      return true;
    } catch (e) {
      return false;
    }
  }
}
