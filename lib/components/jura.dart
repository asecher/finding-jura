import 'package:finding_jura/assets.gen.dart';
import 'package:finding_jura/components/player.dart';
import 'package:finding_jura/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Jura extends PositionComponent
    with HasGameReference<FindJuraGame>, CollisionCallbacks {
  static Vector2 juraSize = Vector2(32, 24);

  late SpriteComponent spriteComponent;

  Jura({
    required Vector2 position,
  }) : super(
          anchor: Anchor.center,
          priority: 1,
          size: juraSize,
          children: [RectangleHitbox()],
          position: position,
        );

  @override
  bool get debugMode => false;

  @override
  Future<void> onLoad() async {
    final sprite = Sprite(game.images.fromCache(
      Assets.characters.cat1.path,
    ));
    spriteComponent = SpriteComponent(
      sprite: sprite,
      size: juraSize,
    );

    add(spriteComponent);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      game.world.gameWin();
    }
  }
}
