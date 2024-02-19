// // widget for edit_bus_list.dart

// // ignore_for_file: unused_import

// import 'package:intl/intl.dart';

// import 'package:bms_sample/models/bus.dart';
// import 'package:flutter/material.dart';

// class BusItem extends StatelessWidget {
//   const BusItem(this.bus, {super.key});

//   final Bus bus;

//   @override
//   Widget build(BuildContext context) {
//     // puts the content passed to the card a card design
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 16,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               bus.bus_name,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             // const SizedBox(height: 4),
//             // .....
//             Row(
//               children: [
//                 // Image.asset('assets/images/ordinary_black.png'),
//                 // Text(
//                 //   DateFormat('h:mm a').format(bus.time_AB.last),
//                 // ),
//                 // Text(bus.time_AB[0].toString()),

//                 const Spacer(), Text('To: ${bus.route_BA}'),
//                 // Row(
//                 //   children: [
//                 //     (bus.available)
//                 //         ? Icon(Icons.circle_rounded)
//                 //         : Icon(Icons.circle_outlined),
//                 //     Text('To: ${bus.route_AB.last}'),
//                 //   ],
//                 // ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
