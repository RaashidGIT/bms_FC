import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Bus Management'),
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
            'Version 1.0.0',
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
          ElevatedButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationIcon: Image.asset(
                  'assets/images/mini_black.png', // Replace with your logo image asset path
                  height: 50.0,
                  width: 50.0,
                ),
                applicationVersion: '1.0.0',
                applicationLegalese:
                    '© 2024 Your Company. All rights reserved.',
                children: [
                  Text(
                    'Developed by Your Team',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              );
            },
            child: Text('View Licenses'),
          ),
        ],
      ),
    );
  }
}
