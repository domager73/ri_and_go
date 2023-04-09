import 'package:flutter/material.dart';
import 'package:ri_and_go/Theme/app_authTextStyles.dart';

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
    const textStyle = TextStyle(
      fontSize: 16,
      color: Colors.black,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 75,),
          Image.asset("Assets/img/Vector.png"),
          SizedBox(height: 30,),
          _ButtonAuth(),
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
  int countClick = 1;

  void vizible() {
    setState(() {
      visiblePassword = !visiblePassword;
    });
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
          SizedBox(height: 120),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xffE6A050)),
              fixedSize: MaterialStateProperty.all(Size(318, 45)),
            ),
            child: Text(
              'Login',
              style: authTextes.LoginButton,
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
              'Login',
              style: authTextes.buttonTextStyleActive,
          ),
        ),
        TextButton(
            onPressed: navigateRegester,
            child: Text(
                'Register',
                style: authTextes.buttonTextStyle,
            )
        )
      ],
    );
  }
}