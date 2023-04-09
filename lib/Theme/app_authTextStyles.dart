import 'package:flutter/material.dart';

abstract class authStyles {
  static const buttonTextStyleActive = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
      decoration: TextDecoration.underline,
      decorationThickness: 2,
      decorationColor: Color(0xff854000),
      color: Color(0xffB97003)
  );
  static const buttonTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    color: Color(0xffA6A6A6),
  );

  static const LoginButton = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w400
  );

  static const smallButtons = TextStyle(
      fontSize: 16,
      color: Color(0xffA6A6A6)
  );
}