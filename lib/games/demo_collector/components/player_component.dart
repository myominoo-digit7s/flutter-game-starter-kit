import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class PlayerComponent extends RectangleComponent with CollisionCallbacks {
  PlayerComponent()
    : super(
        size: Vector2(60, 60),
        paint: Paint()..color = Colors.blue,
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  void move(double deltaX, double screenWidth) {
    position.x += deltaX;

    // Clamp to screen bounds
    final halfSize = size.x / 2;
    if (position.x < halfSize) {
      position.x = halfSize;
    } else if (position.x > screenWidth - halfSize) {
      position.x = screenWidth - halfSize;
    }
  }
}
