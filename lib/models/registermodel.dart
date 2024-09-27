import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
  String? name;
  String? email;
  String? password;

  RegisterModel(
      {required this.name, required this.email, required this.password});
}
