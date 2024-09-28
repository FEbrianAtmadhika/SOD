import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sod_new/bloc/Auth/auth_bloc.dart';
import 'package:sod_new/widgets/loadingwidget.dart';
import '../shared/theme.dart';
import '../widgets/akunmenu.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
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
          if (state is AuthInitial) {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/signin');
          }
          if (state is AuthFailed) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.e)));
          }
        },
        builder: (context, state) {
          if (state is AuthSuccess) {
            // When auth is successful, show user details inside the scrollable section
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                child: Column(
                  children: [
                    Container(
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
                    const SizedBox(height: 20),
                    Text(
                      state.data.name!,
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: medium,
                      ),
                    ),
                    Text(
                      state.data.email!,
                      style: orangeTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ListView for account menu
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        AkunMenu(
                          leadingIcon: Image.asset(
                            "assets/images/person.png",
                            width: 24,
                          ),
                          titleText: "Detail Profil",
                          onTap: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                        ),
                        AkunMenu(
                          leadingIcon: Image.asset(
                            "assets/images/alamat.png",
                            width: 24,
                            height: 24,
                          ),
                          titleText: "Alamat Saya ",
                          onTap: () {
                            Navigator.pushNamed(context, '/address');
                          },
                        ),
                        AkunMenu(
                          leadingIcon: Image.asset(
                            "assets/images/privasi.png",
                            width: 24,
                            height: 24,
                          ),
                          titleText: "Privasi dan Keamanan",
                          onTap: () {},
                        ),
                        AkunMenu(
                          leadingIcon: Image.asset(
                            "assets/images/bantuan.png",
                            width: 24,
                          ),
                          titleText: "Bantuan",
                          onTap: () {},
                        ),
                        AkunMenu(
                          leadingIcon: Image.asset(
                            "assets/images/syarat.png",
                            width: 24,
                          ),
                          titleText: "Syarat dan Ketentuan",
                          onTap: () {
                            Navigator.pushNamed(context, '/setting');
                          },
                        ),
                        AkunMenu(
                          leadingIcon: Image.asset(
                            "assets/images/logout.png",
                            width: 24,
                          ),
                          titleText: "Keluar",
                          onTap: () async {
                            context
                                .read<AuthBloc>()
                                .add(AuthLogout(state.data));
                          },
                          trailingIcon: null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text("Failed to load user info"));
          }
        },
      ),
    );
  }
}
