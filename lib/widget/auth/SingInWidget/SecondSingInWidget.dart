import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ri_and_go/Repository/Repository.dart';
import 'package:ri_and_go/Theme/app_authTextStyles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondSingWidget extends StatefulWidget {
  SecondSingWidget({Key? key}) : super(key: key);

  @override
  _SecondSingWidget createState() => _SecondSingWidget();
}

class _SecondSingWidget extends State<SecondSingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            _Header(),
          ],
        ));
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            _ButtonSingIn(),
            SizedBox(height: 75,),
            Image.asset("Assets/img/Vector.png"),
            SizedBox(height: 30,),
            _ButtonReges(),
            SizedBox(height: 20,),
            _FormWidget(),
          ])]);
  }
}

class _FormWidget extends StatefulWidget {
  _FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  final _nameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _secondPasswordTextController = TextEditingController();
  bool visiblePassword = true;
  bool checkPassword = true;

  int messageType = 0;
  final dio = Dio();
  Future<int> getRegisterCode() async {
    final response = await dio.post('http://194.67.105.79:5101/Users/AddNew', data: {
      "name": _nameTextController.text,
      "email": context.read<Repository>().emailAddress,
      "phoneNumber": context.read<Repository>().telephoneNumber,
      "password": _passwordTextController.text
    });
    return response.statusCode??-1;
  }

  void register() async {
    int code = await getRegisterCode();
    if (code == 200) {
      Navigator.of(context).pushNamed('mainScreen');

      await _setLogin();
      await _setPassword();
      await _setId(context.read<Repository>().id);
    } else if (code == 208){
      messageType == 1;
      context.read<Repository>().emailEmploy();
      Navigator.of(context).pushNamed('firstSingin');
    } else {
      messageType == 2;
    }
  }
  Future _setLogin() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('login', context.read<Repository>().emailAddress??"");
  }
  Future _setPassword() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('password', _passwordTextController.text);
  }

  Future _setId(id) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('password', id.toString());
  }

  void vizible() {
    setState(() {
      visiblePassword = !visiblePassword;
    });
  }

  void navigateNext() {
    if (_passwordTextController.text == _secondPasswordTextController.text) {
      Navigator.of(context).pushNamed('login');
      // TODO
      context.read<Repository>().setName(text: _nameTextController.text);
      context.read<Repository>().setPassword(
          text: _passwordTextController.text);
      checkPassword = true;
      setState(() {});
      register();
    }
    else {
      checkPassword = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Name',
                hoverColor: Colors.blueGrey
            ),
            controller: _nameTextController,
          ),

          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye_outlined),
                onPressed: vizible,
              ),
            ),
            obscureText: visiblePassword,
            controller: _passwordTextController,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Repeat Password',
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye_outlined),
                onPressed: vizible,
              ),
            ),
            obscureText: visiblePassword,
            controller: _secondPasswordTextController,
          ),
          if(!checkPassword)...[
            Text(
              'Введены различные пароли',
              style: TextStyle(
                color: Colors.red,
                fontSize: 17,
              ),
            ),
          ],
          if (messageType == 1) ...[
            Text('пользователь с такой почтой уже есть', style: TextStyle(
              color: Colors.red,
              fontSize: 17,
            ),)
          ] else if (messageType == 2) ... [
            Text('Проблемы с регистрацией', style: TextStyle(
              color: Colors.red,
              fontSize: 17,
            ),)
          ],

          SizedBox(height: 100),
          TextButton(
            onPressed: navigateNext,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xffE6A050)),
              fixedSize: MaterialStateProperty.all(Size(318, 45)),
            ),
            child: Text(
              'Regester',
              style: authStyles.LoginButton,
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonReges extends StatefulWidget {
  _ButtonReges({Key? key}) : super(key: key);

  @override
  _ButtonRegesState createState() => _ButtonRegesState();
}

class _ButtonRegesState extends State<_ButtonReges> {
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
              'Register',
              style: authStyles.buttonTextStyleActive,
          ),
        )
      ],
    );
  }
}

class _ButtonSingIn extends StatefulWidget {
  _ButtonSingIn({Key? key}) : super(key: key);

  @override
  _ButtonSingInState createState() => _ButtonSingInState();
}

class _ButtonSingInState extends State<_ButtonSingIn> {
  void navigateLogIn() => Navigator.of(context).pushNamed('login');
  void navigateBack() => Navigator.of(context).pushNamed('firstSingin');

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          icon: Icon(Icons.arrow_back, color: Color(0xffA6A6A6)),
          label: Text(
              "back",
              style: authStyles.smallButtons,
          ),
          onPressed: navigateBack,
        ),

        TextButton(
          onPressed: navigateLogIn,
          child: Text(
            'Log in',
            style: authStyles.smallButtons,
          ),
        ),
      ],
    );
  }
}
