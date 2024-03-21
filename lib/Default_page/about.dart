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
            'Demo Version',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            "Developed by students from the Farook College Computer Science Department for their final year project submission (2021 - 2024).",
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 16.0),
          const Center(
            child: Column(
              children: [
                Text('Athira (Leader & Co-Ordinator)', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Text('Raashid (Main Programmer)', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Text('Hafeefa (Main Designer)', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Text('Irfan (Software Architect)', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}