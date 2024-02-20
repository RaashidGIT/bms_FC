// // widget for del_sp.dart

// // ignore_for_file: unused_import

// import 'package:intl/intl.dart';
// import 'package:bms_sample/Admin_page/models/delSp.dart';
// import 'package:flutter/material.dart';

// class DelSpItem extends StatelessWidget {
//   const DelSpItem(this.delsp, {super.key});

//   final DelSp delsp;

// // puts the content passed to the card a card design
// @override
// Widget build(BuildContext context) {
//   return Card(
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Adjusted padding
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 7,
//             child: SingleChildScrollView( // Consider this if content has variable length
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     delsp.bus_name,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, overflow: TextOverflow.ellipsis), // Truncate long text
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     // Reduce spacing between To: and From:
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                         Text(
//                         'Username: ${delsp.username}',
//                         style: TextStyle(fontSize: 14), // Increased text size
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     // Move Track button to the right
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                         Text(
//                         'Email: ${delsp.email}',
//                         style: TextStyle(fontSize: 14), // Increased text size
//                       ),  
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     // Reduce spacing between To: and From:
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                         Text(
//                         'Reg no.: ${delsp.Regno}',
//                         style: TextStyle(fontSize: 14), // Increased text size
//                       ),                     
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
// }