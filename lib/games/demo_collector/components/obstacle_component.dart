import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

import '../demo_collector_game.dart';
import 'player_component.dart';

class ObstacleComponent extends RectangleComponent
    with CollisionCallbacks, HasGameReference<DemoCollectorGame> {
  final double speed;

  ObstacleComponent({required this.speed, required Vector2 position})
    : super(
        size: Vector2(30, 30),
        position: position,
        paint: Paint()..color = Colors.red,
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;

    if (position.y > game.size.y + size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayerComponent) {
      game.onObstacleHit();
      removeFromParent(); // Optional: remove obstacle on hit
    }
  }
}
