import 'dart:math' as math;

import 'package:confetti/confetti.dart';
import 'package:finding_jura/game.dart';
import 'package:finding_jura/ui/pixel_button.dart';
import 'package:flutter/material.dart';

class GameWin extends StatefulWidget {
  final FindJuraGame game;

  const GameWin({super.key, required this.game});

  @override
  State<GameWin> createState() => _GameWinState();
}

class _GameWinState extends State<GameWin> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          color: Colors.black54,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You Win!',
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
                Text(
                  'С днем рождения Алена',
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
                Text(
                  'Score: ${widget.game.score}',
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
                    widget.game.restart();
                  },
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: math.pi / 2,
            maxBlastForce: 5,
            minBlastForce: 2,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.1,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
          ),
        ),
      ],
    );
  }
}
