import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ri_and_go/Repository/Repository.dart';
import 'package:ri_and_go/Url/apiSetting.dart';
import 'package:ri_and_go/widget/mainWidget/accountInfo/AdItemWidget.dart';
import 'package:ri_and_go/Card/card.dart' as card;

class mainSearch extends StatefulWidget {
  mainSearch({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<mainSearch> {
  bool flag = true ;
  void openSearchMenu() {
    Navigator.of(context).pushNamed('search');
  }

  Future loadAllTrips() async {
    final dio = Dio();
    final response = await dio.get(apiSettings.baseUrl + 'Trips/GetAll');
    List data = response.data;
    context.read<Repository>().cities = [];
    context.read<Repository>().resetTripList();
    List<card.CardTrip> newLoadedTrips = [];
    data.forEach((trip) async {
      final resp = await dio.get(apiSettings.baseUrl + 'Users/Get/${trip["creatorId"]}');
      final author = card.User(name: resp.data["name"], id: resp.data['id']);
      trip = card.CardTrip(nameOfTrip: trip['name'], date: trip['departureTime'].toString(), author: author, description: trip['description']);
      newLoadedTrips.add(trip);
    });
    context.read<Repository>().cities = newLoadedTrips;
    flag = false;
  }
  Future<void> refresh()async {
    setState(() {
      flag = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (flag) {
      loadAllTrips();
    }

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
      body:  RefreshIndicator(
        onRefresh: refresh,
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
                    itemAuthor: e.author.name,
                    itemDescription: e.description,
                    authorId: e.author.id,
                  )).toList()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openSearchMenu,
        backgroundColor: Color(0xffFFB74B),
        child: Icon(Icons.search_outlined, color: Colors.white),
      ),
    ); /* add child content here */
  }
}
