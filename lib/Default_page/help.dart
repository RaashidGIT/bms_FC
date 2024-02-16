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
        padding: EdgeInsets.all(16.0),
        children: [
          Image.asset(
            'assets/images/mini_black.png', // Replace with your logo image asset path
            height: 100.0,
            width: 100.0,
          ),
          SizedBox(height: 16.0),
          Text(
            'Bus Management App',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'How to use?',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'This app helps you manage buses efficiently. '
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
