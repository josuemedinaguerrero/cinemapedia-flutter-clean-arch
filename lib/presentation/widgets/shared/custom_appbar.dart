import 'package:flutter/material.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(Icons.movie_outlined, color: colors.primary),
            SizedBox(width: 5),
            Text('Cinemapedia', style: titleStyle),
            Spacer(),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final movieRepository = ref.read(movieRepositoryProvider);

                final movie = await showSearch<Movie?>(
                  context: context,
                  delegate: SearchMovieDelegate(searchMovies: movieRepository.searchMovies),
                );

                if (movie != null && context.mounted) context.push('/movie/${movie.id}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
