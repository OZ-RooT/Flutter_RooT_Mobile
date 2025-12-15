import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/auth/login_request.dart';
import '../../models/auth/signup_request.dart';
import '../../models/auth/api_response_user.dart';
import '../../models/auth/api_response_token.dart';

class AuthApi {
  static String get _baseUrl => dotenv.env['BASE_URL'] ?? '';

  Future<ApiResponseToken> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    return ApiResponseToken.fromJson(jsonDecode(response.body));
  }

  Future<ApiResponseUser> signup(SignupRequest request) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/v1/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    print(response.body);
    return ApiResponseUser.fromJson(jsonDecode(response.body));
  }
}
