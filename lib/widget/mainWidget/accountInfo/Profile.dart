import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ri_and_go/Repository/Repository.dart';
import 'package:ri_and_go/Theme/app_profileStyles.dart';
import 'package:ri_and_go/widget/mainWidget/accountInfo/AdItemWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ri_and_go/Card/card.dart' as card;
import 'package:ri_and_go/Url/apiSetting.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void logOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('login');
    prefs.remove('password');
    Navigator.of(context).pushNamed('login');
  }

  Future loadUserTrips() async {
    final dio = Dio();
    final response = await dio.get(apiSettings.baseUrl + 'Trips/GetUserTrips/${context.read<Repository>().id}');
    List data = response.data;
    data.forEach((trip) {
      trip = card.CardTrip(nameOfTrip: trip['name'], date: trip['date'].toString(), author: card.User(name: context.read<Repository>().name??"", id: context.read<Repository>().id??0), description: trip['description']);
      context.read<Repository>().addownTrip(trip);
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserTrips();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/img/SearchBackground.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.only(top: 15)),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Уверены что хотите выйти?'),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                          onPressed: logOut, child: Text('Да')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Эээ куда'))
                                    ],
                                  )
                                ],
                              );
                            });
                      },
                      child: Text(
                        'log out',
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff929292)),
                      )),
                  _Avatar(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('editUser');
                      },
                      child: context.read<Repository>().urlExist
                          ? Text(
                              'edit',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xff929292)),
                            )
                          : Row(
                              children: [
                                Image(
                                    image:
                                        AssetImage('Assets/img/urlAlert.png')),
                                Padding(padding: EdgeInsets.only(left: 5)),
                                Text(
                                  'edit',
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xff929292)),
                                )
                              ],
                            )),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              _Elements(),
              _MyTrip(),
            ],
          ),
        ),
      ),
    );
  }
}


class _Info_Field extends StatefulWidget {
  String name;
  String value;

  _Info_Field({Key? key, required this.name, required this.value})
      : super(key: key);

  @override
  _InfoFieldState createState() => _InfoFieldState();
}

class _InfoFieldState extends State<_Info_Field> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: profileTextes.Elements,
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Color(0xff4D361C),
              width: 1,
            ))),
            child: Text(
              widget.value,
              style: profileTextes.Info,
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatefulWidget {
  const _Avatar({Key? key}) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<_Avatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.amberAccent,
      child: CircleAvatar(
        backgroundImage: AssetImage('Assets/img/avatar.jpg'),
        radius: 60,
      ),
      radius: 65,
    );
  }
}

class _Elements extends StatefulWidget {
  const _Elements({Key? key}) : super(key: key);

  @override
  _ElementsState createState() => _ElementsState();
}

class _ElementsState extends State<_Elements> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            _Info_Field(
              name: 'Name',
              value: context.read<Repository>().name??"",
            ),
            _Info_Field(
              name: 'Email',
              value: context.read<Repository>().emailAddress??"",
            ),
            _Info_Field(
              name: 'Telephone',
              value: context.read<Repository>().telephoneNumber??"",
            ),
          ],
        )
      ],
    );
  }
}


class _MyTrip extends StatelessWidget {
  _MyTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Own trip list',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: MediaQuery.of(context).size.height * 0.27,
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
          ],
        ),
      ),
    );
  }
}
