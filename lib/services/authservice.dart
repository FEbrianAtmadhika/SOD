import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sod_new/models/authmodel.dart';
import 'package:sod_new/models/loginmodel.dart';
import 'package:sod_new/services/securestorageservices.dart';
import 'dart:convert';

import 'package:sod_new/shared/baseurl.dart';

class AuthService extends ChangeNotifier {
  final String baseUrl = BaseUrl().url;

  // Future<UserModel> register(SignUpFormModel data) async {
  //   try {
  //     final res = await http.post(
  //       Uri.parse(
  //         '$baseUrl/register',
  //       ),
  //       body: {'name': data.name, 'email': data.email, 'password': data.email},
  //     );
  //     Map<String, dynamic> rawdata = jsonDecode(res.body);
  //     print(rawdata);
  //     if (rawdata['code'] == 200) {
  //       UserModel user = UserModel(
  //           id: rawdata['user']['id'],
  //           name: rawdata['user']['name'],
  //           email: rawdata['user']['email'],
  //           role: rawdata['user']['role_id'],
  //           createdAt: rawdata['user']['created_at'],
  //           updatedAt: rawdata['user']['update_at'],
  //           token: rawdata['access_token'],
  //           password: data.password,
  //           tokenType: rawdata['token_type']);
  //       await storeCredentialToLocal(user);
  //       return user;
  //     } else {
  //       throw rawdata['message'];
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<AuthModel> login(LoginModel data) async {
    try {
      final res = await http.post(
        Uri.parse(
          '$baseUrl/login',
        ),
        body: {'email': data.email, 'password': data.password},
      );
      Map<String, dynamic> rawdata = jsonDecode(res.body);
      if (rawdata['code'] == 200 && rawdata['status'] == "success") {
        final auth = AuthModel.formJson(rawdata['data']);
        auth.password = data.password;
        await SecureStorageServices().storeCredentialToLocal(auth);
        return auth;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      String? token = await SecureStorageServices().getToken();
      final url =
          "$baseUrl/logout"; // Check this URL for correctness, seems to be a typo
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': token, // Add 'Bearer' for authorization header
        },
      );

      Map<dynamic, dynamic> rawdata = jsonDecode(res.body);
      if (rawdata['code'] == 200 && rawdata['status'] == "success") {
        await SecureStorageServices().clearLocalStorage();
      } else {
        throw rawdata['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
