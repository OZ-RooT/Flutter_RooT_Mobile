class SignupRequest {
  final String email;
  final String password;
  final String name;
  final String language;
  final int? profileImageId;

  SignupRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.language,
    this.profileImageId,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'language': language,
        if (profileImageId != null) 'profileImageId': profileImageId,
      };
}