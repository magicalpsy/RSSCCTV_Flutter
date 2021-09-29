import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String title;
  // final String keyword;
  final String team;
  final String location;
  final String poster;
  final String date;
  final String cctv_url;
  final String latitude;
  final String longitude;
  final bool like;
  final DocumentReference reference; // firebase 연동

  Movie.fromMap(Map<String, dynamic> map, {required this.reference})
      : title = map['title'],
        // keyword = map['keyword'],
        team = map['team'],
        location = map['location'],
        poster = map['poster'],
        date = map['date'],
        like = map['like'],
        cctv_url = map['cctv_url'],
        longitude = map['longitude'],
        latitude = map['latitude'];

  Movie.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Movie<$title:$team>";
}
