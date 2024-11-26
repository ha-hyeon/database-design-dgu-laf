class User {
  final int userId;
  final String username;
  final String password;
  final String phoneNumber;

  User({
    required this.userId,
    required this.username,
    required this.password,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
      password: json['password'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'password': password,
      'phone_number': phoneNumber,
    };
  }
}
