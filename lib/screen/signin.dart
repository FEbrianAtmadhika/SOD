import 'package:flutter/material.dart';
import 'package:sod_new/bloc/Auth/auth_bloc.dart';
import 'package:sod_new/models/loginmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sod_new/widgets/loadingwidget.dart';
import '../shared/theme.dart';
import '../widgets/button.dart';
import '../widgets/form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _visible = false;
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  void visibilty() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const LoadingOverlay();
              },
            );
          }
          if (state is AuthSuccess) {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/bottomnavigationbar');
          }
          if (state is AuthFailed) {
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.e)));
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Masuk",
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
                      "Silahkan masuk untuk lanjut ke aplikasi",
                      textAlign: TextAlign.center,
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomFormField(
                              title: "Email",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Silahkan Masukkan Email';
                                } else if (value.contains('@') == false) {
                                  return 'Silahkan Masukkan Email yang lengkap';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                email = newValue;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomFormField(
                              title: "Password",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Silahkan Masukkan Password';
                                }
                                return null;
                              },
                              obscureText: !_visible,
                              onSaved: (newValue) {
                                password = newValue;
                              },
                              suffixicon: IconButton(
                                onPressed: () {
                                  visibilty();
                                },
                                icon: Icon(
                                  _visible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Lupa Password?",
                        style: orangeTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButtonFilled(
                      text: "Lanjutkan",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context.read<AuthBloc>().add(AuthLogin(
                              LoginModel(email: email, password: password)));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/signup'),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Belum punya akun? ',
                              style: greyTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: 'Daftar',
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
      ),
    );
  }
}
