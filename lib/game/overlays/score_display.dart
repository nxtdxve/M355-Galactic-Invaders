import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class ScoreDisplay extends TextComponent {
  int score;

  ScoreDisplay({required this.score})
      : super(
          text: 'SCORE: $score',
          textRenderer: TextPaint(
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'CosmicAlien',
              color: Colors.white,
            ),
          ),
        );

  @override
  void update(double dt) {
    super.update(dt);
    text = 'SCORE: $score';
  }
}
