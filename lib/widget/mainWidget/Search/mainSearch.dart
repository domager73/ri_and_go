import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ri_and_go/Repository/Repository.dart';
import 'package:ri_and_go/widget/mainWidget/accountInfo/AdItemWidget.dart';

class mainSearch extends StatefulWidget {
  mainSearch({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<mainSearch> {
  void openSearchMenu() {
    Navigator.of(context).pushNamed('search');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFEA9E),
        toolbarHeight: 40,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Активные поездки',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/img/SearchBackground.png"),
          ),
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 200,
            maxHeight: MediaQuery.of(context).size.height - 148,
          ),
          padding: EdgeInsets.all(10),
          color: Color(0xffEBEBEB),
          child: ListView(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            scrollDirection: Axis.vertical,
            children: [
              Column(
                  children: context
                      .read<Repository>()
                      .cities
                      .map((e) => AdItemWidget(
                            itemIcon: Icons.accessible_forward,
                            itemDate: e.date,
                            itemName: e.nameOfTrip,
                            itemAuthor: e.author,
                            itemDescription: e.description,
                          ))
                      .toList()),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openSearchMenu,
        backgroundColor: Color(0xffFFB74B),
        child: Icon(Icons.search_outlined, color: Colors.white),
      ) /* add child content here */,
    );
  }
}