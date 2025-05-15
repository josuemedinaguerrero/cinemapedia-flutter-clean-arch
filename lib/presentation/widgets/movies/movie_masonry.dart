import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback loadNextPage;

  const MovieMasonry({super.key, required this.movies, required this.loadNextPage});

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 100) >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        itemCount: widget.movies.length,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          if (index == 1) return Column(children: [SizedBox(height: 40), MoviePosterLink(movie: widget.movies[index])]);
          return MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}
