import 'package:flutter/material.dart';
import 'package:ri_and_go/Theme/app_authTextStyles.dart';

class SingWidget extends StatefulWidget {
  SingWidget({Key? key}) : super(key: key);

  @override
  _SingWidget createState() => _SingWidget();
}

class _SingWidget extends State<SingWidget> {
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
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool visiblePassword = true;

  void vizible() {
    setState(() {
      visiblePassword = !visiblePassword;
    });
  }

  void navigateNext() => Navigator.of(context).pushNamed('secondSingin');

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
                labelText: 'Email Address',
                hoverColor: Colors.blueGrey),
            controller: _loginTextController,
          ),

          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: 'Telephonr Number',
                hoverColor: Colors.blueGrey),
            obscureText: visiblePassword,
            controller: _passwordTextController,
          ),
          SizedBox(height: 120),
          ElevatedButton(
            onPressed: navigateNext,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xffE6A050)),
              fixedSize: MaterialStateProperty.all(Size(318, 45)),
            ),
            child: Text(
              'Continue',
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
      children:[
      Text(
        'Register',
        style: authStyles.buttonTextStyleActive,
      ),
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

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
