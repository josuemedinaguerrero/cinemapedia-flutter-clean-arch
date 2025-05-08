import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = [
      'Cargando películas...',
      "Comprando palomitas de maíz",
      "Cargando populares",
      "Llamando a mi novia",
      "Ya mero...",
    ];

    return Stream.periodic(Duration(milliseconds: 1300), (computationCount) => messages[computationCount]).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Espere por favor'),
          SizedBox(height: 15),
          CircularProgressIndicator(strokeWidth: 2),
          SizedBox(height: 15),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              return Text(snapshot.data ?? 'Cargando...');
            },
          ),
        ],
      ),
    );
  }
}
