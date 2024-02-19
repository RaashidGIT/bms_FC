// widget for edit_bus_list.dart

// ignore_for_file: unused_import

import 'package:intl/intl.dart';

import 'package:bms_sample/models/bus.dart';
import 'package:flutter/material.dart';

class BusItem extends StatelessWidget {
  const BusItem(this.bus, {super.key});

  final Bus bus;

// puts the content passed to the card a card design
@override
Widget build(BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Adjusted padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
               child: BustypeIcons[bus.bustype] ?? Image.asset('assets/images/default_bus.png'), // Use default if Bustype not mapped
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 7,
            child: SingleChildScrollView( // Consider this if content has variable length
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bus.bus_name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, overflow: TextOverflow.ellipsis), // Truncate long text
                  ),
                  const SizedBox(height: 4),
                  Row(
                    // Reduce spacing between To: and From:
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'To: ${bus.route_BA}',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 5), // Reduced spacing
                      //   Text(
                      //   // DateFormat('h:mm a').format(bus.time_AB.last),
                      // last accesses the latest departure time
                      //   style: TextStyle(fontSize: 14), // Increased text size
                      // ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    // Move Track button to the right
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'From: ${bus.route_AB}',
                        style: TextStyle(fontSize: 14),
                      ),
                      // ElevatedButton(
                      //   onPressed: () => print('Track button pressed!'),
                      //   child: Text('Track'),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}