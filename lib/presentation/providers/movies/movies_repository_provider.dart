import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repositorio inmutable
final movieRepositoryProvider = Provider((ref) => MovieRepositoryImpl(MoviedbDatasource()));
