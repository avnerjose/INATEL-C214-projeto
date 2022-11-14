import 'package:books_app/core/app_colors.dart';
import 'package:books_app/views/screens/home/home_screen.dart';
import 'package:books_app/views/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<Widget> getFirstPage() async {
  return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData && !(snapshot.data!.isAnonymous)) {
          return const HomeScreen();
        }

        return const LoginScreen();
      });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: AppColors.dark,
          primarySwatch: createMaterialColor(AppColors.green)),
      home: await getFirstPage()));
}
