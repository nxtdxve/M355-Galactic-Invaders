import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/game.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Galactic Invaders',
          style: TextStyle(fontFamily: 'ElectronPulse'),
        ),
      ),
      body: GameWidget(
        game: GalacticInvadersGame(),
      ),
    );
  }
}
