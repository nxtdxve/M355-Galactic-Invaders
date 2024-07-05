import 'package:flutter/material.dart';
import 'game_page.dart';
import 'scoreboard.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0E21),  // Very dark blue-black
              Color(0xFF090C1A),  // Even darker blue-black
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Galactic\nInvaders',
                  style: TextStyle(
                    fontFamily: 'ElectronPulse',
                    fontSize: 48,
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.greenAccent.withOpacity(0.6),
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                _buildButton(
                  context: context,
                  text: 'Play Game',
                  icon: Icons.play_arrow,
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GamePage())),
                ),
                const SizedBox(height: 24),
                _buildButton(
                  context: context,
                  text: 'Scoreboard',
                  icon: Icons.leaderboard,
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ScoreboardPage())),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Transform.rotate(
                    angle: -0.2,
                    child: Image.asset(
                      'assets/images/sprites/enemy.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.greenAccent,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'CosmicAlien',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}