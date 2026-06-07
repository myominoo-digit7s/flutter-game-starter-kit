import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

import '../demo_collector_game.dart';
import 'player_component.dart';

class CollectibleComponent extends CircleComponent
    with CollisionCallbacks, HasGameReference<DemoCollectorGame> {
  final double speed;

  CollectibleComponent({required this.speed, required Vector2 position})
    : super(
        radius: 15,
        position: position,
        paint: Paint()..color = Colors.green,
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;

    if (position.y > game.size.y + radius) {
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
      game.onCollectibleCaught();
      removeFromParent();
    }
  }
}
