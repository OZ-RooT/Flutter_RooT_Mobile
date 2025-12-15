class ApiResponseBase {
  final bool success;
  final String? message;
  final String? errorCode;

  ApiResponseBase({
    required this.success,
    this.message,
    this.errorCode,
  });

  factory ApiResponseBase.fromJson(Map<String, dynamic> json) {
    return ApiResponseBase(
      success: json['success'] ?? false,
      message: json['message'],
      errorCode: json['errorCode'],
    );
  }
}