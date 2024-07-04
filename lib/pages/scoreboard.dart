import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/providers/score_provider.dart';

class ScoreboardPage extends StatelessWidget {
  final List<String> positions = ['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th', '9th', '10th'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scoreboard',
          style: TextStyle(fontFamily: 'ElectronPulse'),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFF121212), // Very dark gray background color
        child: Consumer<ScoreProvider>(
          builder: (context, scoreProvider, child) {
            return FutureBuilder(
              future: scoreProvider.initializeEmptyScores(), // Initialize empty scores
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'High Scores',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CosmicAlien',
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
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            String prefix = positions[index];
                            String score = scoreProvider.topScores.length > index ? '${scoreProvider.topScores[index]}' : '0';
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 70, // Increased width for prefix
                                    child: Text(
                                      prefix,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'CosmicAlien',
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  const SizedBox(width: 20), // Spacer
                                  Expanded(
                                    child: Text(
                                      score,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'CosmicAlien',
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
