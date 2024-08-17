import 'package:finding_jura/assets.gen.dart';
import 'package:finding_jura/constants.dart';
import 'package:finding_jura/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class Player extends PositionComponent
    with KeyboardHandler, HasGameReference<FindJuraGame> {
  static Vector2 playerSize = Vector2(26, 48);
  static final keysUp = <LogicalKeyboardKey>{
    LogicalKeyboardKey.keyW,
    LogicalKeyboardKey.keyZ,
    LogicalKeyboardKey.arrowUp
  };
  static final keysDown = <LogicalKeyboardKey>{
    LogicalKeyboardKey.keyS,
    LogicalKeyboardKey.arrowDown
  };
  static final keysLeft = <LogicalKeyboardKey>{
    LogicalKeyboardKey.keyA,
    LogicalKeyboardKey.keyQ,
    LogicalKeyboardKey.arrowLeft
  };
  static final keysRight = <LogicalKeyboardKey>{
    LogicalKeyboardKey.keyD,
    LogicalKeyboardKey.arrowRight
  };

  final JoystickComponent joystick;

  @override
  bool get debugMode => false;

  Player({
    required this.joystick,
    required Vector2 position,
  }) : super(
          anchor: Anchor.center,
          priority: 1,
          size: playerSize,
          children: [RectangleHitbox()],
          position: position,
        );

  int horizontalDirection = 0;
  Vector2 movement = Vector2.zero();
  double speed = worldTileSize * 3.5;

  late SpriteComponent idleComponent;
  late SpriteAnimationComponent runAnimation;

  @override
  Future<void> onLoad() async {
    final idleSprite = Sprite(game.images.fromCache(
      Assets.characters.player.poses.idle.path,
    ));
    idleComponent = SpriteComponent(
      sprite: idleSprite,
      size: playerSize,
    );

    final animation = SpriteAnimation.spriteList(
      [
        Sprite(game.images.fromCache(Assets.characters.player.poses.run1.path)),
        Sprite(game.images.fromCache(Assets.characters.player.poses.run2.path)),
        Sprite(game.images.fromCache(Assets.characters.player.poses.run3.path)),
        Sprite(game.images.fromCache(Assets.characters.player.poses.run4.path)),
        Sprite(game.images.fromCache(Assets.characters.player.poses.run5.path)),
        Sprite(game.images.fromCache(Assets.characters.player.poses.run6.path)),
      ],
      stepTime: 0.15,
    );
    runAnimation = SpriteAnimationComponent(
      animation: animation,
      size: playerSize,
    );

    add(idleComponent);
  }

  @override
  void update(double dt) {
    final originalPosition = position.clone();

    Vector2 movementThisFrame;

    if (!joystick.delta.isZero()) {
      horizontalDirection = 0;
      movementThisFrame = joystick.delta.normalized() * speed * dt;

      switch (joystick.direction) {
        case JoystickDirection.left:
        case JoystickDirection.upLeft:
        case JoystickDirection.downLeft:
          horizontalDirection = -1;
          break;

        case JoystickDirection.right:
        case JoystickDirection.upRight:
        case JoystickDirection.downRight:
          horizontalDirection = 1;
          break;
        default:
          break;
      }
    } else {
      movementThisFrame = movement * speed * dt;
    }

    position.add(movementThisFrame);
    position = originalPosition..add(movementThisFrame);

    if (movementThisFrame.length2 == 0) {
      if (children.contains(runAnimation)) {
        remove(runAnimation);
      }
      if (!children.contains(idleComponent)) {
        add(idleComponent);
      }
    } else {
      if (!children.contains(runAnimation)) {
        add(runAnimation);
      }
      if (children.contains(idleComponent)) {
        remove(idleComponent);
      }
    }

    if (horizontalDirection < 0 && scale.x > 0) {
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      flipHorizontally();
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    horizontalDirection += oneOf(keysLeft, keysPressed) ? -1 : 0;
    horizontalDirection += oneOf(keysRight, keysPressed) ? 1 : 0;

    if (event is KeyDownEvent) {
      if (keysUp.contains(event.logicalKey)) {
        movement = Vector2(movement.x, -1);
      }
      if (keysDown.contains(event.logicalKey)) {
        movement = Vector2(movement.x, 1);
      }
      if (keysLeft.contains(event.logicalKey)) {
        movement = Vector2(-1, movement.y);
      }
      if (keysRight.contains(event.logicalKey)) {
        movement = Vector2(1, movement.y);
      }
      return false;
    } else if (event is KeyUpEvent) {
      if (keysUp.contains(event.logicalKey)) {
        // if keysPressed contains one of keysUp, set movement.y to 1
        movement.y = oneOf(keysDown, keysPressed) ? 1 : 0;
      }
      if (keysDown.contains(event.logicalKey)) {
        movement.y = oneOf(keysUp, keysPressed) ? -1 : 0;
      }
      if (keysLeft.contains(event.logicalKey)) {
        movement.x = oneOf(keysRight, keysPressed) ? 1 : 0;
      }
      if (keysRight.contains(event.logicalKey)) {
        movement.x = oneOf(keysLeft, keysPressed) ? -1 : 0;
      }
      return false;
    }

    return true;
  }
}

bool oneOf<T>(Iterable<T> value, Iterable<T> items) {
  for (final item in items) {
    if (value.contains(item)) {
      return true;
    }
  }
  return false;
}
