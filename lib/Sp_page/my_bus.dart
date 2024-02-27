// This page exists so that the navigation bar can easily communicate with the two pages.
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
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (_selectedPageIndex == 0)
              ? 'My Bus'
              : 'Invoice Management',
        ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.delete_outline_outlined,
          //   color: Colors.red),
          // ),
          // This needs blaze plan activated.
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(Icons.logout_sharp, color: Theme.of(context).colorScheme.primary),
          ),
          
        ],
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