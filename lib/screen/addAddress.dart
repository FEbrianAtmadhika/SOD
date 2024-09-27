import 'package:flutter/material.dart';
import '../shared/theme.dart';
import '../widgets/button.dart';
import '../widgets/form.dart';

const List<String> telepon = <String>['+62', '+28'];

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  int selectedButton = 1;
  @override
  Widget build(BuildContext context) {
    String dropdownValueTelepon = telepon.first;
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
              Padding(
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
                          const CustomFormField(
                            title: "Nama Lengkap",
                            controller: null,
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                DropdownButton<String>(
                                  value: dropdownValueTelepon,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  underline: Container(
                                    height: 0,
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropdownValueTelepon = value!;
                                    });
                                  },
                                  items: telepon.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                const Expanded(
                                  child: CustomFormField(
                                    title: "81337708798",
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
                          const CustomFormField(
                            title: "Provinsi, Kota, Kecamatan, Kode Pos",
                            controller: null,
                            suffixicon:
                                Icon(Icons.keyboard_arrow_right_rounded),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomFormField(
                            title: "Nama Jalan, Gedung, No. Rumah",
                            controller: null,
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
                          const CustomFormField(
                            title: "Contoh: Rumah/ Kantor/Kos",
                            controller: null,
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
                            side: MaterialStatePropertyAll<BorderSide>(
                              BorderSide(
                                  color: selectedButton == 1
                                      ? greenColor
                                      : Colors.transparent),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(formColor),
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedButton = 1;
                            });
                          },
                          child: Text(
                            "Rumah",
                            style: selectedButton == 1
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
                            side: MaterialStatePropertyAll<BorderSide>(
                              BorderSide(
                                  color: selectedButton == 2
                                      ? greenColor
                                      : Colors.transparent),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(formColor),
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedButton = 2;
                            });
                          },
                          child: Text(
                            "Kantor",
                            style: selectedButton == 2
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
                            side: MaterialStatePropertyAll<BorderSide>(
                              BorderSide(
                                  color: selectedButton == 3
                                      ? greenColor
                                      : Colors.transparent),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(formColor),
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedButton = 3;
                            });
                          },
                          child: Text(
                            "Kos",
                            style: selectedButton == 3
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
                          Navigator.pushNamed(context, '/addAddress');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
