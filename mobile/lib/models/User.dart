class User {

  final int? id;
  final String? username;
  final String? email;

  User({
    this.id,
    this.username,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> data) => User(
    id: data['id'],
    username: data['username'],
    email: data['email'],
  );
  
}