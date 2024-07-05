import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';

import '../../core/providers/score_provider.dart';
import '../../pages/main_menu.dart';
import 'components/player.dart';
import 'components/enemy.dart';
import 'components/enemy_bullet.dart';
import 'components/bullet.dart';
import 'overlays/score_display.dart';
import 'overlays/life_display.dart';

/// Main game class for Galactic Invaders
class GalacticInvadersGame extends FlameGame with PanDetector, HasCollisionDetection {
  // Player and game state
  late Player player;
  bool moveLeft = false;
  bool moveRight = false;
  int score = 0;
  int lives = 3;
  bool isGameOver = false;
  bool enemiesSpawning = false; // Flag to indicate enemy spawning
  bool isPaused = false; // Flag to indicate if the game is paused

  // Enemy movement
  double enemyDirection = 1.0;
  double enemySpeed = 45.0;
  double enemyDrop = 10.0;
  bool hasChangedDirection = false;

  // Wave and shooting
  double shootTimer = 0.0; // Timer to control enemy shooting frequency
  double shootInterval = 1.0; // Interval between enemy shots
  int wave = 1; // Current wave

  // UI elements
  late ScoreDisplay scoreDisplay;
  late LifeDisplay lifeDisplay;

  /// Loads the game components
  @override
  Future<void> onLoad() async {
    super.onLoad();
    _initializePlayer();
    _initializeOverlays();
    _startBackgroundMusic();
    spawnEnemies();
  }

  @override
  void onRemove() {
    super.onRemove();
    FlameAudio.bgm.stop(); // Stop background music when the game is removed
  }

  /// Initialize player component
  void _initializePlayer() async {
    player = Player();
    await add(player);
  }

  /// Initialize score and life overlays
  void _initializeOverlays() {
    scoreDisplay = ScoreDisplay(score: score);
    lifeDisplay = LifeDisplay(lives: lives);

    add(scoreDisplay);
    add(lifeDisplay);

    // Position the overlays
    scoreDisplay.position = Vector2(20, 20); // Adjust as needed
    lifeDisplay.position = Vector2(size.x - 150, 20); // Adjust as needed
  }

  /// Start background music
  void _startBackgroundMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('background_music.mp3', volume: 0.4); // Adjust volume as needed
  }

  /// Spawn enemies on the screen
  void spawnEnemies() async {
    enemiesSpawning = true; // Set flag to true before spawning enemies

    const int rows = 4;
    const int columns = 8;
    const double enemySpacing = 10.0; // Spacing between enemies
    const double enemySize = 30.0; // Size of each enemy

    final double startX = (size.x - (columns * enemySize + (columns - 1) * enemySpacing)) / 2;
    const double startY = 50.0; // Adjust the starting Y position to leave space for the score and health bar

    for (int row = 0; row < rows; row++) {
      for (int column = 0; column < columns; column++) {
        final enemy = Enemy()
          ..position = Vector2(
            startX + column * (enemySize + enemySpacing),
            startY + row * (enemySize + enemySpacing),
          );
        await add(enemy); // Await adding the enemy to ensure they are fully added before proceeding
      }
    }

    enemySpeed += 5.0 * wave; // Increase enemy speed slightly for each wave
    shootInterval -= 0.04 * wave; // Decrease the shooting interval for each wave

    enemiesSpawning = false; // Reset flag after spawning enemies
  }

  /// Update the game state
  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver || isPaused) return; // Skip update if the game is over or paused

    _updatePlayerMovement(dt);
    _moveEnemies(dt);
    _updateOverlays();
    _handleEnemyShooting(dt);
    _checkForNextWave();
  }

  /// Update player movement based on input
  void _updatePlayerMovement(double dt) {
    double delta = 200 * dt; // Adjust speed as needed

    if (moveLeft) {
      player.moveLeft(delta);
    }
    if (moveRight) {
      player.moveRight(delta);
    }
  }

  /// Move enemies on the screen
  void _moveEnemies(double dt) {
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
          _gameOver();
        }
      }
      hasChangedDirection = true;
    } else if (!changeDirection) {
      hasChangedDirection = false;
    }
  }

  /// Update score and life overlays
  void _updateOverlays() {
    scoreDisplay.score = score;
    lifeDisplay.lives = lives;
  }

  /// Handle enemy shooting
  void _handleEnemyShooting(double dt) {
    shootTimer += dt;
    if (shootTimer >= shootInterval) {
      shootTimer = 0.0;
      _enemyShoot();
    }
  }

  /// Check if all enemies are destroyed to spawn a new wave
  void _checkForNextWave() {
    if (!enemiesSpawning && children.whereType<Enemy>().isEmpty && !isGameOver) {
      wave++;
      spawnEnemies();
    }
  }

  /// Handle enemy shooting logic
  void _enemyShoot() {
    const columns = 8;
    final List<List<Enemy>> enemyColumns = List.generate(columns, (_) => []);
    final enemies = children.whereType<Enemy>();

    for (var enemy in enemies) {
      int column = ((enemy.position.x - enemies.first.position.x) / 40).round(); // Calculate column index
      if (column >= 0 && column < columns) {
        enemyColumns[column].add(enemy);
      }
    }

    // Filter out empty columns
    enemyColumns.removeWhere((column) => column.isEmpty);

    if (enemyColumns.isNotEmpty) {
      final randomColumn = enemyColumns[Random().nextInt(enemyColumns.length)];
      final lowestEnemy = randomColumn.reduce((value, element) => value.position.y > element.position.y ? value : element);

      final enemyBullet = EnemyBullet()
        ..position = lowestEnemy.position.clone()
        ..position.y += lowestEnemy.size.y / 2; // Adjust position to start from the enemy
      add(enemyBullet);
    }
  }

  /// Pause the game
  void pauseGame() {
    isPaused = true;
    pauseEngine();
    FlameAudio.bgm.pause();
    showDialog(
      context: buildContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF090C1A),
        title: const Text(
          'Game Paused',
          style: TextStyle(
            fontFamily: 'CosmicAlien',
            color: Colors.greenAccent,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resumeGame();
            },
            child: const Text(
              'Resume',
              style: TextStyle(
                fontFamily: 'CosmicAlien',
                color: Colors.greenAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Resume the game
  void resumeGame() {
    isPaused = false;
    resumeEngine();
    FlameAudio.bgm.resume();
  }

  /// End the game and show the game over screen
  void _gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    FlameAudio.play('game_over.wav'); // Play game over sound

    final scoreProvider = Provider.of<ScoreProvider>(buildContext!, listen: false);
    scoreProvider.addScore(score);

    showDialog(
      context: buildContext!,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF090C1A),
        title: const Text(
          'Game Over',
          style: TextStyle(
            fontFamily: 'CosmicAlien',
            color: Colors.greenAccent,
          ),
        ),
        content: Text(
          'Your score: $score',
          style: const TextStyle(
            fontFamily: 'CosmicAlien',
            color: Colors.greenAccent,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _reset();
            },
            child: const Text(
              'Restart',
              style: TextStyle(
                fontFamily: 'CosmicAlien',
                color: Colors.greenAccent,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MainMenu()),
              );
            },
            child: const Text(
              'Main Menu',
              style: TextStyle(
                fontFamily: 'CosmicAlien',
                color: Colors.greenAccent,
              ),
            ),
          ),
        ],
      ),
    ).then((_) {
      // Ensure the game does not resume automatically
      if (!isGameOver) {
        resumeEngine();
      }
    });
  }

  /// Reset the game to its initial state
  void _reset() {
    score = 0;
    lives = 3;
    wave = 1;
    enemySpeed = 45.0; // Reset enemy speed to initial value
    shootInterval = 1.0; // Reset shooting interval to initial value
    _removeAllEnemiesAndBullets();
    player.position = Vector2(size.x / 2 - player.size.x / 2, size.y - player.size.y - 20);
    spawnEnemies();
    isGameOver = false; // Reset game over flag
    resumeEngine(); // Resume the engine only after resetting
  }

  /// Remove all enemies and bullets from the game
  void _removeAllEnemiesAndBullets() {
    children.whereType<Enemy>().forEach((enemy) => enemy.removeFromParent());
    children.whereType<Bullet>().forEach((bullet) => bullet.removeFromParent());
    children.whereType<EnemyBullet>().forEach((bullet) => bullet.removeFromParent());
  }

  /// Handle touch input start
  @override
  void onPanStart(DragStartInfo info) {
    if (isGameOver) return;

    final tapPosition = info.eventPosition.global;
    if (tapPosition.x < size.x / 2) {
      moveLeft = true;
    } else {
      moveRight = true;
    }
  }

  /// Handle touch input update
  @override
  void onPanUpdate(DragUpdateInfo info) {
    if (isGameOver) return;

    final tapPosition = info.eventPosition.global;
    moveLeft = tapPosition.x < size.x / 2;
    moveRight = tapPosition.x >= size.x / 2;
  }

  /// Handle touch input end
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

  /// Increase the player's score
  void increaseScore(int points) {
    score += (points * wave) ~/ 2;
  }

  /// Decrease the player's life
  void decreaseLife() {
    lives -= 1;
    if (lives <= 0) {
      _gameOver();
    }
  }
}
