import 'token_response.dart';

class ApiResponseToken {
  final bool success;
  final TokenResponse? data;
  final String? message;
  final String? errorCode;

  ApiResponseToken({
    required this.success,
    this.data,
    this.message,
    this.errorCode,
  });

  factory ApiResponseToken.fromJson(Map<String, dynamic> json) {
    return ApiResponseToken(
      success: json['success'] ?? false,
      data: json['data'] != null ? TokenResponse.fromJson(json['data']) : null,
      message: json['message'],
      errorCode: json['errorCode'],
    );
  }
}