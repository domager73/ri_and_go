import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  bool flag = true;
  void openSearchMenu() {
    context.read<Repository>().clearSearchSettings();
    Navigator.of(context).pushNamed('search');
  }

  bool tripAskType = true;

  Future loadAllTrips() async {
    final dio = Dio();
    var searchSettings = context.read<Repository>().searchSettings;
    print(searchSettings);
    List<card.CardTrip> newLoadedTrips = [];
    if (searchSettings.isEmpty) {
      final response = await dio.get(apiSettings.baseUrl + 'Trips/GetAll');
      List data = response.data;
      context.read<Repository>().cities = [];
      context.read<Repository>().resetTripList();

      data.forEach((trip) async {
        if (trip['tripType'] == tripAskType) {
          final resp = await dio
              .get(apiSettings.baseUrl + 'Users/Get/${trip["creatorId"]}');
          final author =
              card.User(name: resp.data["name"], id: resp.data['id']);
          var newTrip = card.CardTrip(
              nameOfTrip: trip['name'],
              date: trip['departureTime'].toString(),
              author: author,
              description: trip['description'],
              tripType: tripAskType,
              id: trip['id']);
          newLoadedTrips.add(newTrip);
        }
      });
    } else {
      print('search settings');
      final response = await dio.post(apiSettings.baseUrl + 'Trips/FetchTrips',
          data: searchSettings);
      List data = response.data;
      print(data);
      context.read<Repository>().cities = [];
      context.read<Repository>().resetTripList();

      data.forEach((trip) async {
        if (trip['tripType'] == tripAskType) {
          final resp = await dio
              .get(apiSettings.baseUrl + 'Users/Get/${trip["creatorId"]}');
          final author =
              card.User(name: resp.data["name"], id: resp.data['id']);
          var newTrip = card.CardTrip(
              nameOfTrip: trip['name'],
              date: trip['departureTime'].toString(),
              author: author,
              description: trip['description'],
              tripType: tripAskType,
              id: trip['id']);
          newLoadedTrips.add(newTrip);
        }
      });
    }

    context.read<Repository>().cities = newLoadedTrips;
    flag = false;
  }

  Future<void> refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllTrips();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 234, 158, 1),
          toolbarHeight: 45,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('Активные запросы',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300
              )
          )
          // TextButton(onPressed: () {tripAskType = !tripAskType; loadAllTrips(); setState(() {
          //
          // });}, child: Text(
          //   tripAskType? 'Созданные поездки' : 'созданные запроосы',
          //   style: TextStyle(color: Colors.black, fontSize: 25),
          // )),
          ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/img/bg.png'),
                repeat: ImageRepeat.repeat),
          ),
          constraints: BoxConstraints(
            minHeight: 200,
            maxHeight: MediaQuery.of(context).size.height - 148,
          ),
          padding: EdgeInsets.all(10),
          // color: Color(0xffEBEBEB),
          child: ListView(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            scrollDirection: Axis.vertical,
            children: [
              Column(
                  children: context
                      .read<Repository>()
                      .cities
                      .map((e) => AdItemWidget(
                            itemIcon: Icons.car_crash_outlined,
                            itemDate: e.date,
                            itemName: e.nameOfTrip,
                            itemAuthor: e.author.name,
                            itemDescription: e.description,
                            authorId: e.author.id,
                            tripType: tripAskType,
                          ))
                      .toList()),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        //onPressed: openSearchMenu,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22),
        backgroundColor: Color(0xFFFFB74B),
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
              child: Icon(Icons.assignment_turned_in, color: Colors.white),
              backgroundColor: Color(0xFFFFB74B),
              onTap: () {
                tripAskType = !tripAskType;
                loadAllTrips();
                setState(() {});
              },
              label: 'Сменить тип объявлений',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: Color(0xFFFFB74B)),
          // FAB 2
          SpeedDialChild(
              child: Icon(
                Icons.search_outlined,
                color: Colors.white,
              ),
              backgroundColor: Color(0xFFFFB74B),
              onTap: openSearchMenu,
              label: 'Поиск',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: Color(0xFFFFB74B))
        ],
      ),
    ); /* add child content here */
  }
}
