import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjar/features/auth/data/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  //Sign in Form
  GlobalKey<FormState> signInFormKey = GlobalKey();
  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInPassword = TextEditingController();

  //Sign up Form
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  AuthCubit(this.authRepo) : super(AuthInitial());

  //Login
  Future<void> login() async {
    emit(AuthLoading());
    try {
      await authRepo.login(
        email: signInEmail.text.trim(),
        password: signInPassword.text.trim(),
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll("Exception: ", "")));
    }
  }

  //SignUp
  Future<void> signup() async {
    emit(AuthLoading());
    try {
      if (signUpPassword.text.trim() == confirmPassword.text.trim()) {
        await authRepo.signup(
          email: signUpEmail.text.trim(),
          password: signUpPassword.text.trim(),
        );
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("Passwords do not match"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll("Exception: ", "")));
    }
  }

  //Logout
  Future<void> logout() async {
    try {
      await authRepo.logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
