import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ri_and_go/Repository/Repository.dart';
import 'package:ri_and_go/widget/addCardWidget/mainAddWidget.dart';
import 'package:ri_and_go/widget/auth/SingInWidget/SecondSingInWidget.dart';
import 'package:ri_and_go/widget/auth/SingInWidget/SingInScreenWidget.dart';
import 'package:ri_and_go/widget/mainWidget/Search/Search.dart';
import 'package:ri_and_go/widget/mainWidget/Search/mainSearch.dart';
import 'package:ri_and_go/widget/mainWidget/accountInfo/EditUser.dart';
import 'package:ri_and_go/widget/mainWidget/accountInfo/Profile.dart';
import 'package:ri_and_go/widget/mainWidget/accountInfo/UserInfo.dart';
import 'package:ri_and_go/widget/mainWidget/MainScreen.dart';
import 'package:ri_and_go/widget/map/mapForDriver.dart';
import 'package:ri_and_go/widget/map/mapForUser.dart';
import 'Theme/app_color.dart';
import 'widget/auth/AuthScreenWidget.dart';
import 'widget/carusel_Slider/mainCarusel.dart';
import 'widget/map/mapGoogle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ri&Go',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: AppColors.mainColor
          ),
        ),
        routes: {
          'login': (context) => AuthWidget(),
          'firstSingin': (context) => SingWidget(),
          'secondSingin': (context) => SecondSingWidget(),
          'profile' : (context) => Profile(),
          'mainScreen' : (context) => MainScreen(),
          'add' : (context) => AddMainUserWidget(),
          'search' : (context) => Search(),
          'userInfo' : (context) => UserInfo(),
          'mainSearch' : (context) => mainSearch(),
          'editUser' : (context) => EditUser(),
          'carusel' : (context) => MainCarousel(),
          'map' : (context) => MapScreen(),
          'mapDrive' : (context) => mapForDriver(),
          'mapUser' : (context) => MapUser(),
        },

        initialRoute: 'login',
      ),
    );
  }
}