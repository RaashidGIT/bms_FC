import 'package:flutter/material.dart';

class MyBusAvailability extends StatefulWidget {
  const MyBusAvailability({super.key});

  @override
  State<MyBusAvailability> createState() => _MyBusAvailabilityState();
}

// Widget build(BuildContext context) {
//   return Column(
//     children: [
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.teal[50], // Light teal background
//           borderRadius: BorderRadius.circular(15), // Circular border
//           border: Border.all(color: Colors.teal, width: 3), // Teal border
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Bus Name: ${busName}'),
//                   const SizedBox(height: 15),
//                   Text('Username: ${username}'),
//                   const SizedBox(height: 15),
//                   Text('Email: ${email}'),
//                   const SizedBox(height: 15),
//                   Text('Source: ${sourceDestination}'),
//                   const SizedBox(height: 15),
//                   Text('Destination: ${finalDestination}'),
//                   const SizedBox(height: 15),
//                   Text('Time A: ${timeA}'),
//                   const SizedBox(height: 15),
//                   Text('Time B: ${timeB}'),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 20), // Gap between text and image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(userImageUrl, width: 100, height: 100),
//             ),
//           ],
//         ),
//       ),
//       // ... other widgets for invoice page
//     ],
//   );
// }

// class _MyBusAvailabilityState extends State<MyBusAvailability> {
//   @override
//   Widget build(BuildContext context) {
//   return Column(
//     children: [
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.teal[50], // Light teal background
//           borderRadius: BorderRadius.circular(15), // Circular border
//           border: Border.all(color: Colors.teal, width: 3), // Teal border
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25), // Increased padding
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Bus Name: {busName}',
//                     // 'Bus Name: ${busName}', Use $ for dynamic details
//                     style: const TextStyle(fontSize: 20), // Increased font size
//                   ),
//                   const SizedBox(height: 20), // Increased gap
//                   Text(
//                     'Username: {username}',
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Email: {email}',
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Source: {sourceDestination}',
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Destination: {finalDestination}',
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Time A: {timeA}',
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Time B: {timeB}',
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 20), // Gap between text and image
//             Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey[300]!, width: 2), // Dummy image border
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Center(
//                 child: Text(
//                   "User Image",
//                   style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       // ... other widgets for invoice page
//     ],
//   );
// }


class _MyBusAvailabilityState extends State<MyBusAvailability> {
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.teal[50], // Light teal background
          borderRadius: BorderRadius.circular(15), // Circular border
          border: Border.all(color: Colors.teal, width: 3), // Teal border
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30), // Adjust padding
        margin: const EdgeInsets.all(20), // Add spacing between screen and frame
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bus Name: {busName}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20), // Increased gap
                  Text(
                    'Username: {username}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Email: {email}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Source: {sourceDestination}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Destination: {finalDestination}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Time A: {timeA}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Time B: {timeB}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20), // Gap between text and image
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 2), // Dummy image border
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "User Image",
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // ... other widgets for invoice page
    ],
  );
}
}
