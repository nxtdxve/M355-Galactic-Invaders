import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class EnemyBullet extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final Vector2 velocity = Vector2(0, 300); // Speed of the bullet

  EnemyBullet() {
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('sprites/bullet.png');
    size = Vector2(3, 15); // Adjust the size as needed
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    // Remove the bullet if it goes off-screen
    if (position.y > gameRef.size.y) {
      removeFromParent();
    }
  }
}
