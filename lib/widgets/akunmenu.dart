import 'package:flutter/material.dart';
import '../shared/theme.dart';

class AkunMenu extends StatelessWidget {
  final Widget? leadingIcon;
  final String titleText;
  final VoidCallback onTap;
  final IconData? trailingIcon;

  const AkunMenu({
    super.key,
    this.leadingIcon,
    required this.titleText,
    required this.onTap,
    this.trailingIcon = Icons.arrow_forward_ios,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        leading: leadingIcon != null
            ? Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: avatarColor,
                ),
                child: leadingIcon,
              )
            : null,
        title: Text(
          titleText,
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: medium,
          ),
        ),
        trailing: Icon(
          size: 15,
          trailingIcon,
          color: blackColor,
        ));
  }
}
