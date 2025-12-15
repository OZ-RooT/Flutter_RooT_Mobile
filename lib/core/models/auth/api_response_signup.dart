class ApiResponseSignup {
  final bool success;
  final String? message;
  final String? errorCode;

  ApiResponseSignup({
    required this.success,
    this.message,
    this.errorCode,
  });

  factory ApiResponseSignup.fromJson(Map<String, dynamic> json) {
    return ApiResponseSignup(
      success: json['success'] ?? false,
      message: json['message'],
      errorCode: json['errorCode'],
    );
  }
}