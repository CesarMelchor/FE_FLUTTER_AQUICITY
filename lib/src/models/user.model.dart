class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String profilePhoto;
  final String status;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.profilePhoto,
    required this.status
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      email: json['email'],
      profilePhoto: json['profilePhoto'],
      status: json['status'],
    );
  }
}
