import 'package:get/get.dart';
import '../../../core/network/api/auth_repository.dart';
import '../../../core/models/auth/login_request.dart';
import '../../../core/models/auth/signup_request.dart';
import '../../../core/models/auth/token_response.dart';
import '../../../core/models/auth/user_response.dart';
import '../../../core/network/api/token_storage.dart';

class AuthController extends GetxController {
  final AuthRepository _repo = AuthRepository();

  var isLoading = false.obs;
  var loginError = ''.obs;
  var signupError = ''.obs;
  var token = Rxn<TokenResponse>();
  var user = Rxn<UserResponse>();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    loginError.value = '';
    final result = await _repo.login(LoginRequest(email: email, password: password));
    if (result != null) {
      token.value = result;
    } else {
      loginError.value = '로그인 실패';
    }
    isLoading.value = false;
  }

  Future<void> signup(String email, String password, String name, String language) async {
    isLoading.value = true;
    signupError.value = '';
    final result = await _repo.signup(SignupRequest(email: email, password: password, name: name, language: language));
    if (result != null) {
      user.value = result;
    } else {
      signupError.value = '회원가입 실패';
    }
    isLoading.value = false;
  }

  Future<void> logout() async {
    await _repo.logout();
    token.value = null;
    user.value = null;
  }

  bool get isLoggedIn => _repo.isLoggedIn;

  String? get accessToken => TokenStorage.accessToken;
}
