import 'package:flutter/material.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) return Center(child: CircularProgressIndicator(strokeWidth: 2));

    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(delegate: SliverChildBuilderDelegate((context, index) => _MovieDetails(movie: movie), childCount: 1)),
        ],
      ),
    );
  }
}

final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageReporitory = ref.watch(localStorageRepositoryProvider);
  return localStorageReporitory.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * .7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: isFavoriteFuture.when(
            data: (isFavorite) => isFavorite ? Icon(Icons.favorite_rounded, color: Colors.red) : Icon(Icons.favorite_border),
            error: (error, stackTrace) => SizedBox(),
            loading: () => CircularProgressIndicator(strokeWidth: 2),
          ),
          onPressed: () async {
            await ref.read(localStorageRepositoryProvider).toggleFavorite(movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        title: Text(movie.title, style: TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.start),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),

            _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [.7, 1],
              colors: [Colors.transparent, Colors.black87],
            ),

            _CustomGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, .3],
              colors: [Colors.black87, Colors.transparent],
            ),

            _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0, .3],
              colors: [Colors.black87, Colors.transparent],
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(movie.posterPath, width: size.width * .3)),
              SizedBox(width: 10),
              SizedBox(
                width: (size.width - 40) * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(movie.title, style: textStyles.titleLarge), Text(movie.overview)],
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map(
                (gender) => Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Chip(label: Text(gender), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                ),
              ),
            ],
          ),
        ),

        _ActorsByMovie(movieId: movie.id.toString()),

        SizedBox(height: 20),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider)[movieId];

    if (actorsByMovie == null) {
      return Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actorsByMovie.length,
        itemBuilder: (context, index) {
          final actor = actorsByMovie[index];
          return Container(
            padding: EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(actor.profilePath, height: 180, fit: BoxFit.cover),
                ),

                SizedBox(height: 5),

                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({required this.begin, required this.end, required this.stops, required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: LinearGradient(begin: begin, end: end, stops: stops, colors: colors)),
      ),
    );
  }
}
