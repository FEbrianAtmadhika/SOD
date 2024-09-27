import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  int? id;
  String? token;
  String? name;
  int? role;
  String? email;
  String? password;
  AuthModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.role,
      required this.token,
      required this.password});

  AuthModel.formJson(Map<String, dynamic> json) {
    id = json['user']['id'];
    token = json['token'];
    name = json['user']['name'];
    role = json['user']['role_id'];
    email = json['user']['email'];
  }
}
