import 'package:flutter/material.dart';
import 'package:sod_new/models/addressmodel.dart';

class AuthModel extends ChangeNotifier {
  int? id;
  String? token;
  String? name;
  int? role;
  String? email;
  String? password;
  List<AddressModel>? address;
  AuthModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.role,
      required this.address,
      required this.token,
      required this.password});

  AuthModel.formJson(Map<String, dynamic> json) {
    id = json['user']['id'];
    token = json['token'];
    name = json['user']['name'];
    role = json['user']['role_id'];
    email = json['user']['email'];
    if (json['user']['user_address'] != null) {
      address = (json['user']['user_address'] as List)
          .map((i) => AddressModel.fromJson(i))
          .toList();
    }
  }
}
