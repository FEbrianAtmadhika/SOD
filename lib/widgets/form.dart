import 'package:flutter/material.dart';
import '../shared/theme.dart';

class CustomFormField extends StatefulWidget {
  final String title;
  final bool obscureText;
  final TextEditingController? controller;
  final bool isShowTitle;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Widget? suffixicon;
  final Function()? onTap;

  const CustomFormField({
    super.key,
    required this.title,
    this.obscureText = false,
    this.controller,
    this.isShowTitle = true,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.suffixicon,
    this.onTap,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: formColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.title,
          border: InputBorder.none,
          suffixIcon: widget.suffixicon,
        ),
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onTap: widget.onTap,
      ),
    );
  }
}
