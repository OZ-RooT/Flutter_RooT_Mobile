class RefreshResponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;

  RefreshResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });

  factory RefreshResponse.fromJson(Map<String, dynamic> json) {
    return RefreshResponse(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      tokenType: json['tokenType'] ?? '',
    );
  }
}