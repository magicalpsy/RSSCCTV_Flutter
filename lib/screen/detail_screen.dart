import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:netflix_application/model/model_cctv.dart';
import 'package:netflix_application/screen/rtsp_screen.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  DetailScreen({required this.movie});
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool like = false;
  @override
  void initState() {
    super.initState();
    like = widget.movie.like;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/' + widget.movie.poster),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                            alignment: Alignment.center,
                            color: Colors.black.withOpacity(0.1),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                                    child: Image.asset(
                                        'images/' + widget.movie.poster),
                                    height: 300,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(7),
                                    child: Text(
                                      "분기국사 정보 집어 넣을 자리",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(7),
                                    child: Text(
                                      widget.movie.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute<Null>(
                                                fullscreenDialog: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return RtspScreen(
                                                      movie: widget.movie);
                                                }));
                                      },
                                      color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.play_arrow),
                                          Text("재생"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(7),
                                    child: Text(
                                      widget.movie.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(7),
                                    child: Text(
                                      widget.movie.team + "   담당자 정보 추가",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                  Positioned(
                      // 왼쪽위 X 자 버튼 생성
                      child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ))
                ],
              ),
              Container(
                  color: Colors.black26,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              like = !like;
                              widget.movie.reference.updateData({'like': like});
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              like ? Icon(Icons.check) : Icon(Icons.add),
                              Padding(
                                padding: EdgeInsets.all(5),
                              ),
                              Text("관심국사",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white60,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            Icon(Icons.thumb_up),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Text(
                              "평가",
                              style: TextStyle(
                                  fontSize: 11, color: Colors.white60),
                            )
                          ],
                        )),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.send),
                              Padding(
                                padding: EdgeInsets.all(5),
                              ),
                              Text(
                                "긴급알림",
                                style: TextStyle(
                                    fontSize: 11, color: Colors.white60),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('나중에 만들 꺼야아아아아아아아'),
          content: Text("나중에 만들 꺼라고오오오오오오"),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, "Cancel");
              },
            ),
          ],
        );
      },
    );
  }
}

Widget makeMenuButton() {
  return Container();
}
