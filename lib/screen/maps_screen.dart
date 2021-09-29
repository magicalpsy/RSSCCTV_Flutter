import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:netflix_application/model/model_cctv.dart';
import 'package:netflix_application/screen/detail_screen.dart';

class MapScreen extends StatefulWidget {
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
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
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(
        double.parse(movies[0].longitude),
        double.parse(movies[0].latitude),
      ),
      zoom: 14,
    );
    return Container(
      height: 300,
      child: GoogleMap(
        mapType: MapType.normal,
        markers: _createMarker(movies),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }

  Set<Marker> _createMarker(List<Movie> movies) {
    List<Marker> makerList = <Marker>[];

    for (int i = 0; i < movies.length; i++) {
      makerList.add(
        Marker(
          markerId: MarkerId(movies[i].title),
          position: LatLng(
            double.parse(movies[i].longitude),
            double.parse(movies[i].latitude),
          ),
          // icon: Icons.camera,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<Null>(
                fullscreenDialog: true,
                builder: (BuildContext context) {
                  return DetailScreen(movie: movies[i]);
                }));
          },
          infoWindow: InfoWindow(
            title: movies[0].title,
          ),
        ),
      );
    }
    Set<Marker> setList = makerList.toSet();
    return setList;
  }
}
// _kMapCenter =LatLng(37.898989, 129.362536);
