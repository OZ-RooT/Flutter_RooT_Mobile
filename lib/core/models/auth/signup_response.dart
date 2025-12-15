class SignupResponse {
  final bool success;
  final String? message;
  final String? errorCode;

  SignupResponse({
    required this.success,
    this.message,
    this.errorCode,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      success: json['success'] ?? false,
      message: json['message'],
      errorCode: json['errorCode'],
    );
  }
}