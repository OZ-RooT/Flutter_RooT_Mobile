import 'auth_api.dart';
import 'token_storage.dart';
import '../../models/auth/login_request.dart';
import '../../models/auth/signup_request.dart';
import '../../models/auth/token_response.dart';
import '../../models/auth/user_response.dart';

class AuthRepository {
  final AuthApi _api = AuthApi();

  Future<TokenResponse?> login(LoginRequest request) async {
    final res = await _api.login(request);
    if (res.success && res.data != null) {
      await TokenStorage.saveTokens(res.data!.accessToken, res.data!.refreshToken);
      return res.data;
    }
    return null;
  }

  Future<UserResponse?> signup(SignupRequest request) async {
    final res = await _api.signup(request);
    if (res.success && res.data != null) {
      return res.data;
    }
    return null;
  }

  Future<void> logout() async {
    await TokenStorage.clear();
  }

  bool get isLoggedIn => TokenStorage.accessToken != null;
}
