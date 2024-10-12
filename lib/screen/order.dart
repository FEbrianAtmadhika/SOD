import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sod_new/bloc/Transaction/transaction_bloc.dart';
import 'package:sod_new/models/transactionmodel.dart';
import '../shared/theme.dart';
import '../widgets/button.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Widget _content(BuildContext context, String status, TextStyle styleText,
      List<TransactionModel> data, Function? canceled) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
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
                                text: data[index].user!.name,
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
                        Flexible(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Alamat: ",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                TextSpan(
                                  text: data[index].address,
                                  style: blackTextStyle.copyWith(
                                    color: Colors.orange,
                                    fontSize: 12,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 2, // Restrict it to 2 lines
                            overflow: TextOverflow
                                .ellipsis, // Add ellipsis if it exceeds 2 lines
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
                      "Ongkir : ${oCcy.format(data[index].shippingPrice)}",
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      "Biaya Lainnya : ${oCcy.format(data[index].appFee)}",
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      "Total Bill : ${oCcy.format(data[index].totalPrice)}",
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
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
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
                                    "${e.quantity}X ${oCcy.format(e.variant!.price)}",
                                    style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: regular,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (data[index].status == 'pending' && canceled != null)
                      ElevatedButtonFilledIconSmall(
                        color: Colors.red,
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Cancel Transaksi'),
                                  content: const Text(
                                      'Apakah Kamu Yakin Mau Cancel Pesanan Ini'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Tidak'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        canceled(data[index].id);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              });
                        },
                        text: 'Cancel',
                      )
                  ],
                ),
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

  final oCcy =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
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
                              data.where(
                                (element) {
                                  return element.status == "pending";
                                },
                              ).toList(), (id) {
                            context
                                .read<TransactionBloc>()
                                .add(CancelTransaction(data, id));
                          }),
                          _content(
                              context,
                              "Pesanan dikirim",
                              blueTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: semiBold,
                              ),
                              data.where(
                                (element) {
                                  return element.status == "delivered" ||
                                      element.status == 'shipped';
                                },
                              ).toList(),
                              null),
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
                              null),
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
                              null),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            if (state is TransactionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('Gagal Mengambil Data Transaction'),
              );
            }
          },
        ),
      ),
    );
  }
}
