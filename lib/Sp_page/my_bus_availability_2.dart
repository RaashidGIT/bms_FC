// // This is an alternate code that can be used for the bus information page.

// import 'package:flutter/material.dart';

// class MyBusAvailability extends StatefulWidget {
//   const MyBusAvailability({super.key});

//   @override
//   State<MyBusAvailability> createState() => _MyBusAvailabilityState();
// }

// class _MyBusAvailabilityState extends State<MyBusAvailability> {
//   @override
//   Widget build(BuildContext context) {
//   // Extract data from Firestore database
//   var busName = '...'; // Replace with actual bus name
//   var email = '...'; // Replace with actual email
//   var uid = '...'; // Replace with actual UID
//   var routes = ['AB', 'BA']; // Replace with actual routes
//   var timeSchedules = {
//     // ... Time schedules for AB and BA routes (structure depends on your data)
//   };
//   var isBusAvailable = true; // Assuming you have logic to determine availability

//   return Scaffold( // Assuming you want a full Scaffold instead of just a Column
//     appBar: AppBar(
//       title: Text('Bus Details'),
//     ),
//     body: Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primaryContainer,
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start, // Align text left
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space evenly
//                     children: [
//                       Text('Bus name:', style: TextStyle(fontSize: 16.0)),
//                       Text(busName, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                   Text('Email:', style: TextStyle(fontSize: 16.0)),
//                   Text(email, style: TextStyle(fontSize: 16.0)),
//                   Text('UID:', style: TextStyle(fontSize: 16.0)),
//                   Text(uid, style: TextStyle(fontSize: 16.0)),
//                   Text('Bus routes:', style: TextStyle(fontSize: 16.0)),
//                   Wrap( // Wrap routes for better readability
//                     children: routes.map((route) => Text(route + ' ')).toList(),
//                   ),
//                   Text('Time schedules:', style: TextStyle(fontSize: 16.0)),
//                   // Display time schedules using appropriate widgets (e.g., ListView)
//                   ToggleButtons(
//                     children: [
//                       IconButton(
//                         icon: Icon(
//                           Icons.directions_bus,
//                           color: isBusAvailable ? Colors.green : Colors.red,
//                         ),
//                         onPressed: () => setState(() => isBusAvailable = !isBusAvailable),
//                       ),
//                     ],
//                     isSelected: [isBusAvailable],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // ... other invoice page widgets
//         ],
//       ),
//     ),
//   );
// }
// }
