import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Enemy extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('sprites/enemy.png'); // Ensure you have an enemy.png in your assets/sprites
    size = Vector2(32, 25); // Adjust size as needed
    add(RectangleHitbox());
  }
}
