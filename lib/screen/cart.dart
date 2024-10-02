import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sod_new/bloc/Cart/cart_bloc.dart';
import 'package:sod_new/bloc/Transaction/transaction_bloc.dart';
import 'package:sod_new/models/addtransactionmodel.dart';
import 'package:sod_new/models/cartmodel.dart';
import 'package:sod_new/widgets/loadingwidget.dart';
import '../shared/theme.dart';
import '../widgets/button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<bool> itemSelectedList = [];

  bool? isAllSelected = false;
  bool isFirstLoad = true;
  @override
  void didChangeDependencies() {
    context.read<CartBloc>().add(CartGetAll());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundgreenColor,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: greenColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Keranjang Belanja",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const LoadingOverlay();
              },
            );
          }
          if (state is CartDelSuccess) {
            itemSelectedList.removeWhere((item) => item == true);
          }
          if (state is CartSuccess) {
            Navigator.of(context).pop();
          }
          if (state is CartDelFailed) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.e)));
          }
          if (state is CartFailed) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is CartSuccess) {
            List<CartModel> data = state.cart;
            if (isFirstLoad) {
              itemSelectedList = List.generate(
                state.cart.length,
                (index) => false,
              );
              isFirstLoad = false;
            }
            return data.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/empty.png",
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Yah Keranjangnya Kosong",
                          style: blackTextStyle.copyWith(
                              fontSize: 18, fontWeight: semiBold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Yuk Belanja Sekarangg",
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: medium),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButtonFilled(
                          text: "Belanja Sekarang",
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                  value: isAllSelected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAllSelected = value!;
                                      itemSelectedList = List.filled(
                                          data.length, isAllSelected!);
                                    });
                                  },
                                ),
                                Text(
                                  'Pilih Semua',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: medium,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                List<int> idcart = [];
                                for (int i = 0;
                                    i < itemSelectedList.length;
                                    i++) {
                                  if (itemSelectedList[i]) {
                                    idcart.add(data[i].id!);
                                  }
                                }
                                context
                                    .read<CartBloc>()
                                    .add(DelCartIem(data, idcart));
                              },
                              child: Text(
                                'Hapus',
                                style: redTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: formColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(7),
                                  horizontalTitleGap: 1,
                                  leading: Checkbox(
                                    activeColor: Colors.green,
                                    checkColor: Colors.white,
                                    value: itemSelectedList[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        itemSelectedList[index] = value!;
                                        if (itemSelectedList.every(
                                          (element) => element == true,
                                        )) {
                                          isAllSelected = true;
                                        }
                                        if (itemSelectedList.contains(false)) {
                                          isAllSelected = false;
                                        }
                                      });
                                    },
                                  ),
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        data[index]
                                            .product!
                                            .thumbnail!, // Use the image from CartModel
                                        width: 70,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data[index]
                                                  .product!
                                                  .name!, // Use the name from CartModel
                                              style: blackTextStyle.copyWith(
                                                fontSize: 18,
                                                fontWeight: semiBold,
                                              ),
                                            ),
                                            Text(
                                              "${data[index].varian!.name} gr", // Use the weight from CartModel
                                              style: greyTextStyle.copyWith(
                                                fontSize: 12,
                                                fontWeight: semiBold,
                                              ),
                                            ),
                                            Text(
                                              "Rp.${data[index].varian!.price}", // Use the price from CartModel
                                              style: blackTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: semiBold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Container(
                                    width: 70,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: borderbutton,
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (data[index].quantity! > 1) {
                                                data[index].quantity =
                                                    data[index].quantity! - 1;
                                              }
                                            });
                                          },
                                          child: Icon(
                                            size: 20,
                                            Icons.remove,
                                            color: greenColor,
                                          ),
                                        ),
                                        Text(
                                          data[index].quantity!.toString(),
                                          style: blackTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: semiBold,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              data[index].quantity =
                                                  data[index].quantity! + 1;
                                            });
                                          },
                                          child: Icon(
                                            size: 20,
                                            Icons.add,
                                            color: greenColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: greenColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order Info",
                                style: whiteTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                  Text(
                                    "Rp${calculateSubtotal(data, itemSelectedList)}", // Calculate subtotal
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ongkos Kirim",
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                  Text(
                                    "Rp10000",
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "App Fee",
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                  Text(
                                    "Rp1000",
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                  Text(
                                    "Rp${calculateTotal(data, itemSelectedList)}", // Calculate total
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        BlocConsumer<TransactionBloc, TransactionState>(
                          listener: (context, state) {
                            if (state is TransactionLoading) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const LoadingOverlay();
                                },
                              );
                            }
                            if (state is AddTransactionSuccess) {
                              Navigator.of(context).pop();
                              setState(() {
                                if (itemSelectedList.every(
                                  (element) {
                                    return element == true;
                                  },
                                )) {
                                  data = [];
                                  itemSelectedList = [];
                                } else {
                                  for (int i = 0; i < data.length; i++) {
                                    if (itemSelectedList[i] == true) {
                                      data.removeAt(i);
                                      itemSelectedList.removeAt(i);
                                    }
                                  }
                                }
                              });
                              Navigator.of(context).pushNamed('/successCart');
                            }
                            if (state is AddTransactionFailed) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.e)));
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButtonFilled(
                              text: "Lanjutkan Pembayaran",
                              onPressed: () {
                                AddTransactionModel item = AddTransactionModel(
                                    appfee: 1000,
                                    shippingprice: 10000,
                                    totalprice:
                                        calculateTotal(data, itemSelectedList),
                                    listitem: []);
                                for (int i = 0; i < data.length; i++) {
                                  if (itemSelectedList[i] == true) {
                                    item.listitem!.add(CheckedItemModel(
                                        checkeditem: data[i].id,
                                        quantity: data[i].quantity));
                                  }
                                }
                                context
                                    .read<TransactionBloc>()
                                    .add(AddTransaction(item));
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 20),
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
    );
  }

  int calculateSubtotal(List<CartModel> data, List<bool> itemchecked) {
    int subtotal = 0;
    for (int i = 0; i < data.length; i++) {
      if (itemchecked[i] == true) {
        subtotal += (data[i].varian!.price! * data[i].quantity!);
      }
    }

    return subtotal;
  }

  int calculateTotal(List<CartModel> data, List<bool> itemChecked) {
    int total = calculateSubtotal(data, itemChecked);
    return total + 11000;
  }
}
