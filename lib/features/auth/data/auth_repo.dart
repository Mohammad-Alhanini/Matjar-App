import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Login method
  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "An error occurred");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //Signup method
  Future<void> signup({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "An error occurred");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //Logout method
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
