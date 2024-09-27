import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sod_new/models/authmodel.dart';
import 'package:sod_new/models/loginmodel.dart';

class SecureStorageServices {
  Future<void> storeCredentialToLocal(AuthModel user) async {
    try {
      const storage = FlutterSecureStorage();

      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    String token = '';

    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    if (value != null) {
      token = value;
    }

    return token;
  }

  Future<LoginModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();

      if (values['token'] != null) {
        final LoginModel data = LoginModel(
          email: values['email'],
          password: values['password'],
        );

        return data;
      } else {
        throw 'unauthenticated';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearLocalStorage() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }
}
