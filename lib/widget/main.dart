import 'package:flutter/material.dart';
import '../Theme/app_color.dart';
import 'MainScreenWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: AppColors.mainColor
        ),
      ),
      routes: {
        '/': (context) => AuthWidget(),
      },
    );
  }
}