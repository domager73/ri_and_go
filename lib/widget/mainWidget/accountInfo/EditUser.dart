import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ri_and_go/Card/card.dart';
import 'package:ri_and_go/Repository/Repository.dart';
import 'package:ri_and_go/Theme/app_profileStyles.dart';
import 'package:ri_and_go/Url/apiSetting.dart';
import 'package:ri_and_go/widget/mainWidget/Search/mainSearch.dart';
import 'package:ri_and_go/widget/mainWidget/accountInfo/AdItemWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _urlTextController = TextEditingController();
  bool flag = true;
  String password = '';

  Future repositoryCommit() async {
    context.read<Repository>().setName(text: _nameTextController.value.text);
    context.read<Repository>().setEmailAddress(
        text: _emailTextController.value.text);
    context.read<Repository>().setTelephoneNumber(
        text: _phoneTextController.value.text);
    context.read<Repository>().setUrl(newUrl: _urlTextController.value.text);
  }


  void sendChanges() {
    final dio = Dio();
    dio.post(apiSettings.baseUrl + 'Users/SetUser', data: {
      'id': context
          .read<Repository>()
          .id,
      'name': _nameTextController.value.text,
      'email': _emailTextController.value.text,
      'phoneNumber': _phoneTextController.value.text,
      'contactUrl': _urlTextController.value.text,
      'password': password,
    }).then((response) => print(response.statusCode));
  }

  void commitChanges() {
    repositoryCommit()
        .then((value) => Navigator.of(context).pushNamed('mainScreen'));
    sendChanges();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController.text = context
        .read<Repository>()
        .name;
    _emailTextController.text = context
        .read<Repository>()
        .emailAddress ?? "";
    _phoneTextController.text =
        context
            .read<Repository>()
            .telephoneNumber ?? "";
    _urlTextController.text = context
        .read<Repository>()
        .contactUrl;
    password = context
        .read<Repository>()
        .password ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Assets/img/bg.png'),
                repeat: ImageRepeat.repeat
                
              ),
            ),
            child: Expanded(
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
                //SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                SizedBox(width: 100),
                _Avatar(),
                ButtonCansel(),
              ],
            ),
            SizedBox(height: 5),
            //_Elements(),
            Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Info_Field(
                          name: 'Имя', controller: _nameTextController),
                      _Info_Field(
                          name: 'Email', controller: _emailTextController),
                      _Info_Field(
                          name: 'Телефон',
                          controller: _phoneTextController),
                      Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: 20, bottom: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: _urlTextController.text == ''
                                      ? [
                                    Text(
                                      'Url соцсетей',
                                      style: profileTextes.Elements,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image(
                                        image: AssetImage(
                                            'Assets/img/urlAlert.png')),
                                  ]
                                      : [
                                    Text(
                                      'Url соцсетей',
                                      style: profileTextes.Elements,
                                    )
                                  ],
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                      labelStyle: profileTextes.Info,
                                      hintStyle: profileTextes.Info,
                                      //hintText: 'ы',
                                      hoverColor: Colors.blueGrey,
                                      suffixIcon:
                                      Icon(Icons.edit_outlined)),
                                  controller: _urlTextController,
                                  onChanged: (zbobz) {
                                    print(_urlTextController.value.text);
                                  },
                                ),
                              ]))
                    ])),

            TextButton(
              onPressed: commitChanges,
              child: Text('Сохранить',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(MediaQuery
                        .of(context)
                        .size
                        .width * 0.8, 50)),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.fromLTRB(10, 15, 0, 15)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                backgroundColor:
                MaterialStateProperty.all<Color>(Color.fromRGBO(
                    226, 143, 143, 1)),
              ),
            )
            ],
          ),
        ),
      ),
    ),)
    );
  }
}

class ButtonCansel extends StatefulWidget {
  ButtonCansel({Key? key}) : super(key: key);

  @override
  _ButtonCanselState createState() => _ButtonCanselState();
}


class _ButtonCanselState extends State<ButtonCansel> {
  Color buttonColor = Color.fromRGBO(146, 146, 146, 1);

  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => {Navigator.of(context).pushNamed('mainScreen')},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 8,
            ),
            Text(
              'CANSEL',
              style: TextStyle(color: buttonColor, fontSize: 16),
            ),
            Icon(
              Icons.arrow_circle_right_outlined,
              size: 18,
              color: buttonColor,
            ),
          ],
        ));
  }
}

class _Info_Field extends StatefulWidget {
  String name;
  TextEditingController controller;

  _Info_Field({Key? key, required this.name, required this.controller})
      : super(key: key);

  @override
  _InfoFieldState createState() => _InfoFieldState();
}

class _InfoFieldState extends State<_Info_Field> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10, left: 20, bottom: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.name,
            style: profileTextes.Elements,
          ),
          TextField(
            decoration: InputDecoration(
                labelStyle: profileTextes.Info,
                hintStyle: profileTextes.Info,
                //hintText: 'ы',
                hoverColor: Colors.blueGrey,
                suffixIcon: Icon(Icons.edit_outlined)),
            controller: widget.controller,
            onChanged: (aboba) {
              print(widget.controller.text);
            },
          ),
        ]));
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
