import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class UnwalkableArea extends PolygonComponent with CollisionCallbacks {
  UnwalkableArea(super.vertices);

  @override
  Future<void> onLoad() async {
    add(PolygonHitbox(vertices));
  }

  @override
  bool get debugMode => false;

  @override
  bool get renderShape => false;
}
