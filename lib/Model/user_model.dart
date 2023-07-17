class UserModel {

  final String? email;
  final String? password;
  final String? name;
  final String? id;

  UserModel(
      {
      required this.email,
      required this.password,
      this.id,
      required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'id': id,
    };
  }
}
