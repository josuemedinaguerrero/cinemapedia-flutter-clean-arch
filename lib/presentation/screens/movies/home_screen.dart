import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationbar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    if (moviesSlideshow.isEmpty) {
      return Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomAppbar(),

        MoviesSlideshow(movies: moviesSlideshow),

        MovieHorizontalListview(
          movies: nowPlayingMovies,
          title: 'En cines',
          subTitle: 'Lunes 20',
        ),

        // Expanded(
        //   child: ListView.builder(
        //     padding: EdgeInsets.zero,
        //     itemCount: nowPlayingMovies.length,
        //     itemBuilder: (context, index) {
        //       final movie = nowPlayingMovies[index];
        //       return ListTile(title: Text(movie.title));
        //     },
        //   ),
        // ),
      ],
    );
  }
}
