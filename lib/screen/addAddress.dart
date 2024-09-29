import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sod_new/bloc/Auth/auth_bloc.dart';
import 'package:sod_new/models/addaddressmodel.dart';
import '../shared/theme.dart';
import '../widgets/button.dart';
import '../widgets/form.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

const List<String> status = <String>['inactive', 'active'];
final _formKey = GlobalKey<FormState>();
String dropdownValueStatus = status.first;
String type = 'home';
String? name;
String? phone;
String? address;
String? latitude;
String? longitude;

class _AddAddressState extends State<AddAddress> {
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
      body: SingleChildScrollView(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              controller: null,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return 'Masukkan Nama Penerima';
                                }
                                return null;
                              },
                              onSaved: (p0) {
                                name = p0;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomFormField(
                                      title: "081337708798",
                                      controller: null,
                                      validator: (p0) {
                                        if (p0!.isEmpty) {
                                          return 'Masukkan Nomor Telepon Penerima';
                                        }
                                        return null;
                                      },
                                      onSaved: (p0) {
                                        phone = p0;
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Container(
                              decoration: BoxDecoration(
                                color: formColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: CustomFormField(
                                      title: "Bungus Teluk Kabung",
                                      controller: null,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Container(
                              decoration: BoxDecoration(
                                color: formColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: CustomFormField(
                                      title: "Bungus Barat",
                                      controller: null,
                                    ),
                                  ),
                                ],
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    text: 'Alamat',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: medium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomFormFieldText(
                              title: "Provinsi, Kota, Kecamatan, Kode Pos",
                              controller: null,
                              maxLines: 5,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return 'Masukkan Alamat Penerima';
                                }
                                return null;
                              },
                              onSaved: (p0) {
                                address = p0;
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    text: 'Koordinat Latitude',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: medium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomFormField(
                              title: "-6.2088",
                              controller: null,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return 'Masukkan Koordinat Latitude Alamat Penerima';
                                }
                                return null;
                              },
                              onSaved: (p0) {
                                latitude = p0;
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              controller: null,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return 'Masukkan Koordinat Longitude Alamat Penerima';
                                }
                                return null;
                              },
                              onSaved: (p0) {
                                longitude = p0;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButton<String>(
                                value: dropdownValueStatus,
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                underline: Container(
                                  height: 0,
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValueStatus = value!;
                                  });
                                },
                                items: status.map<DropdownMenuItem<String>>(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              side: WidgetStatePropertyAll<BorderSide>(
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
                                  borderRadius: BorderRadius.circular(5),
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
                              side: WidgetStatePropertyAll<BorderSide>(
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
                                  borderRadius: BorderRadius.circular(5),
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
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthSuccess) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButtonFilled(
                                text: "Simpan",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    context.read<AuthBloc>().add(AuthAddAddress(
                                        state.data,
                                        AddAddressModel(
                                            address: address,
                                            latitude: latitude,
                                            longitude: longitude,
                                            receivername: name,
                                            receiverphone: phone,
                                            status: dropdownValueStatus,
                                            subdistrictid: null,
                                            type: type)));
                                  }
                                },
                              ),
                            );
                          } else {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButtonFilled(
                                text: "Login Terlebih Dahulu",
                                onPressed: () {},
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
