import 'package:flutter/material.dart';

class PauseButton extends StatelessWidget {
  final VoidCallback onPause;

  const PauseButton({super.key, required this.onPause});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: onPause,
          backgroundColor: Colors.greenAccent,
          child: const Icon(Icons.pause, color: Colors.black),
        ),
      ),
    );
  }
}
