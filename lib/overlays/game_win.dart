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
  late ConfettiController _confettiControllerLeft;
  late ConfettiController _confettiControllerRight;

  @override
  void initState() {
    super.initState();
    _confettiControllerLeft =
        ConfettiController(duration: const Duration(seconds: 12));
    _confettiControllerLeft.play();

    _confettiControllerRight =
        ConfettiController(duration: const Duration(seconds: 10));

    Future.delayed(const Duration(seconds: 2), () {
      _confettiControllerRight.play();
    });
  }

  @override
  void dispose() {
    _confettiControllerLeft.dispose();
    _confettiControllerRight.dispose();
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
        Positioned(
          bottom: 0,
          left: 75,
          child: ConfettiWidget(
            confettiController: _confettiControllerLeft,
            blastDirection: -math.pi / 2,
            emissionFrequency: 0.01,
            numberOfParticles: 20,
            maxBlastForce: 100,
            minBlastForce: 80,
            gravity: 0.3,
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
        Positioned(
          bottom: 0,
          right: 75,
          child: ConfettiWidget(
            confettiController: _confettiControllerRight,
            blastDirection: -math.pi / 2,
            emissionFrequency: 0.01,
            numberOfParticles: 20,
            maxBlastForce: 100,
            minBlastForce: 80,
            gravity: 0.3,
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
