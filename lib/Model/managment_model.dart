class ManagementModel {

  final String? email;
  final String? password;
  final String? name;

  final String? id;

  ManagementModel(
      {
        required this.email,
        required this.password,

        this.id,
        required this.name});

  factory ManagementModel.fromJson(Map<String, dynamic> json) {
    return ManagementModel(
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
