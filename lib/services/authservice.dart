import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sod_new/models/authmodel.dart';
import 'package:sod_new/models/loginmodel.dart';
import 'package:sod_new/models/registermodel.dart';
import 'package:sod_new/services/securestorageservices.dart';
import 'dart:convert';

import 'package:sod_new/shared/baseurl.dart';

class AuthService extends ChangeNotifier {
  final String baseUrl = BaseUrl().url;

  Future<void> register(RegisterModel data) async {
    try {
      final res = await http.post(
        Uri.parse(
          '$baseUrl/register',
        ),
        body: {
          'name': data.name,
          'email': data.email,
          'password': data.password,
          'password_confirmation': data.passwordconfirmed
        },
      );
      Map<String, dynamic> rawdata = jsonDecode(res.body);
      if (rawdata['code'] == 200) {
        return;
      } else {
        throw rawdata['message'];
      }
    } catch (e) {
      throw e is SocketException ? 'Tidak Terkoneksi Server' : e.toString();
    }
  }

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
        throw rawdata['message'];
      }
    } catch (e) {
      throw e is SocketException ? 'Tidak Terkoneksi Server' : e.toString();
    }
  }

  Future<void> logout() async {
    try {
      String? token = await SecureStorageServices().getToken();
      final url = "$baseUrl/logout";
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': token,
        },
      );

      Map<dynamic, dynamic> rawdata = jsonDecode(res.body);
      if (rawdata['code'] == 200 && rawdata['status'] == "success") {
        await SecureStorageServices().clearLocalStorage();
      } else {
        throw rawdata['message'];
      }
    } catch (e) {
      throw e is SocketException ? 'Tidak Terkoneksi Server' : e.toString();
    }
  }
}
