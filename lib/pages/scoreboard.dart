import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/providers/score_provider.dart';

class ScoreboardPage extends StatelessWidget {
  final List<String> positions = ['1st', '2nd', '3rd', '4th', '5th'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scoreboard', style: TextStyle(fontFamily: 'ElectronPulse')),
      ),
      body: Consumer<ScoreProvider>(
        builder: (context, scoreProvider, child) {
          return FutureBuilder(
            future: scoreProvider.initializeFakeScores(),
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
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          String prefix = index < positions.length ? positions[index] : '';
                          String score = scoreProvider.topScores.length > index ? '${scoreProvider.topScores[index]}' : '';
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 60,  // Breite für Präfix
                                  child: Text(
                                    prefix,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'CosmicAlien',
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                const SizedBox(width: 40),  // Vergrößerter Abstand
                                Expanded(
                                  child: Text(
                                    score,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'CosmicAlien',
                                    ),
                                    textAlign: TextAlign.center,
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
    );
  }
}
