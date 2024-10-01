import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../shared/theme.dart';
import '../widgets/form.dart';
import '../widgets/topbar.dart';

const List<String> list = <String>['Laki-Laki', 'Perempuan'];
const List<String> telepon = <String>['+62', '+28'];

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isMaleButtonPressed = false;
  bool isFemaleButtonPressed = false;

  String dropdownValue = list.first;
  String dropdownValueTelepon = telepon.first;
  String _tanggalSelesai = '';

  @override
  Widget build(BuildContext context) {
    final tanggalSelesaiController =
        TextEditingController(text: _tanggalSelesai);
    return Scaffold(
      appBar: TopBar(
        title: "Profile",
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: greenColor,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/avatar.png',
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Dika Alkadri",
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: medium,
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Ganti Foto Profil",
                    style: orangeTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Lengkap",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    const CustomFormField(
                      title: "",
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
                    Text(
                      "Jenis Kelamin",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: formColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        isExpanded: true,
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tanggal Lahir",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    CustomFormField(
                      title: 'mm/dd/yyyy',
                      controller: tanggalSelesaiController,
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _tanggalSelesai.isEmpty
                              ? DateTime.now()
                              : DateTime.parse(_tanggalSelesai),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                        );
                        if (picked != null) {
                          setState(() {
                            _tanggalSelesai =
                                DateFormat("EEEE, d MMMM yyyy").format(picked);
                          });
                        }
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
                    Text(
                      "Email",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    const CustomFormField(
                      title: "dikaalkadri@gmail.com",
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
                    Text(
                      "Nomor Telepon",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
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
                            items: telepon
                                .map<DropdownMenuItem<String>>((String value) {
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
            ],
          ),
        ),
      ),
    );
  }
}
