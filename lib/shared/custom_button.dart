
import 'package:flutter/material.dart';
import '../core/constants/api_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,
    required this.text,
    this.onTap,
    this.width,
     this.color, this.hight});
  final String text;
  final Function()? onTap;
  final double ? width ;
  final double ?hight;
  final Color ?color;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height:hight??40,
        padding: EdgeInsets.symmetric(horizontal: 30 ,vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color:color?? AppColors.primary
        ),
        child: Center(child: CustomText(text:text,color: Colors.white,weight: FontWeight.bold,)),
      ),
    );
  }
}
