import 'dart:convert';

import 'package:sod_new/models/addaddressmodel.dart';
import 'package:sod_new/models/addressmodel.dart';
import 'package:sod_new/models/authmodel.dart';
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
      request.fields['recever_phone'] = data.receiverphone.toString();
      request.fields['sub_district_id'] =
          data.subdistrictid!.districtId.toString();
      request.fields['address'] = data.address.toString();
      request.fields['type'] = data.type.toString();
      request.fields['latitude'] = data.latitude.toString();
      request.fields['longtitude'] = data.longitude.toString();
      request.fields['status'] = data.status.toString();

      final response = await request.send();

      final responseData = await http.Response.fromStream(response);
      print(responseData.body);
      Map<String, dynamic> rawdata = jsonDecode(responseData.body);
      if (rawdata['code'] == 200 && rawdata['status'] == 'success') {
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

        return user;
      } else {
        return rawdata['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
