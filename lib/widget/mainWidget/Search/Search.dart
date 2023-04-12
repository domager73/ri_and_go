import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Поиск'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            _AddTrip(),
          ],
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
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        height: MediaQuery.of(context).size.height - 56,
        child: ListView(
          children: [
            Icon(
              Icons.car_repair_outlined,
              size: 150,
              color: Colors.black,
            ),
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
  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  final TextEditingController _textFieldController3 = TextEditingController();

  String placeFrom = '';
  String placeWhere = '';
  String time = '';

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
          child: Column(children: [
            _InputField(
              placeholderIcon: Icons.place,
              placeholderText: 'Откуда :',
              controller: _textFieldController1,
            ),
            _InputField(
              placeholderIcon: Icons.temple_hindu,
              placeholderText: 'Куда :',
              controller: _textFieldController2,
            ),
            _InputField(
              placeholderIcon: Icons.punch_clock,
              placeholderText: 'Когда :',
              controller: _textFieldController3,
            ),
          ]),
        ),
        SizedBox(
          height: 23,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              placeFrom = _textFieldController1.text;
              placeWhere = _textFieldController2.text;
              time = _textFieldController3.text;
              print(placeFrom);
              print(placeWhere);
              print(time);
            });
          },
          child: Text(
            'Click me',
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
