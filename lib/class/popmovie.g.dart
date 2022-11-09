// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popmovie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopMovie _$PopMovieFromJson(Map<String, dynamic> json) => PopMovie(
      movie_id: json['movie_id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      vote_average: json['vote_average'] as String,
      genres: json['genres'] as List<dynamic>?,
    );

Map<String, dynamic> _$PopMovieToJson(PopMovie instance) => <String, dynamic>{
      'movie_id': instance.movie_id,
      'title': instance.title,
      'overview': instance.overview,
      'vote_average': instance.vote_average,
      'genres': instance.genres,
    };
