import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sod_new/models/addtransactionmodel.dart';
import 'package:sod_new/services/securestorageservices.dart';
import 'package:sod_new/shared/baseurl.dart';
import 'package:sod_new/models/transactionmodel.dart';
import 'package:http/http.dart' as http;

class TransactionService extends ChangeNotifier {
  String? baseurl = BaseUrl().url;

  Future<List<TransactionModel>> getAllTransaction() async {
    try {
      String? token = await SecureStorageServices().getToken();
      List<TransactionModel> temp = [];
      final res = await http
          .get(Uri.parse('$baseurl/transactions?status=done'), headers: {
        'Authorization': token,
      });
      Map<String, dynamic> rawdata = jsonDecode(res.body);
      if (rawdata['code'] == 200 && rawdata['status'] == "success") {
        for (var element in rawdata['data']) {
          temp.add(TransactionModel.fromJson(element));
        }
        return temp;
      } else {
        throw rawdata['message'];
      }
    } catch (e) {
      throw e is SocketException ? 'Tidak Terkoneksi Server' : e.toString();
    }
  }

  // Future<String> addTransaction(AddTransactionModel data) async {
  //   try {
  //     String? token = await SecureStorageServices().getToken();
  //     var url = Uri.parse('$baseurl/transactions');
  //     var request = http.MultipartRequest('POST', url);
  //     request.headers['Authorization'] = token;
  //     request.headers['Content-Type'] = 'application/json';
  //     request.fields['total_price'] = data.totalprice.toString();
  //     request.fields['checked_items'] =
  //         jsonEncode([data.listitem!.map((item) => item.checkeditem).toList()]);
  //     request.fields['quantities'] = jsonEncode({
  //       for (var item in data.listitem!)
  //         item.checkeditem.toString(): item.quantity
  //     });
  //     request.fields['shipping_price'] = data.shippingprice.toString();
  //     request.fields['app_fee'] = data.appfee.toString();
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> rawData = jsonDecode(response.body);
  //       return rawData['message'];
  //     } else {
  //       throw Exception(
  //           'Failed to post transaction. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> addTransaction(AddTransactionModel data) async {
    try {
      String? token = await SecureStorageServices().getToken();
      var url = Uri.parse('$baseurl/transactions');

      // Constructing request body
      Map<String, dynamic> requestBody = {
        "total_price": data.totalprice,
        "checked_items":
            data.listitem!.map((item) => item.checkeditem).toList(),
        "quantities": {
          for (var item in data.listitem!)
            item.checkeditem.toString(): item.quantity
        },
        "shipping_price": data.shippingprice,
        "app_fee": data.appfee,
      };

      // Send POST request to server
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode(requestBody),
      );
      Map<String, dynamic> rawdata = jsonDecode(response.body);

      // Check if transaction is successful
      if (response.statusCode == 201 && rawdata['status'] == 'success') {
      } else {
        throw rawdata['message'];
      }
    } catch (e) {
      throw e is SocketException ? 'Tidak Terkoneksi Server' : e.toString();
    }
  }

  Future<List<TransactionModel>> cancelTransaction(
      List<TransactionModel> data, int id) async {
    try {
      String? token = await SecureStorageServices().getToken();

      // Prepare request headers
      var headers = {
        'Authorization': token,
        'Content-Type': 'application/json',
      };

      var body = jsonEncode({'status': 'cancelled'});

      var response = await http.put(
        Uri.parse('$baseurl/transactions/$id/status'),
        headers: headers,
        body: body,
      );
      Map<String, dynamic> rawdata = json.decode(response.body);
      if (rawdata['code'] == 200 && rawdata['status'] == 'success') {
        int index = data.indexWhere(
          (element) => element.id == id,
        );

        data[index].status = 'cancelled';
        return data;
      } else {
        throw rawdata['message'];
      }
    } catch (e) {
      throw e is SocketException ? 'Tidak Terkoneksi Server' : e.toString();
    }
  }
}
