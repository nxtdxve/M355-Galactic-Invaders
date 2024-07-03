import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/game.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galactic Invaders'),
      ),
      body: GameWidget(
        game: GalacticInvadersGame(),
      ),
    );
  }
}
