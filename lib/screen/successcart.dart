import 'package:flutter/material.dart';
import '../shared/theme.dart';
import '../widgets/button.dart';

class SuccessCart extends StatelessWidget {
  const SuccessCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/success.png",
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Berhasil! ",
              style:
                  blackTextStyle.copyWith(fontSize: 22, fontWeight: semiBold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Pesanan Anda akan segera diproses",
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButtonFilled(
              text: "Kembali Ke Beranda",
              onPressed: () {
                Navigator.of(context).popUntil((route) {
                  return route.settings.name == '/bottomnavigationbar';
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
