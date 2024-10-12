import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sod_new/bloc/Auth/auth_bloc.dart';
import 'package:sod_new/bloc/Cart/cart_bloc.dart';
import 'package:sod_new/bloc/District/district_bloc.dart';
import 'package:sod_new/bloc/Product/product_bloc.dart';
import 'package:sod_new/bloc/Transaction/transaction_bloc.dart';
import 'package:sod_new/screen/account.dart';
import 'package:sod_new/screen/addAddress.dart';
import 'package:sod_new/screen/address.dart';
import 'package:sod_new/screen/bottomnavigationbar.dart';
import 'package:sod_new/screen/cart.dart';
import 'package:sod_new/screen/checkout.dart';
import 'package:sod_new/screen/editaddress.dart';
import 'package:sod_new/screen/homepage.dart';
import 'package:sod_new/screen/order.dart';
import 'package:sod_new/screen/profile.dart';
import 'package:sod_new/screen/signin.dart';
import 'package:sod_new/screen/signup.dart';
import 'package:sod_new/screen/splash.dart';
import 'package:sod_new/screen/successcart.dart';
import 'package:sod_new/screen/transaksi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => DistrictBloc(),
        ),
        BlocProvider(
          create: (context) => TransactionBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthGetCurrent(context)),
        )
      ],
      child: MaterialApp(
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          dividerColor: Colors.transparent,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/signin': (context) => const SignInScreen(),
          '/homepage': (context) => const HomepageScreen(),
          '/bottomnavigationbar': (context) => const BottomNavigationScreen(),
          '/account': (context) => const AccountScreen(),
          '/addAddress': (context) => const AddAddress(),
          '/address': (context) => const AddressScreen(),
          '/cart': (context) => const CartScreen(),
          '/checkout': (context) => const CheckoutScreen(),
          '/order': (context) => const OrderScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/successCart': (context) => const SuccessCart(),
          '/transaksi': (context) => const TransaksiScreen(),
          '/editaddress': (context) => const EditAddress()
        },
      ),
    );
  }
}
