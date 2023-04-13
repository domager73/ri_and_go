import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Repository/Repository.dart';
import '../../../maskByText/mask.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Поиск'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Container(
          child: Column(
            children: [
              _AddTrip(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddTrip extends StatefulWidget {
  const _AddTrip({Key? key}) : super(key: key);

  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<_AddTrip> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/img/bg.png'),
              repeat: ImageRepeat.repeat
            ),
        ),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        height: MediaQuery.of(context).size.height - 56,
        child: ListView(
          children: [
            SizedBox(height: 15,),
            Image(image: AssetImage('Assets/img/splashIcon.png'), width: 110, height: 110),
            SizedBox(height: 25,),
            _FormArea(),
          ],
        ),
      ),
    );
  }
}

class _FormArea extends StatefulWidget {
  const _FormArea({Key? key}) : super(key: key);

  @override
  _FormAreaState createState() => _FormAreaState();
}

class _FormAreaState extends State<_FormArea> {
  var textColor = Color.fromRGBO(238, 238, 238, 1);
  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  final TextEditingController _textFieldController3 = TextEditingController();

  String placeFrom = '';
  String placeWhere = '';
  String time = '';

  void navigateMap() {
    Navigator.of(context).pushNamed('map');
  }

  void search() async {
    print(_textFieldController2.text);
    print(_textFieldController1.text);
    context.read<Repository>().clearSearchSettings();
    context.read<Repository>().setSearchSettings(_textFieldController1.text, _textFieldController2.text, _textFieldController3.text);
    print(context.read<Repository>().searchSettings);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
          padding: EdgeInsets.fromLTRB(7, 30, 7, 30),
          decoration: BoxDecoration(
            color: Color.fromRGBO(234, 196, 152, 1),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: navigateMap,
                    child: Row(
                      children: [
                        Icon(Icons.map, color: textColor,),
                        SizedBox(width: 15,),
                        Text(
                          "Откуда: ${context.read<Repository>().fromCitySearch ?? ""}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                ),
                TextButton(
                  onPressed: navigateMap,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: textColor,),
                      SizedBox(width: 15,),
                      Text(
                        "Куда: ${context.read<Repository>().toCitySearch ?? ""}",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: _textFieldController3,
                  inputFormatters: [maskFormatterDate],
                  decoration: InputDecoration(
                    labelText: 'Когда :',
                    prefixIcon: Icon(
                      Icons.punch_clock,
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
                )
              ]),
        ),
        SizedBox(
          height: 23,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              context.read<Repository>().setFromCitySearch("");
              context.read<Repository>().setToCitySearch("");
              context.read<Repository>().clearSearchSettings();
              context.read<Repository>().setSearchSettings(_textFieldController1.text, _textFieldController2.text, _textFieldController3.text);
              print(context.read<Repository>().searchSettings);
              Navigator.of(context).pop();
              search();
            });
          },
          child: Text(
            'Найти',
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

