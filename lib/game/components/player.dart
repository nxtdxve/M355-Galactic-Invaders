import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../game.dart';
import 'bullet.dart';
import 'enemy_bullet.dart';

class Player extends SpriteComponent with HasGameRef<GalacticInvadersGame>, CollisionCallbacks {
  late Timer _shootTimer;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('sprites/player.png');
    size = Vector2(30, 30);
    position = Vector2(gameRef.size.x / 2 - size.x / 2, gameRef.size.y - size.y - 20);
    add(RectangleHitbox());

    _shootTimer = Timer(0.44, repeat: true, onTick: shoot); // Adjust the interval as needed
    _shootTimer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _shootTimer.update(dt);
  }

  void moveLeft(double delta) {
    position.x -= delta;
    if (position.x < 0) {
      position.x = 0;
    }
  }

  void moveRight(double delta) {
    position.x += delta;
    if (position.x > gameRef.size.x - size.x) {
      position.x = gameRef.size.x - size.x;
    }
  }

  void shoot() {
    final bullet = Bullet(position: position + Vector2(size.x / 2 - 2.5, -20)); // Adjust the bullet position
    gameRef.add(bullet);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is EnemyBullet) {
      other.removeFromParent();
      gameRef.decreaseLife();
    }
    super.onCollision(intersectionPoints, other);
  }
}
