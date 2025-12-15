class SignupRequest {
  final String email;
  final String password;
  final String name;
  final String language;

  SignupRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.language,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'language': language,
      };
}