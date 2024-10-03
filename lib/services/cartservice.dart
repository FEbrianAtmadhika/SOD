import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sod_new/models/addcartmodel.dart';
import 'package:sod_new/models/cartmodel.dart';
import 'package:sod_new/services/securestorageservices.dart';
import 'package:sod_new/shared/baseurl.dart';
import 'package:http/http.dart' as http;

class CartService extends ChangeNotifier {
  String? baseUrl = BaseUrl().url;

  Future<List<CartModel>> getAllCart() async {
    try {
      String? token = await SecureStorageServices().getToken();
      List<CartModel> temp = [];
      final res = await http.get(Uri.parse('$baseUrl/cart'), headers: {
        'Authorization': token,
      });
      Map<String, dynamic> rawdata = jsonDecode(res.body);
      if (rawdata['code'] == 200 && rawdata['status'] == "success") {
        for (var element in rawdata['data']['carts']) {
          temp.add(CartModel.formJson(element));
        }
        return temp;
      } else {
        return rawdata['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addCart(AddCartModel data) async {
    try {
      String? token = await SecureStorageServices().getToken();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/cart'),
      );
      request.headers['Authorization'] = token;

      request.fields['variant_id'] = data.variantid.toString();
      request.fields['quantity'] = data.quantity.toString();

      final response = await request.send();

      final responseData = await http.Response.fromStream(response);
      print(responseData.body);
      Map<String, dynamic> rawdata = jsonDecode(responseData.body);
      if (rawdata['code'] == 200 && rawdata['status'] == 'success') {
        return rawdata['status'];
      } else {
        return rawdata['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CartModel>> delCart(
      List<CartModel> data, List<int> idcart) async {
    try {
      String? token = await SecureStorageServices().getToken();

      var uri = Uri.parse('$baseUrl/cart');

      final response = http.Request('DELETE', uri)
        ..headers.addAll({
          'Authorization': token,
          'Content-Type': 'application/json',
        })
        ..body = jsonEncode({'items': idcart});

      var streamedResponse = await response.send();
      var finalResponse = await http.Response.fromStream(streamedResponse);

      Map<String, dynamic> rawdata = json.decode(finalResponse.body);

      if (rawdata['code'] == 200 && rawdata['status'] == 'success') {
        for (var element in idcart) {
          data.removeWhere((item) => item.id == element);
        }
        return data;
      } else {
        throw Exception(rawdata['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
