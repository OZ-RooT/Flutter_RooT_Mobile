class ApiResponseError {
  final String? message;
  final String? errorCode;

  ApiResponseError({this.message, this.errorCode});

  factory ApiResponseError.fromJson(Map<String, dynamic> json) {
    return ApiResponseError(
      message: json['message'],
      errorCode: json['errorCode'],
    );
  }
}