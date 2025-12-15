class UserMe {
  final int id;
  final String email;
  final String name;
  final String? profileImageUrl;
  final int? rating;
  final String? language;

  UserMe({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
    this.rating,
    this.language,
  });

  factory UserMe.fromJson(Map<String, dynamic> json) {
    return UserMe(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImageUrl: json['profileImage']?['url'],
      rating: json['rating'],
      language: json['language'],
    );
  }
}