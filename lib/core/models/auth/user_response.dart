class UserResponse {
  final int id;
  final String email;
  final String name;
  final String? profileImageUrl;
  final int? rating;
  final String? language;

  UserResponse({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
    this.rating,
    this.language,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImageUrl: json['profileImage']?['url'],
      rating: json['rating'],
      language: json['language'],
    );
  }
}