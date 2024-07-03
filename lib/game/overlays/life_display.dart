import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';

class LifeDisplay extends PositionComponent {
  int lives;
  late Sprite heartSprite;

  LifeDisplay({required this.lives});

  @override
  Future<void> onLoad() async {
    heartSprite = await Sprite.load('sprites/heart.png');
    size = Vector2(150, 30); // Adjust the size as needed
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    for (int i = 0; i < lives; i++) {
      heartSprite.render(
        canvas,
        position: Vector2(i * 40.0, 0), // Adjust the spacing as needed
        size: Vector2(24, 20), // Adjust the size as needed
      );
    }
  }
}
