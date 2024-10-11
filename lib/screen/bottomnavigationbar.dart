import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sod_new/bloc/Product/product_bloc.dart';
import '../screen/account.dart';
import '../screen/homepage.dart';
import '../screen/order.dart';
import '../shared/theme.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int currentPageIndex = 0;

  @override
  void didChangeDependencies() {
    context.read<ProductBloc>().add(ProductGetAll());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(currentPageIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/home.png",
              color: currentPageIndex == 0 ? greenColor : greyColor,
              width: 24,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/pesanan.png",
              color: currentPageIndex == 1 ? greenColor : greyColor,
              width: 24,
            ),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/person.png",
              color: currentPageIndex == 2 ? greenColor : greyColor,
              width: 24,
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: greenColor,
        unselectedItemColor: greyColor,
        selectedLabelStyle: greenTextStyle.copyWith(),
        unselectedLabelStyle: greyTextStyle.copyWith(),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomepageScreen();
      case 1:
        return const OrderScreen();
      case 2:
        return const AccountScreen();
      default:
        return Container();
    }
  }
}
