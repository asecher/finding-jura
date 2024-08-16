import 'package:finding_jura/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = FindJuraGame();
  runApp(MyApp(game: game));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.game});

  final FindJuraGame game;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finding Jura',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GameWidget(game: game),
    );
  }
}
