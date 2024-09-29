import 'package:sod_new/models/subdistrictmodel.dart';

class AddAddressModel {
  String? receivername;
  String? receiverphone;
  SubDistrict? subdistrictid;
  String? address;
  String? type;
  String? latitude;
  String? longitude;
  String? status;

  AddAddressModel(
      {required this.address,
      required this.latitude,
      required this.longitude,
      required this.receivername,
      required this.receiverphone,
      required this.status,
      required this.subdistrictid,
      required this.type});
}
