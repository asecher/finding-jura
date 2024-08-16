import 'package:finding_jura/assets.gen.dart';
import 'package:finding_jura/components/player.dart';
import 'package:finding_jura/game.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

class FindJuraWorld extends World with HasGameReference<FindJuraGame> {
  late final Player player;
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    final backgroundPaint = BasicPalette.black.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(game.images.fromCache(
          Assets.hud.inputs.tile0012.path,
        )),
        size: Vector2.all(60),
      ),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    player = Player(joystick: joystick);

    add(player);
    game.cameraComponent.viewport.add(joystick);
  }
}

// Cheveux 696057
// 332a23
//
// f2e5d6
