import 'package:sod_new/models/districtinfomodel.dart';
import 'package:sod_new/models/subdistrictmodel.dart';

class DistrictModel {
  DistrictInfoModel? district;
  List<SubDistrictModel>? subDistricts;

  DistrictModel({required this.district, required this.subDistricts});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      district = DistrictInfoModel(
        id: json['id'],
        name: json['name'],
      );
    }

    if (json['subdistricts'] != null && json['subdistricts'] is List) {
      subDistricts = (json['subdistricts'] as List)
          .map((e) => SubDistrictModel.fromJson(e))
          .toList();
    } else {
      subDistricts = [];
    }
  }
}
