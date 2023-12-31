import 'package:flutter/material.dart';

class MyBusAvailability extends StatefulWidget {
  const MyBusAvailability({super.key});

  @override
  State<MyBusAvailability> createState() => _MyBusAvailabilityState();
}

class _MyBusAvailabilityState extends State<MyBusAvailability> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // Build the page that shows the details of the bus stored with the firestore database by admin
      // such as Bus name, Email, UID, Bus routes (AB, BA), time schedules for (AB, BA)
      // Also enables the employee to toggle 'bus availability (on/off)
      children: [
        Text('Bus details here...'),

        // ... other widgets for invoice page
      ],
    );
  }
}
