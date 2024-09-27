import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sod_new/bloc/Auth/auth_bloc.dart';
import 'package:sod_new/screen/signup.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Future.delayed(const Duration(seconds: 1)).then(
              (value) {
                Navigator.of(context)
                    .pushReplacementNamed('/bottomnavigationbar');
              },
            );
          }
        },
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/signin');
          },
          child: Stack(
            children: [
              Image.asset(
                "assets/images/splash2.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              Center(
                child: Image.asset(
                  "assets/images/splash1.png",
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
