import 'package:books_app/core/app_colors.dart';
import 'package:books_app/views/book_detail.dart';
import 'package:books_app/views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: AppColors.dark,
          primarySwatch: createMaterialColor(AppColors.green)),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/detail": (context) => const BookDetailPage()
      },
    );
  }
}
