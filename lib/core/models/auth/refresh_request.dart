class RefreshRequest {
  final String refreshToken;

  RefreshRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => {
        'refreshToken': refreshToken,
      };
}