import 'package:json_annotation/json_annotation.dart';

class PopMovie {
  int? movie_id;
  String? title;
  String? homepage;
  String? overview;
  String? release_date;
  int? runtime;
  String? vote_average;

  final List? genres;

  PopMovie(
      {required this.movie_id,
      required this.title,
      required this.homepage,
      required this.overview,
      required this.release_date,
      required this.runtime,
      required this.vote_average,
      required this.genres});

  factory PopMovie.fromJson(Map<String, dynamic> json) {
    return PopMovie(
        movie_id: json['movie_id'],
        title: json['title'],
        homepage: json['homepage'],
        overview: json['overview'],
        release_date: json['release_date'],
        runtime: json['runtime'],
        vote_average: json['vote_average'],
        genres: json['genres']);
  }
}
