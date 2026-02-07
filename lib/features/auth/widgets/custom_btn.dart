import 'package:flutter/material.dart';
import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text.dart';

class CustomAuthBtn extends StatelessWidget {
  const CustomAuthBtn({
    super.key,
    this.onTab,
    required this.text,
    this.color,
    this.textColor,
  });
  final Function()? onTab;
  final String text;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: CustomText(
            text: text,
            size: 15,
            weight: FontWeight.w700,
            color: textColor ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}
