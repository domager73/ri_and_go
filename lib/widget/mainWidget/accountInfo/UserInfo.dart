import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ri_and_go/Theme/app_profileStyles.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool contacts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffEAC498),
        title: Text('Автор'),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 15)),
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.2),
                _Avatar(),
              ],
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.03),
            _Elements(),
            Container(
              margin: EdgeInsets.only(top: 100, left: 40, right: 40),
              height: 57,
              width: 300,
              child: contacts
                  ? TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  backgroundColor: MaterialStateProperty.all(Color(0xfff0ce75)),
                ),
                child: Text(
                  'Написать',
                  textAlign: TextAlign.center,
                  style: profileTextes.contactButton,
                ),
              )
                  : Text(
                'Этот пользователь не указал соцсети для связи',
                style: profileTextes.noContacts,
                textAlign: TextAlign.center,
              ),
            )
          ],
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
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
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
              value: 'Dima',
            ),
            _Info_Field(
              name: 'Email',
              value: 'asdfas@asfd.ru',
            ),
            _Info_Field(
              name: 'Telephone',
              value: '+7927882608',
            ),
          ],
        )
      ],
    );
  }
}