class EditAddressModel {
  int? id;
  String? receivername;
  String? receiverphone;
  int? subdistrictid;
  String? address;
  String? type;
  String? latitude;
  String? longitude;
  String? status;

  EditAddressModel(
      {required this.id,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.receivername,
      required this.receiverphone,
      required this.status,
      required this.subdistrictid,
      required this.type});
}
