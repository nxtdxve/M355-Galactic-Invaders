import 'package:flutter/material.dart';
import 'game_page.dart';
import 'scoreboard.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Galactic Invaders',
          style: TextStyle(fontFamily: 'ElectronPulse'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontFamily: 'CosmicAlien', fontSize: 20),
              ),
              child: const Text('Spiel starten'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScoreboardPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontFamily: 'CosmicAlien', fontSize: 20),
              ),
              child: const Text('Scoreboard anzeigen'),
            ),
          ],
        ),
      ),
    );
  }
}
