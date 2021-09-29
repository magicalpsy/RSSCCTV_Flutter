import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix_application/model/model_cctv.dart';
import 'package:netflix_application/widget/carousel_slider.dart';
import 'package:netflix_application/widget/circle_slider.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Movie> movies = [
  //   Movie.fromMap({
  //     'title': '0671_용전(평창)',
  //     'team': '평창운용팀_용전',
  //     'poster': 'YoungJun.png',
  //     'location': '강원도 평창군 용평면 용전리 일반 300-4',
  //     'date': '2021-05-10 17:11:14',
  //     'like': false,
  //     'cctv_url': 'rtsp://ktkw:kw0348@175.206.237.71:554/stream_ch00_1',
  //   },),
  //   Movie.fromMap({
  //     'title': '0674_월정(평창)',
  //     'team': '평창운용팀_월정',
  //     'poster': '0674.png',
  //     'location': '강원도 평창군 진부면 동산리 일반 64-5	',
  //     'date': '2021-05-10 17:11:14',
  //     'like': false,
  //     'cctv_url': "",
  //   }),
  //   Movie.fromMap({
  //     'title': '0899_자등(동송)',
  //     'team': '춘천운용팀_자등',
  //     'poster': '0899.png',
  //     'location': '강원도 철원군 서면 자등리 일반 777-5	',
  //     'date': '2021-05-10 17:11:14',
  //     'like': false,
  //     'cctv_url': "",
  //   }),
  //   Movie.fromMap({
  //     'title': '0867_마현(동송)',
  //     'team': '춘천운용팀_마현',
  //     'poster': '0867.png',
  //     'location': '강원도 철원군 근남면 마현리 일반 1967-25',
  //     'date': '2021-05-10 17:11:14',
  //     'like': false,
  //     'cctv_url': "",
  //   }),
  // ];
  Firestore firestore = Firestore.instance;
  late Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    super.initState();
    streamData = firestore.collection('RSSCCTV').snapshots();
  }

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('RSSCCTV').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildBody(context, snapshot.data!.documents);
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Movie> movies = snapshot.map((d) => Movie.fromSnapshot(d)).toList();
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            CarouselImage(movies: movies),
            TopBar(),
          ],
        ),
        CircleSlider(movies: movies),
        CircleSlider(movies: movies),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'images/kt_logo.png',
            // 'images/kt_logo_base_black.png',
            fit: BoxFit.contain,
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '분기국사',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '이벤트확인',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '즐겨찾기',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
