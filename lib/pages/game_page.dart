import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/game.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final game = GalacticInvadersGame();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Galactic Invaders',
          style: TextStyle(
            fontFamily: 'ElectronPulse',
            color: Colors.greenAccent,
            fontSize: 24,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.greenAccent,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.greenAccent,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.pause, color: Colors.greenAccent),
            iconSize: 28,
            onPressed: game.pauseGame,
          ),
        ],
      ),
      body: GameWidget(
        game: game,
      ),
    );
  }
}