import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ri_and_go/widget/addCardWidget/mainAddWidget.dart';
import 'package:ri_and_go/widget/mainWidget/Search/mainSearch.dart';
import 'package:ri_and_go/widget/mainWidget/accountInfo/Profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static List<Widget> _widgetOptions = <Widget>[
    mainSearch(),
    AddMainUserWidget(),
    Profile(),
  ];

  int _selecttab = 2;

  void onSelectTab(int index){
    if(_selecttab == index) return;
    setState(() {
      _selecttab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
      body: Center(
        child: _widgetOptions[_selecttab],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffEAC498),
        selectedItemColor: Colors.white,
        currentIndex: _selecttab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_outlined),
              label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],

        onTap: onSelectTab,
      ),
    ),
      onWillPop: () async => false,
    );
  }
}