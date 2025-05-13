import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class CustomBottomNavigationbar extends StatelessWidget {
  final StatefulNavigationShell currentChild;

  const CustomBottomNavigationbar({super.key, required this.currentChild});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentChild.currentIndex,
      onTap: (value) => currentChild.goBranch(value),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.label_outline), label: 'Categorías'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
      ],
    );
  }
}
