// This page exists so that the navigation bar can easily communicate with the two pages.

import 'package:bms_sample/Sp_page/create_invoice.dart';
import 'package:bms_sample/Sp_page/my_bus_availability.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bms_sample/Sp_page/my_invoice.dart';

class MyBus extends StatefulWidget {
  const MyBus({super.key});

  @override
  State<MyBus> createState() => _MyBusState();
}

class _MyBusState extends State<MyBus> {
  int _selectedPageIndex = 0;
  String? _busName; // Store dynamic bus name

  List<Widget> _pages = [
    MyBusAvailability(key: UniqueKey()), // Use UniqueKey for each page
    MyInvoiceScreen(key: UniqueKey()), // Use UniqueKey for each page
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Update _busName dynamically (replace with actual logic later)
    _busName = 'Example Bus 123'; // Placeholder

    return Scaffold(
      appBar: AppBar(
        title: Text(
          (_selectedPageIndex == 0)
              // ? 'My Bus [$busName]' // Use _busName directly
              ? 'My Bus BusABC'
              : 'Invoice Management',
        ),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(Icons.logout_sharp, color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: (_selectedPageIndex == 0) ? Icon(Icons.check) : null,
        onPressed: () => (_selectedPageIndex == 0) ? null : null, // Handle onPressed as needed
      ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus_rounded),
            label: 'Bus',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined),
            label: 'Invoice',
          ),
        ],
      ),
    );
  }
}