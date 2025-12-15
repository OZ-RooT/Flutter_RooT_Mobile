class User {
  final int id;
  final String email;
  final String name;
  final String? profileImageUrl;
  final int? rating;
  final String? language;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
    this.rating,
    this.language,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImageUrl: json['profileImage']?['url'],
      rating: json['rating'],
      language: json['language'],
    );
  }
}