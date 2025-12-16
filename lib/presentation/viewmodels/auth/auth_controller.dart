import 'dart:io';

import 'package:get/get.dart';
import '../../../core/network/api/auth_repository.dart';
import '../../../core/models/auth/login_request.dart';
import '../../../core/models/auth/signup_request.dart';
import '../../../core/models/auth/token_response.dart';
import '../../../core/models/auth/user_response.dart';
import '../../../core/network/api/token_storage.dart';
import '../../../core/network/api/image_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthController extends GetxController {
  final AuthRepository _repo = AuthRepository();
  final ImageApi _imageApi = ImageApi();

  var isLoading = false.obs;
  var loginError = ''.obs;
  var signupError = ''.obs;
  var token = Rxn<TokenResponse>();
  var user = Rxn<UserResponse>();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    loginError.value = '';
    final result = await _repo.login(
      LoginRequest(email: email, password: password),
    );
    if (result != null) {
      token.value = result;
    } else {
      loginError.value = '로그인 실패';
    }
    isLoading.value = false;
  }

  Future<void> signup(
    String email,
    String password,
    String name,
    String language, {
    int? profileImageId,
    String? profileImageUpload,
  }) async {
    isLoading.value = true;
    signupError.value = '';
    final signupResult = await _repo.signup(
      SignupRequest(
        email: email,
        password: password,
        name: name,
        language: language,
        profileImageId: profileImageId,
      ),
    );

    if (signupResult != null) {
      user.value = signupResult;
      if (profileImageUpload != null && profileImageId == null) {
        final access = TokenStorage.accessToken;
        if (access != null) {
          final body = <String, dynamic>{};
          body['profileImage'] = profileImageUpload;
          final updated = await _repo.updateUser(access, signupResult.id, body);
          if (updated != null) user.value = updated;
        }
      }
    } else {
      final loginResult = await _repo.login(
        LoginRequest(email: email, password: password),
      );
      if (loginResult != null) {
        token.value = loginResult;
        final userInfo = await _repo.getCurrentUser(loginResult.accessToken);
        if (userInfo != null) {
          user.value = userInfo;
        } else {
          signupError.value = '회원가입 후 유저정보를 가져오지 못했습니다';
        }
      } else {
        signupError.value = '회원가입 실패';
      }
    }
    isLoading.value = false;
  }

  Future<void> logout() async {
    await _repo.logout();
    token.value = null;
    user.value = null;
  }

  Future<bool> uploadAndSetProfileImage(File imageFile) async {
    final access = TokenStorage.accessToken;
    final currentUser = user.value;
    if (access == null || currentUser == null) return false;
    final uploadResult = await _imageApi.uploadImage(imageFile);
    if (uploadResult == null) {
      return false;
    }
    int? imageId = int.tryParse(uploadResult);
    final tryBodies = <Map<String, dynamic>>[];
    if (imageId != null) {
      tryBodies.add({'profileImageId': imageId});
    }
    for (final body in tryBodies) {
      try {
        final updated = await _repo.updateUser(access, currentUser.id, body);
        if (updated != null) {
          user.value = updated;
          return true;
        }
      } catch (e) {
        print('uploadAndSetProfileImage: updateUser exception: $e');
      }
    }
    return false;
  }

  bool get isLoggedIn => _repo.isLoggedIn;

  String? get accessToken => TokenStorage.accessToken;

  Future<void> refreshCurrentUser() async {
    final access = TokenStorage.accessToken;
    if (access == null) return;
    final userInfo = await _repo.getCurrentUser(access);
    if (userInfo != null) {
      user.value = userInfo;
    }
  }

  String? fullProfileImageUrl(String? url) {
    if (url == null) return null;
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    final base = dotenv.env['BASE_URL'] ?? '';
    if (base.isEmpty) return url;
    if (url.startsWith('/')) return base + url;
    return '$base/$url';
  }
}
