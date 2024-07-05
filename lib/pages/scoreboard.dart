import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/providers/score_provider.dart';

class ScoreboardPage extends StatelessWidget {
  final List<String> positions = ['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th', '9th', '10th'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Scoreboard',
          style: TextStyle(fontFamily: 'ElectronPulse', color: Colors.greenAccent, fontSize: 28),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.greenAccent,
        ),
      ),
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
          child: Consumer<ScoreProvider>(
            builder: (context, scoreProvider, child) {
              return FutureBuilder(
                future: scoreProvider.initializeEmptyScores(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.greenAccent));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'High Scores',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'CosmicAlien',
                            color: Colors.greenAccent,
                            shadows: [
                              Shadow(
                                blurRadius: 20.0,
                                color: Colors.greenAccent,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              String prefix = positions[index];
                              String score = scoreProvider.topScores.length > index ? '${scoreProvider.topScores[index]}' : '0';
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                color: Colors.black.withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(color: Colors.greenAccent.withOpacity(0.5), width: 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        prefix,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'CosmicAlien',
                                          color: index < 3 ? Colors.greenAccent : Colors.white70,
                                          fontWeight: index < 3 ? FontWeight.bold : FontWeight.normal,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        score,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'CosmicAlien',
                                          color: index < 3 ? Colors.greenAccent : Colors.white70,
                                          fontWeight: index < 3 ? FontWeight.bold : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }
}