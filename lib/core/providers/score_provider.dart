import 'package:flutter/material.dart';
import '../services/score_service.dart';

class ScoreProvider with ChangeNotifier {
  List<int> _topScores = [];
  final ScoreService _scoreService = ScoreService();
  bool _initialized = false;

  List<int> get topScores => _topScores;

  Future<void> fetchTopScores() async {
    _topScores = await _scoreService.getTopScores();
    notifyListeners();
  }

  Future<void> addScore(int score) async {
    await _scoreService.saveScore(score);
    await fetchTopScores();
  }

  Future<void> initializeFakeScores() async {
    if (!_initialized) {
      await _scoreService.initializeFakeScores();
      _initialized = true;
      await fetchTopScores();
    }
  }

  Future<void> initializeEmptyScores() async {
    if (!_initialized) {
      await _scoreService.initializeEmptyScores();
      _initialized = true;
      await fetchTopScores();
    }
  }

  Future<void> clearScores() async {
    await _scoreService.clearScores();
    _topScores = [];
    notifyListeners();
  }
}
