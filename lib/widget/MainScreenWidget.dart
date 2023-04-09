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
        Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image.network('https://picsum.photos/250?image=9'),
                const SizedBox(height: 25),
                _FormWidget(),
              ]
              )
          ),
      ],
    );
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

    final styleButton = ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Color(0xffB97003)),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text('Login'),
              style: styleButton,
            ),
            TextButton(
              onPressed: () {},
              child: Text('Reset password'),
              style: styleButton,
            )
          ],
        ),
        SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: 'Введите ваше сообщение',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Сообщение',
            prefixIcon: Icon(Icons.message),
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {},
            ),
          ),
          controller: _loginTextController,
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Сообщение',
            prefixIcon: Icon(Icons.message),
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {},
            ),
          ),

          obscureText: true,
          controller: _passwordTextController,
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
