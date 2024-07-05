import 'package:flutter/material.dart';
import 'game_page.dart';
import 'scoreboard.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF121212), // Very dark gray background color
        child: Center(
          child: Stack(
            children: [
              Column(
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
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 250, // Fixed width for the buttons
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GamePage()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        textStyle: const TextStyle(fontFamily: 'CosmicAlien', fontSize: 20),
                        side: const BorderSide(color: Colors.green, width: 2), // Button outline color
                        foregroundColor: Colors.green, // Button text color
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
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ScoreboardPage()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        textStyle: const TextStyle(fontFamily: 'CosmicAlien', fontSize: 20),
                        side: const BorderSide(color: Colors.green, width: 2), // Button outline color
                        foregroundColor: Colors.green, // Button text color
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
              Positioned(
                top: 100,
                right: 35,
                child: Transform.rotate(
                  angle: 0.55, // Around 31 degrees in radian
                  child: Image.asset(
                    'assets/images/sprites/enemy.png',
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
