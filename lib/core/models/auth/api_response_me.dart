import 'user_me_response.dart';

class ApiResponseMe {
  final bool success;
  final UserMeResponse? data;
  final String? message;
  final String? errorCode;

  ApiResponseMe({
    required this.success,
    this.data,
    this.message,
    this.errorCode,
  });

  factory ApiResponseMe.fromJson(Map<String, dynamic> json) {
    return ApiResponseMe(
      success: json['success'] ?? false,
      data: json['data'] != null ? UserMeResponse.fromJson(json['data']) : null,
      message: json['message'],
      errorCode: json['errorCode'],
    );
  }
}