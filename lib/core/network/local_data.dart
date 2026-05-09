import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Central place for in-memory token access AND secure persistent storage.
abstract class LocalData {
  // ─── In-memory token (fast access during the session) ──────────────
  static String? accessToken;
  static String? refreshToken;

  // ─── Secure Storage instance ────────────────────────────────────────
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _tokenKey = 'access_token';
  static const _refreshKey = 'refresh_token';

  // ─── Save ────────────────────────────────────────────────────────────
  static Future<void> saveToken(String token) async {
    accessToken = token;
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<void> saveRefreshToken(String token) async {
    refreshToken = token;
    await _storage.write(key: _refreshKey, value: token);
  }

  // ─── Load (call on app start) ────────────────────────────────────────
  static Future<void> loadTokens() async {
    accessToken = await _storage.read(key: _tokenKey);
    refreshToken = await _storage.read(key: _refreshKey);
  }

  // ─── Clear (on logout) ───────────────────────────────────────────────
  static Future<void> clearTokens() async {
    accessToken = null;
    refreshToken = null;
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshKey);
  }
}