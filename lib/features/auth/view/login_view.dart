import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:matjar/core/constants/api_colors.dart';
import 'package:matjar/features/auth/cubit/auth_cubit.dart';
import 'package:matjar/features/auth/cubit/auth_state.dart';
import 'package:matjar/features/auth/view/signup_view.dart';
import 'package:matjar/features/home/view/home_view.dart';
import 'package:matjar/shared/custom_text.dart';
import 'package:matjar/shared/custom_text_form_field.dart';
import '../widgets/custom_btn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isObscurePassword = true;

  void dispouse() {
    context.read<AuthCubit>().signInEmail.dispose();
    context.read<AuthCubit>().signInPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomSheet: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeView()),
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: context.read<AuthCubit>().signInFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          const CustomText(
                            text: "Welcome in",
                            weight: FontWeight.bold,
                            size: 20,
                          ),
                          Gap(10),
                          Image.asset(
                            "assets/image/MatjarText.png",
                            height: 70,
                          ),
                          Gap(15),
                        ],
                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        color: AppColors.primary,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Gap(40),

                            // Email
                            CustomTextFormField(
                              hint: "Enter Your Email",
                              controller: context.read<AuthCubit>().signInEmail,
                              validator: (value) {
                                if (value!.isEmpty) return "ⓘ fill field";
                                return null;
                              },
                              suffixIcon: null,
                              keyboardType: TextInputType.emailAddress,
                              isObscure: false,
                            ),
                            const Gap(20),

                            // Password
                            CustomTextFormField(
                              hint: "Enter Your Password",
                              controller: context
                                  .read<AuthCubit>()
                                  .signInPassword,
                              validator: (value) {
                                if (value!.isEmpty) return "ⓘ fill field";
                                if (value.length < 6) {
                                  return "Minimum characters length is 6";
                                }
                                return null;
                              },
                              isObscure: isObscurePassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscurePassword = !isObscurePassword;
                                  });
                                },
                                icon: isObscurePassword
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                      ),
                              ),
                              keyboardType: TextInputType.text,
                            ),

                            const Gap(25),

                            // Login Button Logic
                            state is AuthLoading
                                ? const Center(
                                    child: CupertinoActivityIndicator(
                                      color: Colors.white,
                                      radius: 15,
                                    ),
                                  )
                                : CustomAuthBtn(
                                    color: Colors.white,
                                    textColor: AppColors.primary,
                                    text: "Login",
                                    onTab: () {
                                      if (context
                                          .read<AuthCubit>()
                                          .signInFormKey
                                          .currentState!
                                          .validate()) {
                                        // استدعاء دالة الدخول من الكيوبت
                                        context.read<AuthCubit>().login();
                                      }
                                    },
                                  ),
                            const Gap(30),

                            // Create Account
                            CustomAuthBtn(
                              color: AppColors
                                  .primary, // جعلته بلون الخلفية ليبدو كأنه شفاف
                              textColor: Colors.white,
                              text: "Create Account?",
                              onTab: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupView(),
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
          },
        ),
      ),
    );
  }
}
