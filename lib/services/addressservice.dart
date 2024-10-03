import 'dart:convert';

import 'package:sod_new/models/addaddressmodel.dart';
import 'package:sod_new/models/addressmodel.dart';
import 'package:sod_new/models/authmodel.dart';
import 'package:sod_new/models/districtmodel.dart';
import 'package:sod_new/models/editaddressmodel.dart';
import 'package:sod_new/models/subdistrictmodel.dart';
import 'package:sod_new/services/securestorageservices.dart';
import 'package:sod_new/shared/baseurl.dart';
import 'package:http/http.dart' as http;

class Addressservice {
  String baseUrl = BaseUrl().url;

  Future<AuthModel> addAddress(AuthModel user, AddAddressModel data) async {
    try {
      String? token = await SecureStorageServices().getToken();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/user-address'),
      );
      request.headers['Authorization'] = token;

      request.fields['receiver_name'] = data.receivername.toString();
      request.fields['receiver_phone'] = data.receiverphone.toString();
      request.fields['sub_district_id'] =
          data.subdistrictid!.districtId.toString();
      request.fields['address'] = data.address.toString();
      request.fields['type'] = data.type.toString();
      request.fields['latitude'] = data.latitude.toString();
      request.fields['longitude'] = data.longitude.toString();
      request.fields['status'] = data.status.toString();

      final response = await request.send();

      final responseData = await http.Response.fromStream(response);
      Map<String, dynamic> rawdata = jsonDecode(responseData.body);
      if (responseData.statusCode == 201) {
        user.address!.add(AddressModel(
            id: rawdata['data']['id'],
            address: data.address,
            latitude: data.latitude,
            longitude: data.longitude,
            receiverName: data.receivername,
            receiverPhone: data.receivername,
            status: data.status,
            subDistrict: data.subdistrictid,
            subDistrictId: data.subdistrictid!.id,
            type: data.type,
            userId: user.id));
        if (data.status == 'active') {
          for (var element in user.address!) {
            if (rawdata['data']['id'] != element.id) {
              element.status = 'inactive';
            }
          }
        }
        return user;
      } else {
        return rawdata['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DistrictModel>> getAllDistrict() async {
    List<DistrictModel> districts = [];
    try {
      String? token = await SecureStorageServices().getToken();
      // Send the request
      final res = await http.get(Uri.parse('$baseUrl/districts'), headers: {
        'Authorization': token,
      });
      if (res.statusCode == 200) {
        Map<String, dynamic> rawdata = jsonDecode(res.body);

        List<dynamic> rawDistricts = rawdata['data'];
        for (var district in rawDistricts) {
          DistrictModel districtModel = DistrictModel.fromJson(district);
          districts.add(districtModel);
        }
      } else {
        // Handle non-200 HTTP status codes
        throw Exception(
            "Failed to load districts. Status code: ${res.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
    return districts;
  }

  Future<AuthModel> editAddress(
      AuthModel user, EditAddressModel data, SubDistrictModel data2) async {
    try {
      String? token = await SecureStorageServices().getToken();

      // Prepare request headers
      var headers = {
        'Authorization': token,
        'Content-Type': 'application/json',
      };

      var body = jsonEncode({
        'receiver_name': data.receivername.toString(),
        'receiver_phone': data.receiverphone.toString(),
        'sub_district_id': data.subdistrictid!.toString(),
        'address': data.address.toString(),
        'type': data.type.toString(),
        'latitude': data.latitude.toString(),
        'longitude': data.longitude.toString(),
        'status': data.status.toString(),
      });

      var response = await http.put(
        Uri.parse('$baseUrl/user-address/${data.id}'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        AddressModel temp = AddressModel(
            id: data.id,
            address: data.address,
            latitude: data.latitude,
            longitude: data.longitude,
            receiverName: data.receivername,
            receiverPhone: data.receivername,
            status: data.status,
            subDistrict: data2,
            subDistrictId: data.subdistrictid,
            type: data.type,
            userId: user.id);

        int index = user.address!.indexWhere(
          (element) => element.id == data.id,
        );
        user.address![index] = temp;
        if (data.status == 'active') {
          for (var element in user.address!) {
            if (data.id != element.id) {
              element.status = 'inactive';
            }
          }
        }
        return user;
      } else {
        Map<String, dynamic> rawdata = jsonDecode(response.body);
        return rawdata['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthModel> delAddress(AuthModel user, int id) async {
    try {
      String? token = await SecureStorageServices().getToken();

      var uri = Uri.parse('$baseUrl/user-address/$id');

      final response = http.Request('DELETE', uri)
        ..headers.addAll({
          'Authorization': token,
          'Content-Type': 'application/json',
        });

      var streamedResponse = await response.send();
      var finalResponse = await http.Response.fromStream(streamedResponse);

      Map<String, dynamic> rawdata = json.decode(finalResponse.body);

      if (finalResponse.statusCode == 200) {
        int index = user.address!.indexWhere(
          (element) {
            return element.id == id;
          },
        );
        user.address!.removeAt(index);
        return user;
      } else {
        throw rawdata['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
