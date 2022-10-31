class PopMovie {
  final int id;
  final String title;
  final String overview;
  final String vote_average;

  PopMovie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.vote_average});

  factory PopMovie.fromJson(Map<String, dynamic> json) {
    return PopMovie(
      id: json['movie_id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      vote_average: json['vote_average'] as String,
    );
  }
}
