import 'package:json_annotation/json_annotation.dart';
part 'popmovie.g.dart';

@JsonSerializable()
class PopMovie {
  @JsonKey(name: 'movie_id')
  final int movie_id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'overview')
  final String overview;
  @JsonKey(name: 'vote_average')
  final String vote_average;

  final List? genres;

  PopMovie(
      {required this.movie_id,
      required this.title,
      required this.overview,
      required this.vote_average,
      required this.genres});

  factory PopMovie.fromJson(Map<String, dynamic> json) =>
      _$PopMovieFromJson(json);
}
