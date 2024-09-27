import 'package:flutter/material.dart';
import '../shared/theme.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onPressed;
  final PreferredSizeWidget? bottom;

  const TopBar({
    Key? key,
    required this.title,
    this.onPressed,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: whiteColor,
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
            onPressed: onPressed,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        title!,
        style: blackTextStyle.copyWith(
          fontSize: 18,
          fontWeight: semiBold,
        ),
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    double height = kTextTabBarHeight;
    if (bottom != null) {
      height += bottom!.preferredSize.height;
    }
    return Size.fromHeight(height);
  }
}
