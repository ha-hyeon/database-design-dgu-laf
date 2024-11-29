import 'package:dgu_laf/screen/main/home_screen.dart';
import 'package:dgu_laf/screen/user/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        hintColor: Colors.grey[350],
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 229, 158, 83),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          elevation: 2,
          actionsIconTheme: IconThemeData(color: Colors.black),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black38, // 쉼표 추가
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          titleSmall: TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
        cardColor: const Color(0xffDEEABB),
        primaryColor: const Color(0xff3297DF),
        primaryColorDark: Colors.black87,
        primaryColorLight: const Color.fromARGB(255, 243, 250, 255),
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color.fromARGB(255, 245, 251, 255),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
