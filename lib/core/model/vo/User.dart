class User {
  final String id;
  final String email;
  // 필요한 다른 필드들 추가

  User({
    required this.id,
    required this.email,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
    );
  }
}