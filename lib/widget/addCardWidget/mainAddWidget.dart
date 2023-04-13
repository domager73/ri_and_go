import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'AddWidget.dart';
import 'driverCardWidget.dart';

class AddMainUserWidget extends StatefulWidget {
  const AddMainUserWidget({Key? key}) : super(key: key);

  @override
  _AddMainUserWidgetState createState() => _AddMainUserWidgetState();
}

class _AddMainUserWidgetState extends State<AddMainUserWidget> {
  int currentIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    AddDriver(),
    AddUser(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.8,
                        child: PageView.builder(
                            onPageChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            itemCount: _widgetOptions.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  child: _widgetOptions[index],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < _widgetOptions.length; i++)...[
                        buildIndicator(currentIndex == i),
                        SizedBox(width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.03,),
                      ]
                    ],
                  ),
                ]
            ),
          ),
        )
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Container(
      height: isSelected ? 20 : 16,
      width: isSelected ? 20 : 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.black : Colors.orangeAccent,
      ),
    );
  }
}
