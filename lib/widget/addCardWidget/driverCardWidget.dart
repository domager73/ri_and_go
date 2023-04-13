import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ri_and_go/Url/apiSetting.dart';

import '../../Repository/Repository.dart';

class AddDriver extends StatefulWidget {
  const AddDriver({Key? key}) : super(key: key);

  @override
  _FormAreaState createState() => _FormAreaState();
}

class _FormAreaState extends State<AddDriver> {
  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  final TextEditingController _textFieldController3 = TextEditingController();
  final TextEditingController _textFieldController4 = TextEditingController();
  final TextEditingController _textFieldController5 = TextEditingController();
  final TextEditingController _textFieldController6 = TextEditingController();

  String? placeFrom;
  String? placeWhere;
  String? time;
  String? name;
  String? descr;
  String? countPeople;

  void addCard() async {
    final dio = Dio();
    final response = await dio.post(apiSettings.baseUrl + 'Trips/AddNew', data: {
      "name": _textFieldController4.text,
      "description": _textFieldController5.text,
      "creatorId": context.read<Repository>().id,
      "isActive": true,
      "departureTime": _textFieldController3.text,
      "departurePlace":_textFieldController1.text,
      "arrivalPlace": _textFieldController2.text,
      "tripType": true,
      "maxPassengers": _textFieldController6.text,
    });
    Navigator.of(context).pushNamed('mainScreen');
  }


  void addCards() {
    addCard();
    setState(() {});
  }

  void navigateMap() {
    Navigator.of(context).pushNamed('mapDrive');
  }


  Future<void> refresh() async {
    await context.read<Repository>().fetchData(); // update the data
    setState(() {}); // rebuild the widget tree
  }


  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // создаем таймер, который будет вызывать функцию каждые 10 секунд
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        refresh();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // обязательно останавливаем таймер при удалении виджета
    _timer.cancel();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text(
              'Водитель',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
                // fontStyle: FontStyle.italic,
                color: Color.fromRGBO(100, 91, 81, 0.7)
              ),
            ),
            SizedBox(width: 10,),
            Icon(Icons.two_wheeler_outlined, size: 35, color: Color.fromRGBO(100, 91, 81, 0.7),)
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        RefreshIndicator(
            child: Container(
              padding: EdgeInsets.fromLTRB(7, 30, 7, 30),
              decoration: BoxDecoration(
                color: Color.fromRGBO(234, 196, 152, 1),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(children: [
                TextButton(
                  onPressed: navigateMap,
                  child: Row(
                      children: [
                        Icon(Icons.map, color: Color.fromRGBO(238, 238, 238, 1),),
                        SizedBox(width: 15,),
                        Text("Откуда: ${context.read<Repository>().fromCityDriver ?? ""}",
                          style: TextStyle(
                            color: Color.fromRGBO(238, 238, 238, 1),
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                ),
                TextButton(
                  onPressed: navigateMap,
                  child: Row(
                      children: [
                        Icon(Icons.location_on, color: Color.fromRGBO(238, 238, 238, 1),),
                        SizedBox(width: 15,),
                        Text("Куда: ${context.read<Repository>().toCityDriver ?? ""}",
                          style: TextStyle(
                            color: Color.fromRGBO(238, 238, 238, 1),
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                ),
                _InputField(
                  placeholderIcon: Icons.punch_clock,
                  placeholderText: 'When :',
                  controller: _textFieldController3,
                ),
                _InputField(
                  placeholderIcon: Icons.person_2_rounded,
                  placeholderText: 'Name :',
                  controller: _textFieldController4,
                ),
                _InputField(
                  placeholderIcon: Icons.description,
                  placeholderText: 'Description and wishes :',
                  controller: _textFieldController5,
                ),
                _InputField(
                  placeholderIcon: Icons.people_alt,
                  placeholderText: 'Count people :',
                  controller: _textFieldController6,
                ),
              ]),
            ),
            onRefresh: refresh),
        SizedBox(
          height: 23,
        ),
        TextButton(
          onPressed: addCards,
          child: Text(
            'Добавить',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Colors.white,
            ),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(230, 160, 80, 1)),
              minimumSize:
              MaterialStateProperty.all<Size>(Size(double.infinity, 48))),
        ),
      ]),
    );
  }
}

class _InputField extends StatefulWidget {
  final String placeholderText;
  final IconData placeholderIcon;
  final TextEditingController controller;

  const _InputField(
      {Key? key,
        required this.placeholderText,
        required this.placeholderIcon,
        required this.controller})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  var textColor = Color.fromRGBO(238, 238, 238, 1);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.placeholderText,
        prefixIcon: Icon(
          widget.placeholderIcon,
          color: textColor,
        ),
        labelStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ),
        contentPadding: EdgeInsets.fromLTRB(0, 6, 10, 6),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.3),
        ),
      ),
      style: TextStyle(
        color: Colors.black38,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}