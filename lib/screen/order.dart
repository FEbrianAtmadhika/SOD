import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sod_new/bloc/Auth/auth_bloc.dart';
import 'package:sod_new/bloc/Transaction/transaction_bloc.dart';
import 'package:sod_new/models/transactionmodel.dart';
import '../shared/theme.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Widget _content(BuildContext context, String status, TextStyle styleText,
      List<TransactionModel> data, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView.builder(
          itemCount: data.length,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kode Transaksi : ${data[index].code}",
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: data[index].code!));

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Code copied to clipboard!')),
                          );
                        },
                        icon: const Icon(Icons.content_copy), // Copy icon
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Nama Pemesan: ",
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: semiBold,
                              ),
                            ),
                            TextSpan(
                              text: name,
                              style: blackTextStyle.copyWith(
                                color: Colors
                                    .orange, // Set this to your desired orange color
                                fontSize: 12,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Status Transaksi: ",
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: semiBold,
                              ),
                            ),
                            TextSpan(
                              text: data[index].status,
                              style: blackTextStyle.copyWith(
                                color: Colors
                                    .orange, // Set this to your desired orange color
                                fontSize: 12,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Status Pembayaran: ",
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: semiBold,
                              ),
                            ),
                            TextSpan(
                              text: data[index].status,
                              style: blackTextStyle.copyWith(
                                color: Colors
                                    .orange, // Set this to your desired orange color
                                fontSize: 12,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Ongkir : Rp. ${data[index].shippingPrice}",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                  Text(
                    "Biaya Lainnya : Rp. ${data[index].appFee}",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                  Text(
                    "Total Bill : Rp. ${data[index].totalPrice}",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ...data[index].details!.map(
                    (e) {
                      return Row(
                        children: <Widget>[
                          SizedBox(
                            width: 50, // Set the width to 50
                            height: 50, // Set the height to 50
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                e.variant!.product!.thumbnail!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                e.variant!.product!.name!,
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Text(
                                e.variant!.name!,
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: regular,
                                ),
                              ),
                              Text(
                                "${e.quantity}X Rp. ${e.variant!.price}",
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: regular,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            );
          }),
    );
  }

  @override
  void didChangeDependencies() {
    context.read<TransactionBloc>().add(TransactionGetAll());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        body: BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TransactionSuccess) {
              List<TransactionModel> data = state.data;
              return Padding(
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
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, authstate) {},
                      builder: (context, authstate) {
                        if (authstate is AuthSuccess) {
                          String name = authstate.data.name!;
                          return Expanded(
                            child: TabBarView(
                              children: <Widget>[
                                _content(
                                    context,
                                    "Pesanan diproses",
                                    orangeTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                    data.where(
                                      (element) {
                                        return element.status == "pending";
                                      },
                                    ).toList(),
                                    name),
                                _content(
                                    context,
                                    "Pesanan dikirim",
                                    blueTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                    data.where(
                                      (element) {
                                        return element.status == "delivered";
                                      },
                                    ).toList(),
                                    name),
                                _content(
                                    context,
                                    "Pesanan selesai",
                                    greenTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                    data.where(
                                      (element) {
                                        return element.status == "done";
                                      },
                                    ).toList(),
                                    name),
                                _content(
                                    context,
                                    "Pesanan dibatalkan",
                                    redTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                    data.where(
                                      (element) {
                                        return element.status == "cancelled";
                                      },
                                    ).toList(),
                                    name),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text(''),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }
}
