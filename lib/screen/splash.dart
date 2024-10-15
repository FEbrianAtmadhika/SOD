import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:sod_new/bloc/Auth/auth_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppUpdateInfo? _updateInfo;
  @override

  // void _redirectToPlayStoreForTesting() async {
  //   final url =
  //       'https://play.google.com/apps/internaltest/4701084007459227187'; // replace with your closed testing Play Store URL
  //   if (await canLaunchUrlString(url)) {
  //     await launchUrlString(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  Future<void> _checkForUpdate(BuildContext context) async {
    try {
      final info = await InAppUpdate.checkForUpdate();
      setState(() {
        _updateInfo = info;
      });
      if (_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        if (_updateInfo!.immediateUpdateAllowed == true) {
          await InAppUpdate.performImmediateUpdate().then(
            (value) {
              SystemNavigator.pop();
            },
          );
        }
        if (_updateInfo!.flexibleUpdateAllowed == true) {
          _showUpdateDialog();
        }
      } else {
        context.read<AuthBloc>().add(AuthGetCurrent(context));
      }
    } catch (e) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Kesalahan Koneksi'),
                content: const Text(
                    'Perangkat Anda tidak terkoneksi ke internet. Silakan cek koneksi Anda dan coba lagi.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ]);
          });
    }
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pembaruan Tersedia'),
          content: const Text(
              'Versi terbaru aplikasi tersedia. Apakah Anda ingin memperbarui sekarang?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(AuthGetCurrent(context));
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await InAppUpdate.performImmediateUpdate().then(
                  (value) {
                    if (value == AppUpdateResult.success) {
                      SystemNavigator.pop();
                    } else {
                      context.read<AuthBloc>().add(AuthGetCurrent(context));
                    }
                  },
                );
              },
              child: const Text('Perbarui'),
            ),
          ],
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    _checkForUpdate(context);
    super.didChangeDependencies();
  }

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
          if (state is AuthFailed) {
            Future.delayed(const Duration(seconds: 1)).then(
              (value) {
                Navigator.of(context).pushReplacementNamed('/signin');
              },
            );
          }
          if (state is AuthInitial) {
            Future.delayed(const Duration(seconds: 1)).then(
              (value) {
                Navigator.of(context).pushReplacementNamed('/signin');
              },
            );
          }
        },
        child: GestureDetector(
          onTap: () {
            context.read<AuthBloc>().add(AuthGetCurrent(context));
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
