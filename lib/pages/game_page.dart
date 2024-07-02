import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galactic Invaders - Game'),
      ),
      body: Center(
        child: Text(
          'Game Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
