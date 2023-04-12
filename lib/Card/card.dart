import 'package:flutter/material.dart';

class CardTitle{
  String nameOfTrip;
  String date;
  String description;
  String author;

  CardTitle({required this.nameOfTrip, required this.date, required this.author, required this.description});
}

class CardTrip {
  String nameOfTrip;
  String date;
  String description;
  User author;

  CardTrip({required this.nameOfTrip, required this.date, required this.author, required this.description});
}

class User {
  String name;
  int id;

  User({required this.name, required this.id});
}