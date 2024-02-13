// modal screen used to add new buses into the listView

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bms_sample/models/bus.dart';

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
  Bustype _selectedBustype = Bustype.Ordinary;

  // Controller for the selected time
  // DateTime? _selectedTime;

  // Future<void> _presentTimePicker() async {
  //   final newDateTime = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedTime ?? DateTime.now(),
  //     firstDate: DateTime(2000), // Optional: Set a minimum date
  //     lastDate: DateTime(2100), // Optional: Set a maximum date
  //   );
  //   if (newDateTime != null) {
  //     setState(() {
  //       _selectedTime = newDateTime;
  //     });
  //   }
  // }

  // TimeOfDay? _selectedTime;

  // Future<void> _presentTimePicker() async {
  //   final newTime = await showTimePicker(
  //     context: context,
  //     initialTime: _selectedTime ?? TimeOfDay.now(),
  //   );
  //   if (newTime != null) {
  //     setState(() {
  //       _selectedTime = newTime;
  //     });
  //   }
  // }

  // Add Firestore instance and collection reference
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // final CollectionReference busesRef = firestore.collection('Bus');

  final _firestore = FirebaseFirestore.instance;

  CollectionReference get busesRef {
    return _firestore.collection('Bus');
  }

  Future<void> _submitBusData() async {
    // Here we show error messages, if any appeared
    if (_destinationController.text.trim().isEmpty ||
        _sourceController.text.trim().isEmpty ||
        _destinationController.text.trim().isEmpty ||
        _BusNameController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid name, place, time and category was entered.'),
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

     // Add bus data to Firestore
    await busesRef.add({
      'bus_name': _BusNameController.text,
      'route_AB': _sourceController.text,
      'route_BA': _destinationController.text, // Assuming same route for BA
      'bustype': _selectedBustype.name,
    });

    widget.onAddBus(
      Bus(
        bus_name: _BusNameController.text,
        // route_AB: _sourceController,
        // route_BA: _destinationController,
        // time_AB: _selectedTime,
        route_AB: _sourceController.text,
        route_BA: _destinationController.text,
        bustype: _selectedBustype,
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
          // Add a bus icon that dynamically changes depending on the category type inputted by
          // the user here
          //,
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
              DropdownButton(
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
              const Spacer(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(_selectedTime != null
                    //     ? '${_selectedTime!.format(context)}'
                    //     : 'Select Time'),
                    // Text(
                    //   _selectedTime == null
                    //       ? 'No Time selected'
                    //       : formatter.format(_selectedTime!),
                    // ),
                    // IconButton(
                    //   onPressed: _presentTimePicker,
                    //   icon: Icon(Icons.access_time_rounded),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
