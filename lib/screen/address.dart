import 'package:flutter/material.dart';
import '../shared/theme.dart';
import '../widgets/button.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

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
          "Alamat Saya",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: formColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dika Alkadri | (+62) 822-8564-9330",
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Komplek Lubuk Gading II, Blok O no.10, RT.3 RW.9, Kel.Batang Kabung Koto Tangah KOTO TANGAH, KOTA PADANG, SUMATERA BARAT, ID 25171",
                    style: blackTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: regular,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      side: WidgetStatePropertyAll<BorderSide>(
                        BorderSide(
                          color: greenColor,
                        ),
                      ),
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Rumah",
                      style: greenTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButtonFilled(
              text: "+   Tambah Alamat Baru",
              onPressed: () {
                Navigator.pushNamed(context, '/addAddress');
              },
            ),
          ],
        ),
      ),
    );
  }
}
