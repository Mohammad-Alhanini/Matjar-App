import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:matjar/features/auth/view/profile_view.dart';
import '../../../core/constants/api_colors.dart';
import '../../../shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20),
            Image.asset("assets/image/MatjarText.png", height: 60),
            const Gap(5),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: CustomText(
                text: "Hi Everyone",
                size: 14,
                weight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),

        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileView()),
            );
          },
          icon: Icon(
            CupertinoIcons.person_circle,
            color: AppColors.primary,
            size: 50,
          ),
        ),
      ],
    );
  }
}
