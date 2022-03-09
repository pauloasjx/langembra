import 'package:flutter/material.dart';
import 'package:langembra/modules/home/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Langembra',
      home: HomeScreen(title: 'Langembra'),
    );
  }
}
