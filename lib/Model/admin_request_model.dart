import 'package:uuid/uuid.dart';

class AccountRequest {
  final String? imageSrc;
  final String? email;
  final String? password;
  final String? status;
  final String? id;
  final String? name;
  final String? statusId;

  AccountRequest(
      {required this.imageSrc,
      required this.email,
      required this.password,
      this.statusId,
      this.id,
      required this.name,
      this.status});

  factory AccountRequest.fromJson(Map<String, dynamic> json) {
    return AccountRequest(
      name: json['name'] as String,
      statusId: json['statusId'] as String,
      id: json['status'] as String,
      status: json['status'] as String,
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
      'status': status,
      'id': id,
      'statusId': statusId,
      'name': name,
    };
  }
}
