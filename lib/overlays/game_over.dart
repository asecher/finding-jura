import 'package:finding_jura/game.dart';
import 'package:finding_jura/ui/pixel_button.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final FindJuraGame game;

  const GameOver({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Over',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                fontSize: 32,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(2, 2),
                    blurRadius: 0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            PixelButton(
              text: 'Restart',
              onPressed: () {
                game.restart();
              },
            ),
          ],
        ),
      ),
    );
  }
}
