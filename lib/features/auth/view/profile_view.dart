import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:matjar/core/constants/api_colors.dart';
import 'package:matjar/features/auth/cubit/auth_cubit.dart';
import 'package:matjar/features/auth/cubit/auth_state.dart';
import 'package:matjar/features/auth/view/login_view.dart';
import 'package:matjar/features/auth/widgets/custom_menu_title.dart';
import 'package:matjar/shared/custom_text.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F5F5),
          elevation: 0,
          title: CustomText(
            text: "My Profile",
            size: 20,
            weight: FontWeight.bold,
            color: AppColors.primary,
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 4),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: Image.asset(
                        "assets/image/profile_image.png",
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 110,
                            height: 110,
                            color: Colors.grey.shade300,
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Gap(25),
                  CustomText(
                    text: user?.email ?? "No Email",
                    size: 22,
                    weight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),

            const Gap(70),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CustomMenuTitle(
                      icon: Icons.settings,
                      iconColor: Colors.grey,
                      title: "Settings",
                      onTap: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Divider(),
                    ),
                    CustomMenuTitle(
                      icon: Icons.settings,
                      iconColor: Colors.red,
                      title: "Logout",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Logout"),
                            content: const Text(
                              "Are you sure you want to log out?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    ctx,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginView(),
                                    ),
                                    (route) => false,
                                  );
                                  context.read<AuthCubit>().logout();
                                },
                                child: const Text(
                                  "Yes, Logout",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
