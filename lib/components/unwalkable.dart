import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class UnwalkableArea extends PolygonComponent {
  UnwalkableArea(super.vertices);

  @override
  bool get debugMode => false;

  @override
  bool get renderShape => false;
}

class UnwalkableRectangle extends RectangleComponent with CollisionCallbacks {
  UnwalkableRectangle(Vector2 position, Vector2 size)
      : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  bool get debugMode => false;

  @override
  bool get renderShape => false;
}

bool isUnwalkable(Component component) {
  return component is UnwalkableArea || component is UnwalkableRectangle;
}
