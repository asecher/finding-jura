import 'dart:math';

import 'package:finding_jura/assets.gen.dart';
import 'package:finding_jura/components/jura.dart';
import 'package:finding_jura/components/player.dart';
import 'package:finding_jura/components/timer.dart';
import 'package:finding_jura/constants.dart';
import 'package:finding_jura/game.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/palette.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

const mapHeight = 120;
const mapWidth = 196;
const double startingTime = 540; // 9 minutes

Random rnd = Random();

enum GameStatus {
  playing,
  won,
  lost,
}

class FindJuraWorld extends World with HasGameReference<FindJuraGame> {
  GameStatus gameStatus = GameStatus.playing;

  late final Player player;
  late final Jura jura;
  late final JoystickComponent joystick;
  late final CountdownTimerComponent gameTimer;
  late final TiledComponent map;

  final Vector2 size = Vector2(
    mapWidth * worldTileSize,
    mapHeight * worldTileSize,
  );

  get score => gameTimer.formatTime(startingTime - gameTimer.remainingTime);

  Vector2? _lastJuraSpawnPoint;
  Vector2? _lastPlayerSpawnPoint;

  Vector2 _getPlayerSpawnPoint() {
    final playerSpawnPoint =
        map.tileMap.getLayer<ObjectGroup>('playerSpawnPoints')!;
    final possiblePlayerSpawnPoints = <Vector2>{};
    for (final object in playerSpawnPoint.objects) {
      possiblePlayerSpawnPoints.add(
        Vector2(
          object.x * worldScale,
          object.y * worldScale,
        ),
      );
    }
    final playerSpawnPointIndex = rnd.nextInt(possiblePlayerSpawnPoints.length);
    final spawn = possiblePlayerSpawnPoints.elementAt(playerSpawnPointIndex);
    _lastPlayerSpawnPoint = spawn;

    return spawn;
  }

  Vector2 _getJuraSpawnPoint() {
    final juraSpawnPoint =
        map.tileMap.getLayer<ObjectGroup>('juraSpawnPoints')!;
    final possibleJuraSpawnPoints = <Vector2>{};
    for (final object in juraSpawnPoint.objects) {
      possibleJuraSpawnPoints.add(
        Vector2(
          object.x * worldScale,
          object.y * worldScale,
        ),
      );
    }
    final juraSpawnPointIndex = rnd.nextInt(possibleJuraSpawnPoints.length);
    final spawn = possibleJuraSpawnPoints.elementAt(juraSpawnPointIndex);
    _lastJuraSpawnPoint = spawn;

    return spawn;
  }

  @override
  Future<void> onLoad() async {
    map = await TiledComponent.load(
      Assets.world.level,
      Vector2.all(worldTileSize),
      prefix: '',
    );

    final joystickBackgroundPaint = BasicPalette.black.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(game.images.fromCache(
          Assets.hud.inputs.tile0012.path,
        )),
        size: Vector2.all(60),
      ),
      background: CircleComponent(radius: 100, paint: joystickBackgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    final initialPosition = _getPlayerSpawnPoint();

    player = Player(
      joystick: joystick,
      position: initialPosition,
    );
    jura = Jura(
      position: Vector2(
        initialPosition.x + 50,
        initialPosition.y + 50,
      ),
    );

    final gameTitleComponent = TextComponent(
      text: 'Finding Jura - с днем рождения Алена',
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: 'PressStart2P',
          fontSize: 16,
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
      position: Vector2(10, 10),
    );

    gameTimer = CountdownTimerComponent(
      duration: startingTime,
      position: Vector2(10, 35),
      onTimerComplete: () {
        gameOver();
      },
    );

    addAll([map, jura, player]);
    game.cameraComponent.viewport.addAll([
      joystick,
      gameTitleComponent,
      gameTimer,
    ]);
    game.cameraComponent.follow(player);

    gameTimer.start();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    setCameraBounds(size);
  }

  void setCameraBounds(Vector2 gameSize) {
    game.cameraComponent.setBounds(
      Rectangle.fromLTRB(
        gameSize.x / 2,
        gameSize.y / 2,
        size.x - gameSize.x / 2,
        size.y - gameSize.y / 2,
      ),
    );
  }

  void gameWin() {
    if (gameStatus == GameStatus.won || gameStatus == GameStatus.lost) {
      return;
    }

    gameStatus = GameStatus.won;
    gameTimer.pause();
    game.overlays.add("GameWin");
  }

  void gameOver() {
    if (gameStatus == GameStatus.won || gameStatus == GameStatus.lost) {
      return;
    }

    gameStatus = GameStatus.lost;
    gameTimer.pause();
    game.overlays.add("GameOver");
  }

  void restart() {
    gameTimer.reset();
    gameTimer.start();
    gameStatus = GameStatus.playing;
    game.overlays.remove("GameOver");
    game.overlays.remove("GameWin");

    Vector2 playerSpawnPoint;
    while (true) {
      playerSpawnPoint = _getPlayerSpawnPoint();
      if (_lastJuraSpawnPoint != playerSpawnPoint) {
        break;
      }
    }
    player.position = playerSpawnPoint;

    Vector2 juraSpawnPoint;
    while (true) {
      juraSpawnPoint = _getJuraSpawnPoint();
      if (_lastPlayerSpawnPoint != juraSpawnPoint) {
        break;
      }
    }
    jura.position = juraSpawnPoint;
  }
}

// Cheveux 696057
// 332a23
//
// f2e5d6
