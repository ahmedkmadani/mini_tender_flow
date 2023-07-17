class HotModel {
  final String? imageSrc;
  final String? email;
  final String? password;
  final String? name;

  HotModel(
      {required this.imageSrc,
      required this.email,
      required this.password,
      required this.name});

  factory HotModel.fromJson(Map<String, dynamic> json) {
    return HotModel(
      name: json['name'] as String,
      imageSrc: json['imageSrc'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageSrc': imageSrc,
      'email': email,
      'password': password,
      'name': name,
    };
  }
}
