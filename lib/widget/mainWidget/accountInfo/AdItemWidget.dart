import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ri_and_go/Repository/Repository.dart';
import 'package:ri_and_go/Theme/app_cardStyles.dart';
import 'package:ri_and_go/Url/apiSetting.dart';

class AdItemWidget extends StatefulWidget {
  IconData itemIcon;
  String itemName;
  String itemDate;
  String itemDescription;
  String itemAuthor;
  int authorId;
  bool tripType;

  AdItemWidget(
      {Key? key,
      required this.itemIcon,
      required this.itemName,
      required this.itemDate,
      required this.itemAuthor,
      required this.itemDescription,
      required this.authorId,
      required this.tripType})
      : super(key: key);

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
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: Colors.black.withOpacity(0.6),
                width: 1,
              ),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: isOpen
              ? [
                  _simpCardBody(
                    itemIcon: widget.itemIcon,
                    itemName: widget.itemName,
                    itemDate: widget.itemDate,
                    typeOfTrip: widget.tripType,
                  ),
                  _cardDescription(
                    description: widget.itemDescription,
                    authorName: widget.itemAuthor,
                    authorId: widget.authorId,
                  ),
                ]
              : [
                  _simpCardBody(
                    itemIcon: widget.itemIcon,
                    itemName: widget.itemName,
                    itemDate: widget.itemDate,
                    typeOfTrip: widget.tripType,
                  )
                ],
        ),
      ),
    );
  }
}

class AdDeletebleItemWidget extends StatefulWidget {
  //IconData itemIcon;
  String itemName;
  String itemDate;
  String itemDescription;
  String itemAuthor;
  int authorId;
  int itemId;
  bool tripType;

  AdDeletebleItemWidget(
      {Key? key,
      required this.itemId,
      //required this.itemIcon,
      required this.itemName,
      required this.itemDate,
      required this.itemAuthor,
      required this.itemDescription,
      required this.authorId,
      required this.tripType})
      : super(key: key);

  @override
  _AdDeletebleItemWidgetState createState() => _AdDeletebleItemWidgetState();
}

class _AdDeletebleItemWidgetState extends State<AdDeletebleItemWidget> {
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
            border: Border.all(
              color: Colors.black.withOpacity(0.6),
              width: 1,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: isOpen
              ? [
                  _daletebleCardBody(
                      //itemIcon: widget.itemIcon,
                      itemName: widget.itemName,
                      itemDate: widget.itemDate,
                      id: widget.itemId,
                      typeOfTrip: widget.tripType),
                  _simpleCardDescription(
                    description: widget.itemDescription,
                    authorName: widget.itemAuthor,
                    authorId: widget.authorId,
                  ),
                ]
              : [
                  _daletebleCardBody(
                    //itemIcon: widget.itemIcon,
                    itemName: widget.itemName,
                    itemDate: widget.itemDate,
                    id: widget.itemId,
                    typeOfTrip: widget.tripType,
                  )
                ],
        ),
      ),
    );
  }
}

class _daletebleCardBody extends StatefulWidget {
  //final IconData itemIcon;
  final String itemName;
  final String itemDate;
  final int id;
  final bool typeOfTrip;

  const _daletebleCardBody(
      {Key? key,
      //required this.itemIcon,
      required this.itemName,
      required this.itemDate,
      required this.id,
      required this.typeOfTrip})
      : super(key: key);

  @override
  _daletebleCardBodyState createState() => _daletebleCardBodyState();
}

class _daletebleCardBodyState extends State<_daletebleCardBody> {
  Future disableTrip() async {
    final dio = Dio();
    final response = await dio.post(apiSettings.baseUrl + 'Trips/SetActive',
        data: {'tripId': widget.id, 'isActive': false});
    print(response.statusCode);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!widget.typeOfTrip) ...[
            Icon(
              Icons.assignment_ind_outlined,
              size: 55,
            )
          ] else ...[
            Icon(
              Icons.local_offer_outlined,
              size: 55,
            )
          ],
          SizedBox(
            width: 22,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Flexible(
                    child: Text(widget.itemName, style: mainTextes.title),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.itemDate,
                style: mainTextes.date,
              )
            ],
          ),
          // SizedBox(
          //   width: 50,
          // ),
          TextButton(
              onPressed: disableTrip,
              child: Icon(
                Icons.delete_outline,
                size: 40,
                color: Colors.black,
              )),
        ]);
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
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            widget.itemIcon,
            size: 56,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(widget.itemName,
                    style: mainTextes.title, softWrap: true),
              ),
              Text(
                widget.itemDate,
                style: mainTextes.date,
              )
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Icon(
            Icons.more_vert_outlined,
            size: 40,
          ),
        ]);
  }
}

class _simpCardBody extends StatefulWidget {
  final IconData itemIcon;
  final String itemName;
  final String itemDate;
  final bool typeOfTrip;

  const _simpCardBody(
      {Key? key,
      required this.itemIcon,
      required this.itemName,
      required this.itemDate,
      required this.typeOfTrip})
      : super(key: key);

  @override
  _simpCardBodyState createState() => _simpCardBodyState();
}

class _simpCardBodyState extends State<_simpCardBody> {
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            widget.itemIcon,
            size: 56,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(widget.itemName,
                    style: mainTextes.title, softWrap: true),
              ),
              Text(
                widget.itemDate,
                style: mainTextes.date,
              )
            ],
          ),
          SizedBox(
            width: 50,
          ),
          if (widget.typeOfTrip) ...[
            Icon(
              Icons.assignment_ind_outlined,
              size: 40,
            )
          ] else ...[
            Icon(
              Icons.local_offer_outlined,
              size: 40,
            )
          ],
        ]);
  }
}

class _simpleCardDescription extends StatefulWidget {
  final String description;
  final String authorName;
  final int authorId;

  const _simpleCardDescription(
      {Key? key,
      required this.description,
      required this.authorName,
      required this.authorId})
      : super(key: key);

  @override
  _simpleCardDescriptionState createState() => _simpleCardDescriptionState();
}

class _simpleCardDescriptionState extends State<_simpleCardDescription> {
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

class _cardDescription extends StatefulWidget {
  final String description;
  final String authorName;
  final int authorId;

  const _cardDescription(
      {Key? key,
      required this.description,
      required this.authorName,
      required this.authorId})
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
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Вы добавлены'),
                                      );
                                    });
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
