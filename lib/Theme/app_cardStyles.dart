import 'package:flutter/material.dart';

abstract class descriptionTextes {
  static const title = TextStyle(
    fontSize: 15,
  );

  static const text = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  static const author = TextStyle(
    color: Color(0xff1EC67F),
    fontSize: 14,
  );

}

abstract class mainTextes {
  static const title = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w600,
  );

  static const date = TextStyle(
      color: Color.fromRGBO(20, 20, 20, 1), fontSize: 16);
}
