import 'package:flutter/material.dart';
import 'game_page.dart';
import 'scoreboard.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Galactic Invaders',
          style: TextStyle(fontFamily: 'ElectronPulse'),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFF121212), // Very dark gray background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),
              const Text(
                'Galactic Invaders',
                style: TextStyle(
                  fontFamily: 'ElectronPulse',
                  fontSize: 50,
                  color: Colors.greenAccent,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 250, // Fixed width for the buttons
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GamePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontFamily: 'CosmicAlien', fontSize: 20),
                    backgroundColor: Colors.green, // Button background color
                    foregroundColor: Colors.white, // Button text color
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Spiel starten'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 250, // Fixed width for the buttons
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScoreboardPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontFamily: 'CosmicAlien', fontSize: 20),
                    backgroundColor: Colors.green, // Button background color
                    foregroundColor: Colors.white, // Button text color
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Scoreboard'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
