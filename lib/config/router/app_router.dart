import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';

import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) => HomeScreen(currentChild: navigationShell),
      // builder: (context, state, child) => HomeScreen(childView: child),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => HomeView(),
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  name: MovieScreen.name,
                  builder: (context, state) {
                    return MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id');
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(routes: [GoRoute(path: '/favorites', builder: (context, state) => FavoritesView())]),
        StatefulShellBranch(routes: [GoRoute(path: '/favorites', builder: (context, state) => FavoritesView())]),
      ],
    ),

    // Rutas padre e hijo
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => HomeScreen(childView: HomeView()),
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:id',
    //       name: MovieScreen.name,
    //       builder: (context, state) {
    //         return MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id');
    //       },
    //     ),
    //   ],
    // ),
  ],
);
