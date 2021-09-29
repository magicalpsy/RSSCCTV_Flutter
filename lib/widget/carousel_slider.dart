import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_application/model/model_cctv.dart';
import 'package:netflix_application/screen/detail_screen.dart';
import 'package:netflix_application/screen/rtsp_screen.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  CarouselImage({required this.movies});
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  late List<Movie> movies;
  late List<Widget> images;
  late List<String> teams;
  late List<bool> likes;
  int _currentPage = 0;
  late String _currentteams;
  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies
        .map((m) => Image.asset(
              './images/' + m.poster,
              fit: BoxFit.fill,
            ))
        .toList();
    teams = movies.map((m) => m.team).toList();
    likes = movies.map((m) => m.like).toList();
    _currentteams = teams[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
          ),
          CarouselSlider(
              items: images,
              options: CarouselOptions(onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                  _currentteams = teams[_currentPage];
                });
              })),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentteams,
              style: TextStyle(fontSize: 11),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      likes[_currentPage]
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  likes[_currentPage] = !likes[_currentPage];
                                  movies[_currentPage].reference.updateData(
                                      {'like': likes[_currentPage]});
                                });
                              },
                              icon: Icon(Icons.check))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  likes[_currentPage] = !likes[_currentPage];
                                  movies[_currentPage].reference.updateData(
                                      {'like': likes[_currentPage]});
                                });
                              },
                              icon: Icon(Icons.add)),
                      Text(
                        'My국사',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                            fullscreenDialog: true,
                            builder: (BuildContext context) {
                              return RtspScreen(movie: movies[_currentPage]);
                            }));
                      },
                      style: ButtonStyle(
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 14)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                          ),
                          Padding(padding: EdgeInsets.all(3)),
                          Text(
                            "재생",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      )),
                  // FlatButton(
                  //   color: Colors.white,
                  //   onPressed: () {
                  //     Navigator.of(context).push(MaterialPageRoute<Null>(
                  //         fullscreenDialog: true,
                  //         builder: (BuildContext context) {
                  //           return RtspScreen(movie: movies[_currentPage]);
                  //         }));
                  //   },
                  //   child: Row(
                  //     children: <Widget>[
                  //       Icon(
                  //         Icons.play_arrow,
                  //         color: Colors.black,
                  //       ),
                  //       Padding(padding: EdgeInsets.all(3)),
                  //       Text(
                  //         "재생",
                  //         style: TextStyle(color: Colors.black),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ),
                Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute<Null>(
                                fullscreenDialog: true,
                                builder: (BuildContext context) {
                                  return DetailScreen(
                                    movie: movies[_currentPage],
                                  );
                                }));
                          },
                          icon: Icon(Icons.info),
                        ),
                        Text('정보', style: TextStyle(fontSize: 11)),
                      ],
                    )),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeIndicator(likes, _currentPage),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeIndicator(List list, int _currentPage) {
  List<Widget> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == i
              ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4)),
    ));
  }
  return result;
}
