// This page exists so that the navigation bar can easily communicate with the two pages.

import 'package:bms_sample/Sp_page/create_invoice.dart';
import 'package:bms_sample/Sp_page/my_bus_availability.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bms_sample/Sp_page/my_invoice.dart';
// import 'package:bms_2/widgets/chat_messages.dart';
// import 'package:bms_2/widgets/new_message.dart';

class MyBus extends StatefulWidget {
  const MyBus({super.key});

  @override
  State<MyBus> createState() => _MyBusState();
}

class _MyBusState extends State<MyBus> {
  int _selectedPageIndex = 0;
  String? _busName; // Store dynamic bus name

  List<Widget> _pages = [
    // Define the widgets for each page
    Column(
      children: [
        MyBusAvailability(),
      ],
    ),
    Column(
      children: [MyInvoiceScreen()],
    ),
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index; // Call setState to trigger a rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fetch and set dynamic bus name (replace with the logic)
    _busName = 'Example Bus 123'; // Replace with the bus name fetching logic

    return Scaffold(
      appBar: AppBar(
        title: (_selectedPageIndex == 0)
            ? Text('My Bus [$_busName]')
            : Text('Invoice Management'), // ADD DYNAMIC BUS NAMES HERE!
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.logout_sharp,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: (_selectedPageIndex == 0)
            ? Icon(Icons.check)
            : null, // Icon for the FAB
        onPressed: () {
          (_selectedPageIndex == 0) ? const Icon(Icons.close) : null;
          // Code to execute when the FAB is pressed
        },
      ),
      body: _pages[_selectedPageIndex], // Display the selected page
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
