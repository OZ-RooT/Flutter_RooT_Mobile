import 'package:get_storage/get_storage.dart';

class TokenStorage {
  static final _box = GetStorage();
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';

  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _box.write(_accessTokenKey, accessToken);
    await _box.write(_refreshTokenKey, refreshToken);
  }

  static String? get accessToken => _box.read(_accessTokenKey);
  static String? get refreshToken => _box.read(_refreshTokenKey);

  static Future<void> clear() async {
    await _box.remove(_accessTokenKey);
    await _box.remove(_refreshTokenKey);
  }
}
