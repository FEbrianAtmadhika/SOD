import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sod_new/bloc/Auth/auth_bloc.dart';
import 'package:sod_new/bloc/District/district_bloc.dart';
import 'package:sod_new/models/addressmodel.dart';
import 'package:sod_new/models/districtmodel.dart';
import 'package:sod_new/models/editaddressmodel.dart';
import 'package:sod_new/models/subdistrictmodel.dart';
import '../shared/theme.dart';
import '../widgets/button.dart';
import '../widgets/form.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({
    super.key,
  });

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  List<String> status = <String>['inactive', 'active'];
  List<String?> district = <String?>[];
  List<String?> subDistrict = <String?>[];
  final _formKey = GlobalKey<FormState>();
  String? dropdownValueStatus;
  String? dropdownValuedistrict;
  String? dropdownValuesubdistrict;
  String type = 'home';
  TextEditingController? name = TextEditingController();
  TextEditingController? phone = TextEditingController();
  TextEditingController? address = TextEditingController();
  TextEditingController? latitude = TextEditingController();
  TextEditingController? longitude = TextEditingController();
  int? id;
  bool isFirstLoad = true;
  AddressModel? editdata;
  @override
  void didChangeDependencies() {
    if (isFirstLoad) {
      context.read<DistrictBloc>().add(DistrictGetAll());
    } else {
      isFirstLoad = true;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    name!.dispose();
    phone!.dispose();
    address!.dispose();
    latitude!.dispose();
    longitude!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundgreenColor,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: greenColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Tambah Alamat",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthEditAddressSuccess) {
          Navigator.of(context).popUntil(
            (route) {
              return route.settings.name == '/address';
            },
          );
        }
        if (state is AuthAddAddressFailed) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Gagal Mengedit Alamat Anda")));
        }
      }, builder: (context, authstate) {
        if (authstate is AuthSuccess) {
          if (isFirstLoad) {
            id = int.parse(
                ModalRoute.of(context)!.settings.arguments.toString());
            editdata = authstate.data.address!.firstWhere(
              (element) {
                return element.id == id;
              },
            );
            dropdownValueStatus = editdata?.status ?? status.first;
            dropdownValuedistrict = editdata!.subDistrict!.districtInfo!.name!;
            dropdownValuesubdistrict = editdata!.subDistrict!.name!;
            type = editdata?.type ?? 'home';
            name!.text = editdata?.receiverName ?? '';
            phone!.text = editdata?.receiverPhone ?? '';
            address!.text = editdata?.address ?? '';
            latitude!.text = editdata?.latitude ?? '';
            longitude!.text = editdata?.longitude ?? '';

            isFirstLoad = false;
          }
          return BlocConsumer<DistrictBloc, DistrictState>(
            listener: (context, state) {
              if (state is DistrictSuccess) {
                setState(() {
                  district =
                      state.district.map((e) => e.district!.name).toList();
                  DistrictModel temp = state.district.firstWhere(
                    (element) {
                      return element.district!.name == dropdownValuedistrict;
                    },
                  );
                  subDistrict = temp.subDistricts!
                      .map(
                        (e) => e.name,
                      )
                      .toList();
                });
              }
            },
            builder: (context, state) {
              if (state is DistrictSuccess) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '* ',
                                              style: redTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Nama Penerima',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      CustomFormField(
                                        title: "Nama Lengkap",
                                        controller: name,
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return 'Masukkan Nama Penerima';
                                          }
                                          return null;
                                        },
                                        onSaved: (p0) {
                                          name!.text = p0!;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '* ',
                                              style: redTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Nama Telepon',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: formColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: CustomFormField(
                                                title: "081337708798",
                                                controller: phone,
                                                validator: (p0) {
                                                  if (p0!.isEmpty) {
                                                    return 'Masukkan Nomor Telepon Penerima';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (p0) {
                                                  phone!.text = p0!;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '* ',
                                              style: redTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Kecamatan',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DropdownButton<String>(
                                        value: dropdownValuedistrict,
                                        onChanged: (String? value) {
                                          setState(() {
                                            dropdownValuedistrict = value!;
                                            DistrictModel temp =
                                                state.district.firstWhere(
                                              (element) =>
                                                  element.district!.name ==
                                                  dropdownValuedistrict,
                                            );
                                            subDistrict = temp.subDistricts!
                                                .map((e) => e.name)
                                                .toList();

                                            // Reset the subdistrict dropdown value when the district changes
                                            dropdownValuesubdistrict =
                                                subDistrict.isNotEmpty
                                                    ? subDistrict.first!
                                                    : 'Pilih Kecamatan Dulu';
                                          });
                                        },
                                        items: district
                                            .map<DropdownMenuItem<String>>(
                                                (String? value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value!.toUpperCase()),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '* ',
                                              style: redTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Kelurahan',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DropdownButton<String>(
                                        value: dropdownValuesubdistrict,
                                        onChanged: (String? value) {
                                          setState(() {
                                            dropdownValuesubdistrict = value!;
                                          });
                                        },
                                        items: subDistrict
                                            .map<DropdownMenuItem<String>>(
                                                (String? value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value!),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: 'Alamat',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: medium,
                                          ),
                                        ),
                                      ),
                                      CustomFormFieldText(
                                        title:
                                            "Provinsi, Kota, Kecamatan, Kode Pos",
                                        controller: address,
                                        maxLines: 5,
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return 'Masukkan Alamat Penerima';
                                          }
                                          return null;
                                        },
                                        onSaved: (p0) {
                                          address!.text = p0!;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: 'Koordinat Latitude',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: medium,
                                          ),
                                        ),
                                      ),
                                      CustomFormField(
                                        title: "-6.2088",
                                        controller: latitude,
                                        
                                        onSaved: (p0) {
                                          latitude!.text = p0!;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '* ',
                                              style: redTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Longitude',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      CustomFormField(
                                        title: "106.8456",
                                        controller: longitude,
                                        
                                        onSaved: (p0) {
                                          longitude!.text = p0!;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '* ',
                                              style: redTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Gunakan Alamat',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: formColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: DropdownButton<String>(
                                          value: dropdownValueStatus,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          elevation: 16,
                                          underline: Container(
                                            height: 0,
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              dropdownValueStatus = value!;
                                            });
                                          },
                                          items: status
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                  '${value[0].toUpperCase()}${value.substring(1)}'),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '* ',
                                              style: redTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Simpan Alamat Sebagai',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: medium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    OutlinedButton(
                                      style: ButtonStyle(
                                        side:
                                            WidgetStatePropertyAll<BorderSide>(
                                          BorderSide(
                                              color: type == 'home'
                                                  ? greenColor
                                                  : Colors.transparent),
                                        ),
                                        backgroundColor:
                                            WidgetStatePropertyAll(formColor),
                                        shape: WidgetStatePropertyAll<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          type = 'home';
                                        });
                                      },
                                      child: Text(
                                        "Home",
                                        style: type == 'home'
                                            ? greenTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: medium,
                                              )
                                            : blackTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: medium,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    OutlinedButton(
                                      style: ButtonStyle(
                                        side:
                                            WidgetStatePropertyAll<BorderSide>(
                                          BorderSide(
                                              color: type == 'office'
                                                  ? greenColor
                                                  : Colors.transparent),
                                        ),
                                        backgroundColor:
                                            WidgetStatePropertyAll(formColor),
                                        shape: WidgetStatePropertyAll<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          type = 'office';
                                        });
                                      },
                                      child: Text(
                                        "Office",
                                        style: type == 'office'
                                            ? greenTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: medium,
                                              )
                                            : blackTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: medium,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButtonFilled(
                                    text: "Simpan",
                                    onPressed: () {
                                      setState(() {});
                                      if (dropdownValuedistrict!.isEmpty ||
                                          dropdownValuesubdistrict ==
                                              'Pilih Kecamatan Dulu') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Silahkan Pilih Kecamatan dan Kelurahan Terlebih Dahulu')));
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        DistrictModel? temp1 =
                                            state.district.firstWhere(
                                          (element) {
                                            return element.district!.name ==
                                                dropdownValuedistrict;
                                          },
                                        );
                                        SubDistrictModel? temp2 =
                                            temp1.subDistricts!.firstWhere(
                                          (element) {
                                            return element.name ==
                                                dropdownValuesubdistrict;
                                          },
                                        );

                                        context.read<AuthBloc>().add(
                                            AuthEditAddress(
                                                authstate.data,
                                                EditAddressModel(
                                                    id: id,
                                                    address: address!.text,
                                                    latitude: latitude!.text,
                                                    longitude: longitude!.text,
                                                    receivername: name!.text,
                                                    receiverphone: phone!.text,
                                                    status: dropdownValueStatus,
                                                    subdistrictid: temp2.id,
                                                    type: type),
                                                SubDistrictModel(
                                                    description:
                                                        temp2.description,
                                                    districtId:
                                                        temp2.districtId,
                                                    districtInfo:
                                                        temp1.district,
                                                    fee: temp2.fee,
                                                    id: temp2.id,
                                                    name: temp2.name,
                                                    status: temp2.status)));
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is DistrictLoading) {
                return const Center(
                  child: Text('Sedang Mengambil Data Kecamatan Dan Kelurahan'),
                );
              } else {
                return const Center(
                  child: Text('Gagal Mengambil Data Kecamatan Dan Kelurahan'),
                );
              }
            },
          );
        } else {
          return const Center();
        }
      }),
    );
  }
}
