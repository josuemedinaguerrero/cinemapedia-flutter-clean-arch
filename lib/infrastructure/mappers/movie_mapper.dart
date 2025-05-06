import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMoviedb moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath:
        moviedb.backdropPath != null
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
            : 'https://imgs.search.brave.com/KaQ6pP0ouWXyiG-xo5osVrhXRrcyCNjIo9JR3T75JHY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZy/ZWVwaWsuY29tLzI1/Ni8xMTU0Mi8xMTU0/MjU5OC5wbmc_c2Vt/dD1haXNfaHlicmlk',
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath:
        moviedb.posterPath != null
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}'
            : 'no-poster',
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount,
  );
}
