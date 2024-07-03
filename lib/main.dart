import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/providers/score_provider.dart';
import 'pages/loading_screen.dart';
import 'pages/main_menu.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScoreProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Simulieren Sie eine Ladezeit oder führen Sie Initialisierungen durch
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galactic Invaders',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isLoading ? LoadingScreen() : MainMenu(),
    );
  }
}
