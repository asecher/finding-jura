import 'package:finding_jura/game.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class CountdownTimerComponent extends TextComponent
    with HasGameReference<FindJuraGame> {
  double _remainingTime;
  final double _duration;
  bool _isRunning = false;
  final void Function()? onTimerComplete;
  final void Function(double)? onTimeUpdate;

  CountdownTimerComponent({
    double duration = 300, // 5 minutes by default
    super.position,
    super.size,
    this.onTimerComplete,
    this.onTimeUpdate,
    TextRenderer? textRenderer,
  })  : _duration = duration,
        _remainingTime = duration,
        super(
          textRenderer: textRenderer ??
              TextPaint(
                style: TextStyle(
                  fontFamily: 'PressStart2P',
                  fontSize: 16,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
        );

  @override
  void update(double dt) {
    super.update(dt);
    if (_isRunning) {
      _remainingTime -= dt;
      if (_remainingTime <= 0) {
        _remainingTime = 0;
        _isRunning = false;
        onTimerComplete?.call();
      }
      text = _formatTime(_remainingTime);
      onTimeUpdate?.call(_remainingTime);
    }
  }

  void start() {
    _isRunning = true;
  }

  void pause() {
    _isRunning = false;
  }

  void reset() {
    _remainingTime = _duration;
    _isRunning = false;
    text = _formatTime(_remainingTime);
  }

  String _formatTime(double timeInSeconds) {
    final int minutes = (timeInSeconds / 60).floor();
    final int seconds = (timeInSeconds % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool get isRunning => _isRunning;
  double get remainingTime => _remainingTime;
}

// Example usage in a game class:
class MyGame extends FlameGame {
  late CountdownTimerComponent gameTimer;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    gameTimer = CountdownTimerComponent(
      duration: 300, // 5 minutes
      position: Vector2(10, 10),
      onTimerComplete: () {
        print('Time\'s up!');
        // Add your game over logic here
      },
      onTimeUpdate: (time) {
        if (time <= 60) {
          // Last 60 seconds
          print('Less than a minute remaining!');
          // Maybe start a warning sound or change the timer color
        }
      },
    );

    add(gameTimer);
    gameTimer.start(); // Start the timer immediately
  }
}
