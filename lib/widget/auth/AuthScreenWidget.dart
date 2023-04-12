import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ri_and_go/Theme/app_authTextStyles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ri_and_go/Url/apiSetting.dart';

import '../../Repository/Repository.dart';

class AuthWidget extends StatefulWidget {
  AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidget createState() => _AuthWidget();
}

class _AuthWidget extends State<AuthWidget> {
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
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 75,
        ),
        Image.asset("Assets/img/Vector.png"),
        SizedBox(
          height: 30,
        ),
        _ButtonAuth(),
        SizedBox(
          height: 20,
        ),
        _FormWidget(),
      ])
    ]);
  }
}

class _FormWidget extends StatefulWidget {
  _FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool normalWrite = true;
  bool visiblePassword = true;
  int countClick = 1;

  bool reg = false;
  final dio = Dio();

  void _isRegistered() async {
    var prefs = await SharedPreferences.getInstance();
    reg = (prefs.getString('login') != null &&
        prefs.getString('password') != null);
    if (reg) {
      Navigator.of(context).pushNamed('mainScreen');
      print('reg');
      context.read<Repository>().password = prefs.getString('password');
    }
  }


  bool existsUser = false;

  Future<bool> userExist() async {
    //dio.get(apiSettings.baseUrl + 'Users/Login/${_loginTextController.text}/${_passwordTextController.text}').then((response) => {existsUser = response.data});
    final response = await dio.get(apiSettings.baseUrl + 'Users/Login/${_loginTextController.text}/${_passwordTextController.text}');
    if (response.data != -1) {
      context.read<Repository>().setId(newId: response.data);
    }
    return response.data != -1;
  }

  Future<int> loadProfileInfo() async {
    final response = await dio.get(apiSettings.baseUrl + 'Users/Get/${context.read<Repository>().id}');
    context.read<Repository>().setName(text: response.data['name']);
    context.read<Repository>().setEmailAddress(text:  response.data['email']);
    context.read<Repository>().setTelephoneNumber(text:  response.data['phoneNumber']);
    return 1;
  }


  void login() async {
    if (await userExist()) {
      await loadProfileInfo();
      Navigator.of(context).pushNamed('mainScreen');

      await _setLogin();
      await _setPassword();
      await _setId(context.read<Repository>().id);
    } else {
      normalWrite = false;
      setState(() {});
    }
  }

  Future _setLogin() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('login', _loginTextController.text);
  }
  Future _setPassword() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('password', _loginTextController.text);
  }
  Future _setId(id) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('password', id.toString());
  }

  void vizible(){
    setState(() {
      visiblePassword = !visiblePassword;
    });
  }


  @override
  Widget build(BuildContext context) {
    _isRegistered();
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                hoverColor: Colors.blueGrey),
            controller: _loginTextController,
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
          if (!normalWrite) ...[
            Text(
              'Есть не введенное поле',
              style: TextStyle(
                color: Colors.red,
                fontSize: 17,
              ),
            ),
          ],
          SizedBox(height: 120),
          TextButton(
            onPressed: login,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xffE6A050)),
              fixedSize: MaterialStateProperty.all(Size(318, 45)),
            ),
            child: Text(
              'Войти',
              style: authStyles.LoginButton,
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonAuth extends StatefulWidget {
  _ButtonAuth({Key? key}) : super(key: key);

  @override
  _ButtonAuthState createState() => _ButtonAuthState();
}

class _ButtonAuthState extends State<_ButtonAuth> {
  void navigateRegester() => Navigator.of(context).pushNamed('firstSingin');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Войти',
            style: authStyles.buttonTextStyleActive,
          ),
        ),
        TextButton(
            onPressed: navigateRegester,
            child: Text(
              'Регестрация',
              style: authStyles.buttonTextStyle,
            ))
      ],
    );
  }
}
