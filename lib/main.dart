import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjar/features/auth/cubit/auth_cubit.dart';
import 'package:matjar/features/auth/data/auth_repo.dart';
import 'package:matjar/features/home/cubit/product_cubit.dart';
import 'package:matjar/features/home/data/product_repo.dart';
import 'package:matjar/features/splash/view/splash_view.dart';
import 'package:matjar/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit(ProductRepo())..getProducts(),
        ),
        BlocProvider(create: (context) => AuthCubit(AuthRepo())),
      ],
      child: MaterialApp(
        title: 'Matjar',
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}
