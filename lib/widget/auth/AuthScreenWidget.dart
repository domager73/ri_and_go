import 'package:flutter/material.dart';

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
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset("Assets/img/Vector.png"),
          _ButtonAuth(),
          _FormWidget(),

        ]));
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

    return Column(
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
        TextButton(
            onPressed: () {},
            child: Text(
              'Login'
            ),
        ),
      ],
    );
  }
}

class _ButtonAuth extends StatefulWidget {
  _ButtonAuth({Key? key}) : super(key: key);

  @override
  _ButtonAuthState createState() => _ButtonAuthState();
}

class _ButtonAuthState extends State<_ButtonAuth> {
  @override
  Widget build(BuildContext context) {
    final styleButton = ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Color(0xffB97003)),
    );

    final buttonTextStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
              'Login',
              style: buttonTextStyle,
          ),
          style: styleButton,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
              'Register',
              style: buttonTextStyle
          ),
          style: styleButton,
        )
      ],
    );
  }
}
