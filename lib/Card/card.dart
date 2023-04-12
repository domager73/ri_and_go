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
  bool tripType;
  int id;

  CardTrip({required this.nameOfTrip, required this.date, required this.author, required this.description, required this.tripType, required this.id});
}

class User {
  String name;
  int id;

  User({required this.name, required this.id});
}