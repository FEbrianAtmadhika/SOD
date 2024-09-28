import 'package:flutter/material.dart';
import '../shared/theme.dart';
import '../widgets/topbar.dart';
import '../widgets/button.dart';
import '../widgets/form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _form = GlobalKey<FormState>();
  bool _visible = false;

  void visibilty() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Daftar",
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(
                      fontSize: 26,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Silahkan daftar untuk melanjutkan aplikasi",
                    textAlign: TextAlign.center,
                    style: greyTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: regular,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomFormField(
                    title: "Name",
                    controller: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Silahkan Masukkan Nama';
                      }
                      return null;
                    },
                    onSaved: (newValue) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    title: "Email",
                    controller: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Silahkan Masukkan Email';
                      } else if (value.contains('@') == false) {
                        return 'Silahkan Masukkan Email yang lengkap';
                      }
                      return null;
                    },
                    onSaved: (newValue) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    title: "Password",
                    obscureText: !_visible,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Silahkan Masukkan Password';
                      }
                      return null;
                    },
                    onSaved: (newValue) {},
                    suffixicon: IconButton(
                      onPressed: () {
                        visibilty();
                      },
                      icon: Icon(
                        _visible ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButtonFilled(
                    text: "Lanjutkan",
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/bottomnavigationbar');
                    },
                  ),
                  Text(
                    " Password terdiri dari 8 karakter",
                    style: greyTextStyle.copyWith(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/signin'),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sudah punya akun? ',
                            style: greyTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: 'Masuk',
                            style: orangeTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
