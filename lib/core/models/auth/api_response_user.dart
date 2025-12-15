import 'user_response.dart';

class ApiResponseUser {
  final bool success;
  final UserResponse? data;
  final String? message;
  final String? errorCode;

  ApiResponseUser({
    required this.success,
    this.data,
    this.message,
    this.errorCode,
  });

  factory ApiResponseUser.fromJson(Map<String, dynamic> json) {
    return ApiResponseUser(
      success: json['success'] ?? false,
      data: json['data'] != null ? UserResponse.fromJson(json['data']) : null,
      message: json['message'],
      errorCode: json['errorCode'],
    );
  }
}