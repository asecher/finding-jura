import 'package:finding_jura/game.dart';
import 'package:finding_jura/overlays/game_over.dart';
import 'package:finding_jura/overlays/game_win.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = FindJuraGame();
  runApp(MyApp(game: game));
}

class MyApp extends StatelessWidget {
  final FindJuraGame game;

  const MyApp({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finding Jura',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GameWidget<FindJuraGame>(
        game: game,
        overlayBuilderMap: {
          'GameOver': (_, game) => GameOver(game: game),
          'GameWin': (_, game) => GameWin(game: game),
        },
      ),
    );
  }
}
