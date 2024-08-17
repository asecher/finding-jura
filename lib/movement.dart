import 'package:finding_jura/components/unwalkable.dart';
import 'package:finding_jura/game.dart';
import 'package:flame/components.dart';

mixin UnwalkableTerrain on PositionComponent, HasGameReference<FindJuraGame> {
  final Vector2 lastPosition = Vector2.zero();
  final Vector2 cachedMovementThisFrame = Vector2.zero();

  void cleanUpMovement({
    required Component collidingComponent,
    required Set<Vector2> intersectionPoints,
  }) {
    if (collidingComponent is! UnwalkableArea) {
      return;
    }

    if (cachedMovementThisFrame.x != 0) {
      position.x = lastPosition.x;
    }
    if (cachedMovementThisFrame.y != 0) {
      position.y = lastPosition.y;
    }
  }

  void checkOutOfBounds() {
    final halfSize = size / 2;
    position.clamp(halfSize, game.world.size - halfSize);
  }
}
