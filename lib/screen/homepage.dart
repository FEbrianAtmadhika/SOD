import 'package:flutter/material.dart';
import 'package:sod_new/bloc/Product/product_bloc.dart';
import '../shared/theme.dart';
import '../widgets/categorylist.dart';
import '../widgets/recommendation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List<String> list = <String>['Home', 'Office'];

final List<String> imgList = [
  'assets/images/carousel.png',
  'assets/images/carousel.png',
  'assets/images/carousel.png',
];

class HomepageScreen extends StatefulWidget {
  static const routeNamed = '/home';
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  late CarouselSliderController _controller;
  int currentIndex = 0;
  String dropdownValue = list.first;
  int? category;
  bool isLoading = false;

  @override
  void initState() {
    _controller = CarouselSliderController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<ProductBloc>().add(ProductGetAll());
    super.didChangeDependencies();
  }

  void changeproductview(int? idcategory) {
    setState(() {
      isLoading = true;
      category = idcategory;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/location.png",
                        width: 24,
                        color: blackColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pengiriman Hari ini",
                              style: greyTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: medium,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: false,
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                    elevation: 16,
                                    isExpanded: true,
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: list.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: greyTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: medium,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: greyColor,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: "Cari sayuran disini..",
                            hintStyle: greyTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: medium,
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                      child: Container(
                          width: 30,
                          height: 40,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/cart.png",
                              ),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  color: greenColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  '2',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: medium,
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                IntrinsicHeight(
                  child: CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        }),
                    items: imgList
                        .map(
                          (item) => Center(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                            ),
                          )),
                        )
                        .toList(),
                  ),
                ),
                DotsIndicator(
                  dotsCount: imgList.length,
                  position: currentIndex,
                  onTap: (index) {
                    _controller.animateToPage(index.toInt());
                  },
                  decorator: DotsDecorator(
                      color: greyColor,
                      activeColor: greenColor,
                      size: const Size.square(12),
                      activeSize: const Size(24, 12),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CategoryList(
                    onTap: changeproductview,
                    colorButton: Colors.black,
                  ),
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Recommendation(
                        category: category,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
