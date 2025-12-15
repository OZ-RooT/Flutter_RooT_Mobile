class ApiResponseChangePassword {
  final bool success;
  final String? message;
  final String? errorCode;

  ApiResponseChangePassword({
    required this.success,
    this.message,
    this.errorCode,
  });

  factory ApiResponseChangePassword.fromJson(Map<String, dynamic> json) {
    return ApiResponseChangePassword(
      success: json['success'] ?? false,
      message: json['message'],
      errorCode: json['errorCode'],
    );
  }
}