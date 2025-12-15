class UserMeResponse {
  final int id;
  final String email;
  final String name;
  final String? profileImageUrl;
  final int? rating;
  final String? language;

  UserMeResponse({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
    this.rating,
    this.language,
  });

  factory UserMeResponse.fromJson(Map<String, dynamic> json) {
    return UserMeResponse(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImageUrl: json['profileImage']?['url'],
      rating: json['rating'],
      language: json['language'],
    );
  }
}