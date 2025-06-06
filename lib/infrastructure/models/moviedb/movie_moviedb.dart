class MovieMoviedb {
  final bool adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  MovieMoviedb({
    required this.adult,
    this.backdropPath,
    this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieMoviedb.fromJson(Map<String, dynamic> json) => MovieMoviedb(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: json['genre_ids'] == null ? [] : List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"] != null ? json["popularity"].toDouble() : 0,
    posterPath: json["poster_path"],
    releaseDate: json["release_date"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"] == null ? 0 : json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
