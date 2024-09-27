import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sod_new/models/categorymodel.dart';
import 'package:sod_new/models/kacaumodel.dart';
import 'package:http/http.dart' as http;
import 'package:sod_new/models/productmodel.dart';
import 'package:sod_new/shared/baseurl.dart';

class ProductServices extends ChangeNotifier {
  String? baseUrl = BaseUrl().url;

  Future<KacauModel> getAllProduct() async {
    KacauModel temp = KacauModel(category: [], product: []);
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/home'),
      );
      Map<String, dynamic> rawdata = jsonDecode(res.body);

      if (rawdata['code'] == 200 && rawdata['status'] == "success") {
        if (rawdata['data']['categories'] != null &&
            rawdata['data']['categories'] is List) {
          List<dynamic> categori = rawdata['data']['categories'];
          temp.category!.add(CategoryModel(
              id: 0,
              name: 'Semua Jenis',
              slug: 'semua-jenis',
              image: 'https://m.sod.my.id/assets/landing/images/LogoSod.png'));
          for (var element in categori) {
            temp.category!.add(CategoryModel.fromJson(element));
          }
        }

        if (rawdata['data']['products'] != null &&
            rawdata['data']['products'] is List) {
          List<dynamic> product = rawdata['data']['products'];
          for (var element in product) {
            temp.product!.add(ProductModel.fromJson(element));
          }
        }

        return temp;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
