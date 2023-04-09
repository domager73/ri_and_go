import 'package:flutter/material.dart';
import 'package:ri_and_go/widget/auth/SingIn/SecondSingInWidget.dart';
import 'package:ri_and_go/widget/auth/SingIn/SingInScreenWidget.dart';
import '../Theme/app_color.dart';
import 'auth/AuthScreenWidget.dart';

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
        'login': (context) => AuthWidget(),
        'firstSingin' : (context) => SingWidget(),
        'secondSingin' : (context) => SecondSingWidget(),
      },

      initialRoute: 'login',
    );
  }
}