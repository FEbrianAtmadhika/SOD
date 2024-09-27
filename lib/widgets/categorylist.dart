import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sod_new/bloc/Product/product_bloc.dart';
import '../shared/theme.dart';

// ignore: must_be_immutable
class CategoryList extends StatefulWidget {
  int itemCount;
  Axis scrollDirection;
  int crossAxisCount;
  double mainAxisExtent;
  ScrollPhysics physics;
  double? containerHeight;
  final Function(int index)? onTap;
  Color? colorButton;

  CategoryList({
    super.key,
    this.itemCount = 0,
    this.scrollDirection = Axis.horizontal,
    this.crossAxisCount = 1,
    this.mainAxisExtent = 50,
    this.physics = const BouncingScrollPhysics(),
    this.containerHeight = 120,
    this.colorButton,
    this.onTap,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late List<bool> isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kategori",
            style: blackTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: widget.containerHeight,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductSuccess) {
                  return GridView.builder(
                    scrollDirection: widget.scrollDirection,
                    physics: widget.physics,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.crossAxisCount,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      mainAxisExtent: widget.mainAxisExtent,
                    ),
                    itemCount: state.category.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          widget.onTap!(state.category[index].id!);
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: orangeCategory,
                              radius: 32,
                              child: Image.network(
                                state.category[index].image!,
                                width: 34,
                              ),
                            ),
                            Text(
                              state.category[index].name!,
                              textAlign: TextAlign.center,
                              style: greyTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.grey));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
