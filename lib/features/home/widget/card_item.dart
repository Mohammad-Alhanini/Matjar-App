import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../shared/custom_text.dart';

class CardItem extends StatefulWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.price,
    this.onDeleteTap,
  });
  final String image, text, desc, price;
  final VoidCallback? onDeleteTap;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(widget.image, width: 140, height: 140)),
            Gap(10),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: widget.text, weight: FontWeight.bold),
                  CustomText(text: widget.desc),
                  Gap(10),
                  Row(
                    children: [
                      CustomText(
                        text: widget.price,
                        weight: FontWeight.bold,
                        size: 24,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          widget.onDeleteTap?.call();
                        },
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
