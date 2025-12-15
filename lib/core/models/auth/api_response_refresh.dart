import 'refresh_response.dart';

class ApiResponseRefresh {
  final bool success;
  final RefreshResponse? data;
  final String? message;
  final String? errorCode;

  ApiResponseRefresh({
    required this.success,
    this.data,
    this.message,
    this.errorCode,
  });

  factory ApiResponseRefresh.fromJson(Map<String, dynamic> json) {
    return ApiResponseRefresh(
      success: json['success'] ?? false,
      data: json['data'] != null ? RefreshResponse.fromJson(json['data']) : null,
      message: json['message'],
      errorCode: json['errorCode'],
    );
  }
}