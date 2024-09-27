import 'dart:ffi';

import 'package:flutter/material.dart';
import '../shared/theme.dart';
import '../widgets/button.dart';
import '../widgets/topbar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Widget _content(
      BuildContext context, String status, TextStyle styleText, Widget button) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: formColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order ID",
                        style: greyTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        "Delivery Date",
                        style: greyTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "#SOD-02826",
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        "Senin, 6 May 2024",
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Last Status",
                        style: greyTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        "Total Bill",
                        style: greyTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(status, style: styleText),
                      Text(
                        "Rp 60.000",
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  button,
                ],
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Pesanan",
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: TabBar(
                  labelColor: greenColor,
                  unselectedLabelColor: greyColor,
                  indicatorColor: greenColor,
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  tabs: const <Widget>[
                    Tab(text: "Diproses"),
                    Tab(text: "Dikirim"),
                    Tab(text: "Selesai"),
                    Tab(text: "Dibatalkan"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    _content(
                      context,
                      "Pesanan diproses",
                      orangeTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                      ElevatedButtonFilled(
                        text: "Bayar",
                        onPressed: () {},
                      ),
                    ),
                    _content(
                      context,
                      "Pesanan dikirim",
                      blueTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                      Container(),
                    ),
                    _content(
                      context,
                      "Pesanan selesai",
                      greenTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                      ElevatedButtonFilled(
                        text: "Beli Lagi",
                        onPressed: () {},
                      ),
                    ),
                    _content(
                      context,
                      "Pesanan dibatalkan",
                      redTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                      ElevatedButtonFilled(
                        text: "Beli Lagi",
                        onPressed: () {},
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
