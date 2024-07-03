import 'package:shared_preferences/shared_preferences.dart';

class ScoreService {
  Future<List<int>> getTopScores() async {
    final prefs = await SharedPreferences.getInstance();
    final scores = prefs.getStringList('topScores')?.map((e) => int.parse(e)).toList() ?? [];
    scores.sort((a, b) => b.compareTo(a)); // sort descending
    return scores;
  }

  Future<void> saveScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final scores = prefs.getStringList('topScores')?.map((e) => int.parse(e)).toList() ?? [];
    scores.add(score);
    scores.sort((a, b) => b.compareTo(a)); // sort descending
    if (scores.length > 10) {
      scores.removeLast();
    }
    await prefs.setStringList('topScores', scores.map((e) => e.toString()).toList());
  }

  Future<void> initializeFakeScores() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('topScores') == null || prefs.getStringList('topScores')!.isEmpty) {
      final fakeScores = [1100, 1000, 900, 800, 700, 600, 500, 400, 300, 200];
      await prefs.setStringList('topScores', fakeScores.map((e) => e.toString()).toList());
    }
  }

  Future<void> initializeEmptyScores() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('topScores') == null) {
      await prefs.setStringList('topScores', []);
    }
  }

  Future<void> clearScores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('topScores');
  }
}
