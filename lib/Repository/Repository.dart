import 'package:flutter/material.dart';
import 'package:ri_and_go/Card/card.dart';

class Repository{
  int? id;
  String? emailAddress;
  String? telephoneNumber;
  String name = "";
  String? password;
  String contactUrl = '';
  bool urlExist = false;
  //List<CardTitle> cities = [CardTitle(nameOfTrip: 'afasdfasdfasdfaassdfsfasd', date: '12.23.2003', author: 'Я', description: 'Let`t go drive', )];
  List<CardTrip> cities = [];
  List<CardTrip> userCards = [];
  bool emailEmployed = false;
  int? searchUserId;

  void setSearchUserId(int id) {
    searchUserId = id;
  }

  void resetTripList() {
    userCards = [];
  }

  void emailEmploy() {
    emailEmployed = true;
  }

  void setUrl({required String newUrl}) {
    contactUrl = newUrl;
    if (contactUrl != '') {
      existUrl();
    } else {
      urlExist = false;
    }
  }


  void existUrl() {
    urlExist = true;
  }

  void addownTrip(CardTrip trip) {
    userCards.add(trip);
  }

  void setId({required int newId}) {
    id = newId;
  }

  void setEmailAddress({required String text}){
    emailAddress = text;
  }

  void setTelephoneNumber({required String text}){
    telephoneNumber = text;
  }
  void setName({required String text}){
    name = text;
  }

  void setPassword({required String text}){
    password = text;
  }

  Map<String, String> searchInfo = {
    'from': '',
    'to': '',
    'when': ''
  };
  void setSearchInfo({required Map<String, String> newSettings}) {
    searchInfo = newSettings;
  }
}