import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.weight,
    this.size,
  });

  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
