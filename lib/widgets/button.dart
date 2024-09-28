import 'package:flutter/material.dart';

class ElevatedButtonFilled extends StatelessWidget {
  final String text;
  final String? image;
  final VoidCallback onPressed;

  const ElevatedButtonFilled({
    super.key,
    required this.text,
    required this.onPressed,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        elevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: const Color.fromRGBO(51, 204, 51, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class ElevatedButtonFilledIcon extends StatelessWidget {
  final String text;
  final String? image;
  final VoidCallback onPressed;
  final Widget icon;

  const ElevatedButtonFilledIcon({
    super.key,
    required this.text,
    required this.onPressed,
    this.image,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        elevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: const Color.fromRGBO(51, 204, 51, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          icon,
        ],
      ),
    );
  }
}
