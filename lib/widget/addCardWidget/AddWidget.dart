import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ri_and_go/Url/apiSetting.dart';

import '../../Repository/Repository.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _FormAreaState createState() => _FormAreaState();
}

class _FormAreaState extends State<AddUser> {
  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  final TextEditingController _textFieldController3 = TextEditingController();
  final TextEditingController _textFieldController4 = TextEditingController();
  final TextEditingController _textFieldController5 = TextEditingController();

  String? placeFrom;
  String? placeWhere;
  String? time;
  String? name;
  String? descr;

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
      "tripType": false,
      "maxPassengers": 1
    });
    Navigator.of(context).pushNamed('mainScreen');
  }

  void addCards() {
    // placeFrom = _textFieldController1.text;
    // placeWhere = _textFieldController2.text;
    // time = _textFieldController3.text;
    // name = _textFieldController4.text;
    // descr = _textFieldController5.text;
    addCard();
    setState(() {});
  }

  void navigateMap() {
    Navigator.of(context).pushNamed('mapUser');
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
              'User',
              style: TextStyle(
                fontSize: 50,
              ),
            ),
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
                  child: Text(
                    "Откуда: ${context.read<Repository>().fromCityUser??""}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: navigateMap,
                  child: Text(
                    "Куда: ${context.read<Repository>().toCityUser??""}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
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
              ]),
            ),
            onRefresh: refresh),
        SizedBox(
          height: 23,
        ),
        //TODO
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
