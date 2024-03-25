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
          const Text(
              'Admin:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Admin is logged in with an admin-specific email and password.'),
            const Text('Admin can add SPusers and Bus instances by filling their respective fields properly.'),
            const SizedBox(height: 16),
            const Text(
              'SPuser:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('SPusers can log in to the app (if their account is created by Admin).'),
            const Text('SPusers can toggle "Bus availability" to true or false.'),
            const Text('SPusers can write invoices in the app.'),
            const Text('Invoices can be filtered by date.'),
            const Text('Total amount of income can be calculated.'),
            const SizedBox(height: 16),
            const Text(
              'Normal User:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Normal users can search for available buses in the bus schedule by filling the search field properly.'),
            const Text('They can see whether the bus is available or not.'),
            const Text('They can track their location using a map built into the app.'),
        ],
      ),
    );
  }
}
