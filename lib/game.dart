import 'package:finding_jura/assets.gen.dart';
import 'package:finding_jura/components/world.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class FindJuraGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late final CameraComponent cameraComponent;

  @override
  final FindJuraWorld world;

  FindJuraGame() : world = FindJuraWorld() {
    cameraComponent = CameraComponent(world: world);
    images.prefix = '';
  }

  get score => world.score;

  @override
  Color backgroundColor() => const Color(0xFF84C669);

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      Assets.characters.player.poses.idle.path,
      Assets.characters.player.poses.run1.path,
      Assets.characters.player.poses.run2.path,
      Assets.characters.player.poses.run3.path,
      Assets.characters.player.poses.run4.path,
      Assets.characters.player.poses.run5.path,
      Assets.characters.player.poses.run6.path,
      Assets.characters.cat1.path,
      Assets.hud.inputs.tile0012.path,
    ]);
    addAll([cameraComponent, world]);
  }

  void restart() {
    world.restart();
  }
}
