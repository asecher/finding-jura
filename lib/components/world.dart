import 'dart:math';

import 'package:finding_jura/assets.gen.dart';
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

Random rnd = Random();

class FindJuraWorld extends World with HasGameReference<FindJuraGame> {
  late final Player player;
  late final JoystickComponent joystick;
  late final CountdownTimerComponent gameTimer;
  late final TiledComponent map;

  final Vector2 size = Vector2(
    mapWidth * worldTileSize,
    mapHeight * worldTileSize,
  );

  @override
  Future<void> onLoad() async {
    map = await TiledComponent.load(
      Assets.world.level,
      Vector2.all(worldTileSize),
      prefix: '',
    );

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

    player = Player(
      joystick: joystick,
      position: possiblePlayerSpawnPoints.elementAt(playerSpawnPointIndex),
    );

    final gameTitleComponent = TextComponent(
      text: 'Finding Jura ',
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
      duration: 300, // 5 minutes
      position: Vector2(10, 35),
      onTimerComplete: () {
        print('Time\'s up!');
        // Add your game over logic here
      },
      onTimeUpdate: (time) {
        if (time == 59) {
          // Last 60 seconds
          print('Less than a minute remaining!');
        }
      },
    );

    addAll([map, player]);
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
}

// Cheveux 696057
// 332a23
// с днем рождения Алена
// f2e5d6
