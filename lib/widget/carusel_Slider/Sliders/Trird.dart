import 'package:flutter/material.dart';
import 'package:ri_and_go/Theme/app_authTextStyles.dart';

class ThirdSlide extends StatefulWidget {
  ThirdSlide({
    Key? key,
  }) : super(key: key);

  @override
  _ThirdSlideState createState() => _ThirdSlideState();
}

class _ThirdSlideState extends State<ThirdSlide> {

  void nextMainScreen() {
    Navigator.of(context).pushNamed('mainScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("Assets/img/Word.png"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                'Не трать время на долгие поиски попутчиков и путешественников,' +
                    'присоединяйся к нашему сообществу и наслаждайся приятной поездкой в компании интересных людей!',
                style: authStyles.HelpPanel,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            TextButton(
              onPressed: nextMainScreen,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffE6A050)),
                fixedSize: MaterialStateProperty.all(Size(318, 45)),
              ),

              child: Text(
                'Продолжить',
                style: authStyles.LoginButton,
              ),
            )
          ],
        ),
      ),
    );
  }
}
