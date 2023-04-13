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
  List<CardTrip> aboba = [CardTrip(nameOfTrip: 'Хуйня ебаная', date: '2023-02-01', author: User(name: 'ебланище', id: 2), description: 'Кто кликнет тот гей безмамный ахахах лох заскамлен', tripType: true, id: 1), CardTrip(nameOfTrip: 'Хуйня ебаная', date: '2023-02-01', author: User(name: 'ебланище', id: 2), description: 'Кто кликнет тот гей безмамный ахахах лох заскамлен', tripType: false, id: 1)];
  List<CardTrip> authorView = [];
  void logOut() {
    contactUrl = '';
    name = '';
    emailAddress = '';
    telephoneNumber = '';
  }

  Map<String, String> searchSettings = {};

  void clearSearchSettings() {
    searchSettings = {};
  }

  void setSearchSettings(String from, String to, String when) {
    if (from != '') {
      searchSettings['from'] = from;
    }
    if (to != '') {
      searchSettings['to'] = to;
    }
    if (when != '') {
      searchSettings['when'] = when;
    }
  }


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

  void createTripDriver() {

  }
  String? toCitySearch;
  String? fromCitySearch;
  String? toCityUser;
  String? fromCityUser;
  String? toCityDriver;
  String? fromCityDriver;

  void setToCitySearch(String? city){
    toCitySearch = city;
  }

  void setFromCitySearch(String? city){
    fromCitySearch = city;
  }

  void setToCityDriver(String? city){
    toCityDriver = city;
  }

  void setFromCityDriver(String? city){
    fromCityDriver = city;
  }

  void setToCityUser(String? city){
    toCityUser = city;
  }

  void setFromCityUser(String? city){
    fromCityUser = city;
  }


  fetchData() {}
}

