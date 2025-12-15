import 'favorites_response.dart';

class ApiResponseFavorites {
  final bool success;
  final FavoritesResponse? data;
  final String? message;
  final String? errorCode;

  ApiResponseFavorites({
    required this.success,
    this.data,
    this.message,
    this.errorCode,
  });

  factory ApiResponseFavorites.fromJson(Map<String, dynamic> json) {
    return ApiResponseFavorites(
      success: json['success'] ?? false,
      data: json['data'] != null ? FavoritesResponse.fromJson(json['data']) : null,
      message: json['message'],
      errorCode: json['errorCode'],
    );
  }
}