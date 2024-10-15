import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sod_new/bloc/Auth/auth_bloc.dart';
import 'package:sod_new/bloc/Cart/cart_bloc.dart';
import 'package:sod_new/bloc/Product/product_bloc.dart';
import 'package:sod_new/models/addcartmodel.dart';
import 'package:sod_new/models/productmodel.dart';
import 'package:sod_new/widgets/loadingwidget.dart';
import '../shared/theme.dart';
import 'button.dart';

class Recommendation extends StatefulWidget {
  int? category;
  String? searchText;
  Recommendation({super.key, required this.category, required this.searchText});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  List<ProductModel> product = [];

  void showmodelbottom(ProductModel activeProduct) {
    int selectedButton = activeProduct.variants!.first.id!;
    int itemCount = 0;
    int maksStock = activeProduct.variants!.first.stock!.quantity!;
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(
                20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        color: border,
                        width: 70,
                        child: Image.network(
                          activeProduct.thumbnail!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activeProduct.name!,
                              style: blackTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: semiBold,
                              ),
                            ),
                            Text(
                              activeProduct.variants!.map((e) => e.name).join(
                                  ', '), // Join variant names with a comma
                              style: greyTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                            Text(
                              "Rp ${NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(activeProduct.variants!.firstWhere(
                                (element) {
                                  return element.id == selectedButton;
                                },
                              ).price)}",
                              style: blackTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Pilih Varian",
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...activeProduct.variants!.map((variant) {
                          return OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: selectedButton == variant.id
                                  ? WidgetStatePropertyAll(borderbutton)
                                  : null,
                              side: WidgetStatePropertyAll<BorderSide>(
                                BorderSide(
                                  color: selectedButton == variant.id
                                      ? greenColor
                                      : greyColor,
                                ),
                              ),
                              shape: WidgetStatePropertyAll<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                selectedButton = variant.id!;
                                maksStock = variant.stock!.quantity!;
                                itemCount = 0;
                              });
                            },
                            child: Text(
                              variant.name!, // Display the variant name
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                          );
                        }),
                      ]),
                  Text(
                    "Stok :  ${activeProduct.variants!.firstWhere(
                          (element) {
                            return element.id == selectedButton;
                          },
                        ).stock!.quantity}",
                    style: greyTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pilih Jumlah",
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: borderbutton),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: greenColor,
                              ),
                              onPressed: () => setState(() {
                                if (itemCount == 0) {}
                                if (itemCount > 0) {
                                  itemCount--;
                                }
                              }),
                            ),
                            Text(
                              itemCount.toString(),
                              style: blackTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: semiBold,
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: greenColor,
                                ),
                                onPressed: () => setState(() {
                                      if (itemCount < maksStock) {
                                        itemCount++;
                                      }
                                    }))
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthSuccess) {
                        return ElevatedButtonFilled(
                          text: "Tambah Ke Keranjang",
                          onPressed: () {
                            if (itemCount <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Tidak Bisa Menambahkan Ke Keranjang')),
                              );
                            } else if (state.data.address!.isEmpty ||
                                !state.data.address!.any(
                                    (element) => element.status == 'active')) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Gagal'),
                                    content: const Text(
                                        'Silahkan Pilih atau Tambahkan Alamat Yang Active Terlebih Dahulu'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // Tambahkan item ke keranjang
                              context.read<CartBloc>().add(
                                    AddCartItem(AddCartModel(
                                        quantity: itemCount,
                                        variantid: selectedButton)),
                                  );
                            }
                          },
                        );
                      } else {
                        return ElevatedButtonFilled(
                          text: "Silahkan Login",
                          onPressed: () {},
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartAddLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const LoadingOverlay();
            },
          );
        }
        if (state is AddCartSuccess) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Item Berhasil Ditambah Ke Cart'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        if (state is CartAddFailed) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Semua Sayuran",
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductSuccess) {
                  if (widget.searchText != '') {
                    product = state.product.where(
                      (element) {
                        return element.name!
                            .toLowerCase()
                            .contains(widget.searchText!.toLowerCase());
                      },
                    ).toList();
                  } else {
                    product = widget.category == null || widget.category == 0
                        ? state.product
                        : state.product.where(
                            (element) {
                              return element.categoryid == widget.category;
                            },
                          ).toList();
                  }

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      mainAxisExtent: MediaQuery.of(context).size.height / 3,
                    ),
                    itemCount: product.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          showmodelbottom(product[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                13.0,
                              ),
                              border: Border.all(
                                color: border,
                                width: 2,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child:
                                    // FadeInImage(
                                    //   placeholder: AssetImage(
                                    //     "assets/images/sayuran.png",
                                    //   ),
                                    //   image: AssetImage('assets/images/sayuran.png'),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Image.network(product[index].thumbnail!),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          product[index].name!,
                                          overflow: TextOverflow.ellipsis,
                                          style: blackTextStyle.copyWith(
                                            fontWeight: semiBold,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          product[index].variants![0].name!,
                                          style: greyTextStyle.copyWith(
                                            fontWeight: semiBold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "Rp. ${NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(product[index].variants![0].price)}",
                                              style: blackTextStyle.copyWith(
                                                fontWeight: bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 26,
                                            width: 26,
                                            decoration: ShapeDecoration(
                                              color: greenColor,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),
                                            ),
                                            child: IconButton(
                                              iconSize: 15,
                                              icon: Image.asset(
                                                  "assets/images/plus.png"),
                                              color: Colors.white,
                                              onPressed: () {},
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.grey,
                  ));
                }
              },
            )
            // Consumer<Products>(builder: (context, value, _) {
            //   var data = value.all;
            //   return GridView.builder(
            //     physics: const NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       crossAxisSpacing: 12.0,
            //       mainAxisSpacing: 12.0,
            //       mainAxisExtent: 310,
            //     ),
            //     itemCount: value.all.length,
            //     itemBuilder: (_, index) {
            //       return Container(
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(
            //             8.0,
            //           ),
            //         ),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.stretch,
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             ClipRRect(
            //                 borderRadius: BorderRadius.circular(8),
            //                 child: FadeInImage(
            //                   placeholder: AssetImage("assets/images/food.jpg"),
            //                   image:
            //                       NetworkImage('${data[index].galery[0].image}'),
            //                   fit: BoxFit.cover,
            //                 )),
            //             Expanded(
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       "${data[index].name}",
            //                       maxLines: 2,
            //                       overflow: TextOverflow.ellipsis,
            //                     ),
            //                     Text(
            //                       "${data[index].stock} pieces",
            //                       overflow: TextOverflow.ellipsis,
            //                       style: const TextStyle(
            //                           fontSize: 12, color: Colors.grey),
            //                     ),
            //                     Text(
            //                       formatPriceWithDots(
            //                           data[index].price.toString()),
            //                       overflow: TextOverflow.ellipsis,
            //                       style: const TextStyle(
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             FilledButton(
            //               onPressed: () {
            //                 Navigator.of(context)
            //                     .pushNamed('/detail', arguments: data[index].id);
            //               },
            //               style: FilledButton.styleFrom(
            //                   backgroundColor:
            //                       const Color.fromRGBO(51, 204, 51, 1),
            //                   shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(8))),
            //               child: const Text(
            //                 "Detail",
            //                 style: TextStyle(fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}
