import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_application/model/model_cctv.dart';
import 'package:netflix_application/screen/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
  // _RtspScreenState createState() => _RtspScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("RSSCCTV").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data!.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<DocumentSnapshot> searchResults = [];
    for (DocumentSnapshot d in snapshot) {
      if (d.data.toString().contains(_searchText)) {
        searchResults.add(d);
      }
    }
    return Expanded(
      child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.5,
          padding: EdgeInsets.all(3),
          children: searchResults
              .map((data) => _buildListItem(context, data))
              .toList()),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final cctv = Movie.fromSnapshot(data);
    return Container(
        padding: EdgeInsets.all(5),
        child: InkWell(
            child: Image.asset(
              'images/' + cctv.poster,
              fit: BoxFit.fill,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<Null>(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return DetailScreen(movie: cctv);
                  },
                ),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            padding: EdgeInsets.fromLTRB(5, 30, 5, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: TextField(
                    focusNode: focusNode,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white60,
                        size: 20,
                      ),
                      suffixIcon: focusNode.hasFocus
                          ? IconButton(
                              icon: Icon(Icons.cancel, size: 20),
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  _searchText = "";
                                });
                              },
                            )
                          : Container(),
                      hintText: '??????',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                focusNode.hasFocus
                    ? Expanded(
                        child: FlatButton(
                          child: Text('??????'),
                          onPressed: () {
                            setState(
                              () {
                                _filter.clear();
                                _searchText = "";
                                focusNode.unfocus();
                              },
                            );
                          },
                        ),
                      )
                    : Expanded(
                        flex: 0,
                        child: Container(),
                      ),
              ],
            ),
          ),
          _buildBody(context)
        ],
      ),
    );
  }
}
