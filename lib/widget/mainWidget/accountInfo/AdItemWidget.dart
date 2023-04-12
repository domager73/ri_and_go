import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ri_and_go/Repository/Repository.dart';
import 'package:ri_and_go/Theme/app_cardStyles.dart';

class AdItemWidget extends StatefulWidget {
  IconData itemIcon;
  String itemName;
  String itemDate;
  String itemDescription;
  String itemAuthor;
  int authorId;

  AdItemWidget({
    Key? key,
    required this.itemIcon,
    required this.itemName,
    required this.itemDate,
    required this.itemAuthor,
    required this.itemDescription,
    required this.authorId
  }) : super(key: key);

  @override
  _AdItemWidgetState createState() => _AdItemWidgetState();
}

class _AdItemWidgetState extends State<AdItemWidget> {
  bool isOpen = false;

  void open() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: open,
      child: Container(
        margin: EdgeInsets.only(bottom: 15, top: 0),
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: isOpen
              ? [
            _mainCardBody(
                itemIcon: widget.itemIcon,
                itemName: widget.itemName,
                itemDate: widget.itemDate),
            _cardDescription(
              description: widget.itemDescription,
              authorName: widget.itemAuthor,
              authorId: widget.authorId,
            ),
          ]
              : [
            _mainCardBody(
                itemIcon: widget.itemIcon,
                itemName: widget.itemName,
                itemDate: widget.itemDate)
          ],
        ),
      ),
    );
  }
}

class _mainCardBody extends StatefulWidget {
  final IconData itemIcon;
  final String itemName;
  final String itemDate;

  const _mainCardBody(
      {Key? key,
        required this.itemIcon,
        required this.itemName,
        required this.itemDate})
      : super(key: key);

  @override
  _mainCardBodyState createState() => _mainCardBodyState();
}

class _mainCardBodyState extends State<_mainCardBody> {
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(
        widget.itemIcon,
        size: 56,
      ),
      SizedBox(
        width: 22,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          FittedBox(
            fit: BoxFit.fill,
            child: Text(widget.itemName, style: mainTextes.title),
          ),

          SizedBox(
            height: 10,
          ),
          Text(
            widget.itemDate,
            style: mainTextes.date,
          )
        ],
      ),
      Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle_notifications_rounded,
                size: 10,
              ),
              Icon(
                Icons.circle_notifications_rounded,
                size: 10,
              ),
              Icon(
                Icons.circle_notifications_rounded,
                size: 10,
              ),
            ],
          ))
    ]);
  }
}

class _cardDescription extends StatefulWidget {
  final String description;
  final String authorName;
  final int authorId;

  const _cardDescription(
      {Key? key, required this.description, required this.authorName, required this.authorId})
      : super(key: key);

  @override
  _cardDescriptionState createState() => _cardDescriptionState();
}

class _cardDescriptionState extends State<_cardDescription> {
  void viewAuthor() {
    context.read<Repository>().setSearchUserId(widget.authorId);
    Navigator.of(context).pushNamed('userInfo');
  }

  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffFFF5EB),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Описание', style: descriptionTextes.title),
              Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.77,
                height: 150,
                child: Text(widget.description, style: descriptionTextes.title),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.77,
                child: Row(
                  children: [
                    Text(
                      'Автор: ',
                      style: descriptionTextes.text,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: viewAuthor,
                              child: Text(
                                widget.authorName,
                                style: descriptionTextes.author,
                              )),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text('Вы добавлены'),
                                      );
                                    }
                                );
                              },
                              child: Text(
                                'хочу',
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
