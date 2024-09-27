import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String? email;
  String? password;

  LoginModel({required this.email, required this.password});
}
