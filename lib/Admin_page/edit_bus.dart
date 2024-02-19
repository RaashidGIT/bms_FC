// The first page admins see after loggin in

// ignore_for_file: unused_import

import 'package:bms_sample/Admin_page/add_sp.dart';
import 'package:bms_sample/Admin_page/del_sp.dart';
import 'package:bms_sample/Admin_page/new_bus.dart';
import 'package:bms_sample/Admin_page/widgets/buses_list/edit_bus_list.dart';
import 'package:bms_sample/login_page/auth.dart';
import 'package:bms_sample/models/bus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<Bus> _registeredBuses = []; // Empty list to store fetched buses

  void _openAddBusOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewBus(onAddBus: _addBus),
    );
  }

  void _addBus(Bus bus) {
    setState(() {
      _registeredBuses.add(bus);
    });
  }

   void _removeBus(Bus bus) async {
    final busIndex = _registeredBuses.indexOf(bus);

    // UI update
    setState(() {
      _registeredBuses.remove(bus);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Bus deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredBuses.insert(busIndex, bus);
            });
          },
        ),
      ),
    );

    // Delete from Firestore in the background
  Future.delayed(const Duration(seconds: 3), () async {
    try {
      await FirebaseFirestore.instance.collection('Bus').doc(bus.id).delete();
      // Success message or visual cue if desired
    } catch (error) {
      // Handle errors gracefully (e.g., retry, log, show an error message)
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting bus: ${error.toString()}'),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () => _removeBus(bus), // Retry deletion on tap
          ),
        ),
      );
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text('No buses found. Start adding some!'),
    );

    if (_registeredBuses.isNotEmpty) {
      mainContent = BusesList(
        buses: _registeredBuses,
        onRemoveBus: _removeBus,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
        actions: [
          IconButton(
            onPressed: _openAddBusOverlay,
            icon: Icon(Icons.add_box_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminAuthScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.person_add_alt_1,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DelSpScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.person_remove_alt_1,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout_sharp),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('Bus').get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                  _registeredBuses.clear(); 
                  for (var doc in snapshot.data!.docs) {
                  _registeredBuses.add(Bus.fromMap(doc.data() as Map<String, dynamic>));
                }
                  return BusesList(
                    buses: _registeredBuses,
                    onRemoveBus: _removeBus,
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
