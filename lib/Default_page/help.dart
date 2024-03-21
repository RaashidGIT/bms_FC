import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Image.asset(
            'assets/images/mini_black.png',
            height: 100.0,
            width: 100.0,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Bus Management App',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'What is Bus Management App?',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'This app helps you manage buses efficiently. ',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
