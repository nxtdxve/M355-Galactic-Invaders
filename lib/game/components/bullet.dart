import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:myapp/game/components/enemy.dart';
import 'package:myapp/game/game.dart';

class Bullet extends SpriteComponent with HasGameRef {
  Bullet({required Vector2 position}) {
    this.position = position;
    size = Vector2(2, 12); // Größe des Schusses
  }

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('sprites/bullet.png'); // Ensure you have a bullet.png in your assets/sprites
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= 700 * dt; // Adjust the speed of the bullet

    if (position.y < 0) {
      removeFromParent();
    }

    checkForCollisions();
  }

  void checkForCollisions() {
    final enemies = gameRef.children.whereType<Enemy>();
    for (var enemy in enemies) {
      if (enemy.toRect().overlaps(toRect())) {
        enemy.removeFromParent();
        removeFromParent();
        (gameRef as GalacticInvadersGame).increaseScore(100);
      }
    }
  }
}
