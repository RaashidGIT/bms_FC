// modal screen used to add new buses into the listView

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bms_sample/Admin_page/models/bus.dart';

class NewBus extends StatefulWidget {
  const NewBus({super.key, required this.onAddBus});

  final void Function(Bus bus) onAddBus;

  @override
  State<NewBus> createState() => _NewBusState();
}

class _NewBusState extends State<NewBus> {
  // TextEditingController does all the heavy work required to store text input by the user
  final _BusNameController = TextEditingController();
  final _sourceController = TextEditingController();
  final _destinationController = TextEditingController();
  final _regController = TextEditingController();
  Bustype _selectedBustype = Bustype.Ordinary;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 0, minute: 0); // Initialize time

  final _firestore = FirebaseFirestore.instance;

  CollectionReference get busesRef => _firestore.collection('Bus');
  CollectionReference get spUsersRef => _firestore.collection('SPusers');

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }
  

  Future<void> _submitBusData() async {
    // Here we show error messages, if any appeared
    if (_destinationController.text.trim().isEmpty ||
        _sourceController.text.trim().isEmpty ||
        _destinationController.text.trim().isEmpty ||
        _regController.text.trim().isEmpty ||
        _BusNameController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid name, place and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    final formattedTime = _selectedTime.format(context); // Format time using context

     // Add bus data to Firestore
    await busesRef.add({
      'bus_name': _BusNameController.text,
      'route_AB': _sourceController.text,
      'route_BA': _destinationController.text,
      'bustype': _selectedBustype.name,
      'Regno' : _regController.text,
      'time' : formattedTime,
    });

    spUsersRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'busId': busesRef.id,
    });

    widget.onAddBus(
      Bus(
        bus_name: _BusNameController.text,
        Regno: _regController.text,
        route_AB: _sourceController.text,
        route_BA: _destinationController.text,
        bustype: _selectedBustype,
        time: formattedTime,
      ),
    );
    Navigator.pop(context);
  }
  

  @override
  void dispose() {
    // TODO: otherwise TextEditingController will live in the memory unneccesarily
    _BusNameController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _BusNameController,
            maxLength: 24,
            decoration: InputDecoration(
              label: Text('Bus Name'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _sourceController,
                  maxLength: 20,
                  decoration: InputDecoration(
                    prefix: Text('From: '),
                    label: Text('Source'),
                  ),
                ),
              ),
              const SizedBox(width: 10), // Add a spacing between the fields
              Expanded(
                child: TextField(
                  controller: _destinationController,
                  keyboardType: TextInputType.name,
                  maxLength: 20,
                  decoration: InputDecoration(
                    prefix: Text('To: '),
                    label: Text('Destination'),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _regController,
                  maxLength: 20,
                  decoration: InputDecoration(
                    label: Text('Registration no.'),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButton(
                  value: _selectedBustype,
                  items: Bustype.values
                      .map(
                        (bustype) => DropdownMenuItem(
                          value: bustype,
                          child: Text(
                            bustype.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedBustype = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Time: ${_selectedTime.format(context)}', // Display selected time
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: _selectTime,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Add a new bus instance',
                    style: TextStyle(fontSize: 14, color: Colors.teal[900]),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitBusData,
                child: Text('Save Bus'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
