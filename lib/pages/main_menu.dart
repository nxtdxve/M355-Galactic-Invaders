import 'package:flutter/material.dart';
import 'game_page.dart';
import 'scoreboard.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Galactic Invaders',
          style: TextStyle(fontFamily: 'ElectronPulse'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontFamily: 'CosmicAlien', fontSize: 20),
              ),
              child: Text('Spiel starten'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScoreboardPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontFamily: 'CosmicAlien', fontSize: 20),
              ),
              child: Text('Scoreboard anzeigen'),
            ),
          ],
        ),
      ),
    );
  }
}
