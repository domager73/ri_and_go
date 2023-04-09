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
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image.asset("Assets/img/Vector.png"),
          const SizedBox(height: 25),
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

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      color: Color(0xff212529),
    );

    final buttonTextStyleActive = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
      decoration: TextDecoration.underline,
      decorationThickness: 2,
      decorationColor: Color(0xff854000),
      color: Color(0xffB97003)
    );
    final buttonTextStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
      color: Color(0xffA6A6A6),
    );

    final textDecorator = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {},
              child: Text('Login',
                style: buttonTextStyleActive),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Registre', style: buttonTextStyle),
            )
          ],
        ),
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
              onPressed: () {},
            ),
          ),
          obscureText: true,
          controller: _passwordTextController,
        ),
        SizedBox(
          height: 25,
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
