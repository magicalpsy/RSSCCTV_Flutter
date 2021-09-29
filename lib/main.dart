import 'package:flutter/material.dart';
import 'package:netflix_application/screen/home_screen.dart';
import 'package:netflix_application/screen/maps_screen.dart';
import 'package:netflix_application/screen/myrss_screen.dart';
import 'package:netflix_application/screen/search_screen.dart';
import 'package:netflix_application/widget/bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // TabController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KT CCTV',
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.white),
      home: DefaultTabController(
        length: 5, //하단 바 메뉴 5개 생성
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              MapScreen(),
              SearchScreen(),
              MyrssScreen(),
              Container(child: Center(child: Text('more'))),
            ],
          ),
          bottomNavigationBar: Bottom(), //Widget Bottom_bar 확인
          resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }
}
