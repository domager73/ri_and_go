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
  bool flag = true;
  bool tripAskType = true;

  void logOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('login');
    prefs.remove('password');
    prefs.remove('id');
    context.read<Repository>().logOut();
    Navigator.of(context).pushNamed('login');
  }

  Future loadUserTrips() async {
    final dio = Dio();
    final response = await dio.get(apiSettings.baseUrl +
        'Trips/GetUserTrips/${context.read<Repository>().id}');
    List data = response.data;
    context.read<Repository>().resetTripList();
    List<card.CardTrip> newList = [];
    data.forEach((trip) {
      var newTrip = card.CardTrip(
          nameOfTrip: trip['name'],
          date: trip['departureTime'].toString(),
          author: card.User(
              name: context.read<Repository>().name ?? "",
              id: context.read<Repository>().id ?? 0),
          description: trip['description'],
          tripType: trip['tripType'],
          id: trip['id']);
      newList.add(newTrip);
    });
    context.read<Repository>().authorView = newList;
    flag = false;
  }

  Future loadUserFollow() async {}

  @override
  void initState() {
    super.initState();
    // loadUserTrips();
    // loadProfileInfo();
  }

  Future<int> loadProfileInfo() async {
    final dio = Dio();
    print(apiSettings.baseUrl + 'Users/Get/${context.read<Repository>().id}');
    final response = await dio.get(
        apiSettings.baseUrl + 'Users/Get/${context.read<Repository>().id}');
    context.read<Repository>().setName(text: response.data['name']);
    context.read<Repository>().setEmailAddress(text: response.data['email']);
    context
        .read<Repository>()
        .setTelephoneNumber(text: response.data['phoneNumber']);
    context.read<Repository>().setUrl(newUrl: response.data['contactUrl']);
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    if (flag) {
      loadProfileInfo().then((value) => setState(() {}));
      loadUserTrips().then((value) => setState(() {}));
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/img/bg.png'),
                repeat: ImageRepeat.repeat),
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
              Text(
                'Созданные поездки',
                style: TextStyle(
                    color: Color.fromRGBO(133, 64, 0, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic),
              ),
              // TextButton(
              //     onPressed: () {
              //       tripAskType = !tripAskType;
              //       loadUserTrips().then((value) => setState(() {}));
              //     },
              //     child: Text(
              //       tripAskType ? 'Созданные поездки' : 'созданные запроосы',
              //       style: TextStyle(color: Colors.black, fontSize: 25),
              //     )),
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
              value: context.read<Repository>().name,
            ),
            _Info_Field(
              name: 'Email',
              value: context.read<Repository>().emailAddress ?? "",
            ),
            _Info_Field(
              name: 'Telephone',
              value: context.read<Repository>().telephoneNumber ?? "",
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
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffEBEBEB),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.56),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ]),
              margin: EdgeInsets.only(left: 10, right: 10),
              height: MediaQuery.of(context).size.height * 0.27,
              padding: EdgeInsets.all(10),
              child: ListView(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                scrollDirection: Axis.vertical,
                children: [
                  Column(
                      children: context
                          .read<Repository>()
                          .authorView
                          .map((e) => AdDeletebleItemWidget(
                                //itemIcon: Icons.car_crash_outlined,
                                itemDate: e.date,
                                itemName: e.nameOfTrip,
                                itemAuthor: e.author.name,
                                itemDescription: e.description,
                                authorId: e.author.id,
                                itemId: e.id,
                                tripType: e.tripType,
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
