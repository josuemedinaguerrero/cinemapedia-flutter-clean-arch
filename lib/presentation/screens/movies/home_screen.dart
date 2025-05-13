import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';

import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final StatefulNavigationShell currentChild;

  const HomeScreen({super.key, required this.currentChild});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final isMovieDetailsRouter = location.contains('/movie/');

    return Scaffold(
      body: currentChild,
      bottomNavigationBar: isMovieDetailsRouter ? null : FadeIn(child: CustomBottomNavigationbar(currentChild: currentChild)),
    );
  }
}
