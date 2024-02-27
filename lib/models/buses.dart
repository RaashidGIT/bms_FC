// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

// // Constants
// final Uuid uuid = Uuid();

// enum Busestype { Ordinary, SF, FP, mini }

// final BusestypeIcons = {
//   Busestype.Ordinary: Image.asset('assets/images/ordinary_black.png'),
//   Busestype.SF: Image.asset('assets/images/SF_black.png'),
//   Busestype.FP: Image.asset('assets/images/FP_black.png'),
//   Busestype.mini: Image.asset('assets/images/mini_black.png'),
// };

// class Buses {
//   final String id; // Unique identifier for each bus
//   final String buses_name;
//   final String route_A;
//   final String route_B;
//   final Busestype busestype;
//   // final String Regno;
//   final String time;

//   // Constructor to create a new Bus
//   Buses({
//     this.id = '',
//     required this.buses_name,
//     required this.route_A,
//     required this.route_B,
//     required this.busestype,
//     // required this.Regno,
//     required this.time,
//   });

//   // Constructor to create a Bus from a Firestore document
//   factory Buses.fromMap(Map<String, dynamic> data) {
//     // Handle potential errors here, e.g., check for required fields
//     // Check for 'id' and generate if missing
//   final String id = data['id'] as String? ?? uuid.v4();

//     return Buses(
//       id: id,
//       buses_name: data['bus_name'] as String,
//       route_A: data['route_AB'] as String,
//       route_B: data['route_BA'] as String,
//       // Regno: data['Regno'] as String,
//       busestype: Busestype.values.firstWhere((type) => type.toString() == data['bustype'], orElse: () => Busestype.SF),
//       time: data['time'] as String,
//     );
//   }

//   // Add other methods as needed...

//   @override
//   String toString() {
//     // return 'Buses(id: $id, bus_name: $buses_name, route_AB: $route_A, route_BA: $route_B, bustype: $busestype,)';
//     return 'Buses(id: $id, bus_name: $buses_name, route_AB: $route_A, route_BA: $route_B, bustype: $busestype, time: $time,)';
//   }
// }