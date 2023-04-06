import 'package:flutter/material.dart';
import 'package:ngandika_app/utils/styles/style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Color color;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPress,
    this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
    );
  }
}
