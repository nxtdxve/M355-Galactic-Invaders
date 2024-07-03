import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'components/player.dart';
import 'components/enemy.dart';
import 'components/bullet.dart';
import 'overlays/score_display.dart';
import 'overlays/life_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/providers/score_provider.dart';
import '../pages/main_menu.dart';

class GalacticInvadersGame extends FlameGame with PanDetector, HasCollisionDetection {
  late Player player;
  bool moveLeft = false;
  bool moveRight = false;
  int score = 0;
  int lives = 3;

  double enemyDirection = 1.0;
  double enemySpeed = 50.0;
  double enemyDrop = 10.0;
  bool isGameOver = false;
  bool hasChangedDirection = false;

  late ScoreDisplay scoreDisplay;
  late LifeDisplay lifeDisplay;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    player = Player();
    await add(player);
    spawnEnemies();

    // Add score and life overlays
    scoreDisplay = ScoreDisplay(score: score);
    lifeDisplay = LifeDisplay(lives: lives);

    add(scoreDisplay);
    add(lifeDisplay);

    // Position the overlays
    scoreDisplay.position = Vector2(20, 20);
    lifeDisplay.position = Vector2(size.x - 130, 20); // Adjust as needed
  }

  void spawnEnemies() {
    const int rows = 4;
    const int columns = 8;
    const double enemySpacing = 10.0; // Spacing between enemies
    const double enemySize = 30.0; // Size of each enemy

    final double startX = (size.x - (columns * enemySize + (columns - 1) * enemySpacing)) / 2;
    final double startY = 50.0; // Adjust the starting Y position to leave space for the score and health bar

    for (int row = 0; row < rows; row++) {
      for (int column = 0; column < columns; column++) {
        final enemy = Enemy()
          ..position = Vector2(
            startX + column * (enemySize + enemySpacing),
            startY + row * (enemySize + enemySpacing),
          );
        add(enemy);
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) return;

    double delta = 200 * dt; // Adjust speed as needed

    if (moveLeft) {
      player.moveLeft(delta);
    }
    if (moveRight) {
      player.moveRight(delta);
    }

    moveEnemies(dt);

    // Update overlays
    scoreDisplay.score = score;
    lifeDisplay.lives = lives;
  }

  void moveEnemies(double dt) {
    final enemies = children.whereType<Enemy>();

    bool changeDirection = false;

    for (var enemy in enemies) {
      enemy.position.x += enemySpeed * enemyDirection * dt;

      if ((enemy.position.x < 0 && enemyDirection == -1.0) ||
          (enemy.position.x + enemy.size.x > size.x && enemyDirection == 1.0)) {
        changeDirection = true;
      }
    }

    if (changeDirection && !hasChangedDirection) {
      enemyDirection *= -1;
      for (var enemy in enemies) {
        enemy.position.y += enemyDrop;
        if (enemy.position.y + enemy.size.y > player.position.y) {
          gameOver();
        }
      }
      hasChangedDirection = true;
    } else if (!changeDirection) {
      hasChangedDirection = false;
    }
  }

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();
    final scoreProvider = Provider.of<ScoreProvider>(buildContext!, listen: false);
    scoreProvider.addScore(score);

    showDialog(
      context: buildContext!,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('Your score: $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              reset();
            },
            child: Text('Restart'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MainMenu()),
              );
            },
            child: Text('Main Menu'),
          ),
        ],
      ),
    ).then((_) {
      resumeEngine();
      isGameOver = false;
    });
  }

  void reset() {
    score = 0;
    lives = 3;
    removeAllEnemiesAndBullets();
    player.position = Vector2(size.x / 2 - player.size.x / 2, size.y - player.size.y - 20);
    spawnEnemies();
  }

  void removeAllEnemiesAndBullets() {
    children.whereType<Enemy>().forEach((enemy) => enemy.removeFromParent());
    children.whereType<Bullet>().forEach((bullet) => bullet.removeFromParent());
  }

  @override
  void onPanStart(DragStartInfo info) {
    final tapPosition = info.eventPosition.global;
    if (tapPosition.x < size.x / 2) {
      moveLeft = true;
    } else {
      moveRight = true;
    }
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    final tapPosition = info.eventPosition.global;
    moveLeft = tapPosition.x < size.x / 2;
    moveRight = tapPosition.x >= size.x / 2;
  }

  @override
  void onPanEnd(DragEndInfo info) {
    moveLeft = false;
    moveRight = false;
  }

  @override
  void onPanCancel() {
    moveLeft = false;
    moveRight = false;
  }

  void increaseScore(int points) {
    score += points;
  }

  void decreaseLife() {
    lives -= 1;
    if (lives <= 0) {
      gameOver();
    }
  }
}
