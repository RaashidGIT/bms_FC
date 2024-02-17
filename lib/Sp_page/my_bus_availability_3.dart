// import 'package:flutter/material.dart';

// class MyBusAvailability extends StatefulWidget {
//   const MyBusAvailability({super.key});

//   @override
//   State<MyBusAvailability> createState() => _MyBusAvailabilityState();
// }

// // Widget build(BuildContext context) {
// //   return Column(
// //     children: [
// //       Container(
// //         decoration: BoxDecoration(
// //           color: Colors.teal[50], // Light teal background
// //           borderRadius: BorderRadius.circular(15), // Circular border
// //           border: Border.all(color: Colors.teal, width: 3), // Teal border
// //         ),
// //         padding: const EdgeInsets.all(20),
// //         child: Row(
// //           children: [
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text('Bus Name: ${busName}'),
// //                   const SizedBox(height: 15),
// //                   Text('Username: ${username}'),
// //                   const SizedBox(height: 15),
// //                   Text('Email: ${email}'),
// //                   const SizedBox(height: 15),
// //                   Text('Source: ${sourceDestination}'),
// //                   const SizedBox(height: 15),
// //                   Text('Destination: ${finalDestination}'),
// //                   const SizedBox(height: 15),
// //                   Text('Time A: ${timeA}'),
// //                   const SizedBox(height: 15),
// //                   Text('Time B: ${timeB}'),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(width: 20), // Gap between text and image
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(10),
// //               child: Image.network(userImageUrl, width: 100, height: 100),
// //             ),
// //           ],
// //         ),
// //       ),
// //       // ... other widgets for invoice page
// //     ],
// //   );
// // }

// // class _MyBusAvailabilityState extends State<MyBusAvailability> {
// //   @override
// //   Widget build(BuildContext context) {
// //   return Column(
// //     children: [
// //       Container(
// //         decoration: BoxDecoration(
// //           color: Colors.teal[50], // Light teal background
// //           borderRadius: BorderRadius.circular(15), // Circular border
// //           border: Border.all(color: Colors.teal, width: 3), // Teal border
// //         ),
// //         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25), // Increased padding
// //         child: Row(
// //           children: [
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     'Bus Name: {busName}',
// //                     // 'Bus Name: ${busName}', Use $ for dynamic details
// //                     style: const TextStyle(fontSize: 20), // Increased font size
// //                   ),
// //                   const SizedBox(height: 20), // Increased gap
// //                   Text(
// //                     'Username: {username}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   Text(
// //                     'Email: {email}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   Text(
// //                     'Source: {sourceDestination}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   Text(
// //                     'Destination: {finalDestination}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   Text(
// //                     'Time A: {timeA}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   Text(
// //                     'Time B: {timeB}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(width: 20), // Gap between text and image
// //             Container(
// //               width: 100,
// //               height: 100,
// //               decoration: BoxDecoration(
// //                 border: Border.all(color: Colors.grey[300]!, width: 2), // Dummy image border
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //               child: Center(
// //                 child: Text(
// //                   "User Image",
// //                   style: TextStyle(fontSize: 12, color: Colors.grey[500]),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       // ... other widgets for invoice page
// //     ],
// //   );
// // }


// // class _MyBusAvailabilityState extends State<MyBusAvailability> {
// // bool _isSelected = false; // not always, CHANGE IT!

// // @override
// // Widget build(BuildContext context) {
// //   return Column(
// //     children: [
// //       Container(
// //         decoration: BoxDecoration(
// //           color: Colors.teal[50], // Light teal background
// //           borderRadius: BorderRadius.circular(15), // Circular border
// //           border: Border.all(color: Colors.teal, width: 3), // Teal border
// //         ),
// //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30), // Adjust padding
// //         margin: const EdgeInsets.all(20), // Add spacing between screen and frame
// //         child: Row(
// //           children: [
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     'Bus Name: {busName}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                   const SizedBox(height: 20), // Increased gap
// //                   Text(
// //                     'Username: {username}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   Text(
// //                     'Email: {email}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   Text(
// //                     'Source: {sourceDestination}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   Text(
// //                     'Destination: {finalDestination}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   Text(
// //                     'Time A: {timeA}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   Text(
// //                     'Time B: {timeB}',
// //                     style: const TextStyle(fontSize: 20),
// //                   ),
// //                   SizedBox(height: 20),
// //                     InkWell(
// //                       onTap: () {
// //                         setState(() {
// //                           _isSelected = !_isSelected;
// //                         });
// //                       },
// //                       child: Container(
// //                         padding: EdgeInsets.all(10),
// //                         decoration: BoxDecoration(
// //                           color: _isSelected ? Colors.red : Colors.green,
// //                           borderRadius: BorderRadius.circular(50),
// //                         ),
// //                         child: Icon(
// //                           _isSelected ? Icons.cancel : Icons.check,
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //                     ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(width: 20), // Gap between text and image
// //             Align(
// //               alignment: Alignment.topRight,
// //               child: Container(
// //                 width: 100,
// //                 height: 100,
// //                 decoration: BoxDecoration(
// //                   border: Border.all(color: Colors.grey[300]!, width: 2), // Dummy image border
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //                 child: Center(
// //                   child: Text(
// //                     "User Image",
// //                     style: TextStyle(fontSize: 12, color: Colors.grey[500]),
// //                   ),
// //                 ),
                
// //               ),
              
// //             ),
// //           ],
          
// //         ),
// //       ),
      
// //       // ... other widgets for invoice page
// //     ],
    
// //   );
// // }
// // }


// class _MyBusAvailabilityState extends State<MyBusAvailability> {
//   bool _isSelected = false;

//   String get statusText => _isSelected ? 'Online' : 'Offline';

//   @override
//   Widget build(BuildContext context) {
//     // Replace these with actual data fetching logic
//     String busName = "Example Bus 123"; // Placeholder bus name
//     String username = "user@example.com"; // Placeholder username
//     String email = "user@example.com"; // Placeholder email
//     // ... other data placeholders

//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.teal[50], // Light teal background
//                   borderRadius: BorderRadius.circular(15), // Circular border
//                   border: Border.all(color: Colors.teal, width: 3), // Teal border
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//                 margin: const EdgeInsets.all(20), // Adjust spacing as needed
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Bus Name: $busName',
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                           const SizedBox(height: 20), // Increased gap
//                           Text(
//                             'Username: $username',
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                           const SizedBox(height: 20),
//                           Text(
//                             'Email: $email',
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                           const SizedBox(height: 20),
//                           Text(
//                             'Source: {sourceDestination}', // Replace with actual data
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                           const SizedBox(height: 20),
//                           Text(
//                             'Destination: {finalDestination}', // Replace with actual data
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                           const SizedBox(height: 20),
//                           Text(
//                             'Time A: {timeA}', // Replace with actual data
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                           const SizedBox(height: 20),
//                           Text(
//                             'Time B: {timeB}', // Replace with actual data
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 20), // Gap between text and image
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: Container(
//                         width: 75,
//                         height: 75,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey[300]!, width: 2), // Dummy image border
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "User Image", // Replace with your image loading logic
//                             style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // ... other widgets for invoice page (if applicable)
//             ],
//           ),
//           Positioned(
//             bottom: 20, // Adjust offset as needed
//             right: 20, // Adjust offset as needed
//             child: Row(
//               children: [
//                 Text(statusText, style: TextStyle(fontSize: 16, color: _isSelected ? Colors.green : Colors.red,)),
//                 SizedBox(width: 10),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       _isSelected = !_isSelected;
//                     });
//                   },
//                   child: Container(
//                     width: 50, // Adjust width as needed
//                     height: 50, // Adjust height as needed
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: _isSelected ? Colors.red : Colors.green,
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     child: Icon(
//                       _isSelected ? Icons.cancel : Icons.check,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }