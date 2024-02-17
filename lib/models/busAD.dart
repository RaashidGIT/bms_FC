import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Constants
final Uuid uuid = Uuid();

enum Bustype { Ordinary, SF, FP, mini }

final BustypeIcons = {
  Bustype.Ordinary: Image.asset('assets/images/ordinary_black.png'),
  Bustype.SF: Image.asset('assets/images/SF_black.png'),
  Bustype.FP: Image.asset('assets/images/FP_black.png'),
  Bustype.mini: Image.asset('assets/images/mini_black.png'),
};

class Bus {
  final String id; // Unique identifier for each bus
  final String bus_name;
  final String route_AB;
  final String route_BA;
  final Bustype bustype;

  // Constructor to create a new Bus
  Bus({
    this.id = '',
    required this.bus_name,
    required this.route_AB,
    required this.route_BA,
    required this.bustype,
  });

  // Constructor to create a Bus from a Firestore document
  factory Bus.fromMap(Map<String, dynamic> data) {
    // Handle potential errors here, e.g., check for required fields
    // Check for 'id' and generate if missing
  final String id = data['id'] as String? ?? uuid.v4();

    return Bus(
      id: id,
      bus_name: data['bus_name'] as String,
      route_AB: data['route_AB'] as String,
      route_BA: data['route_BA'] as String,
      bustype: Bustype.values.firstWhere((type) => type.toString() == data['bustype'], orElse: () => Bustype.SF),
    );
  }

  // Add other methods as needed, e.g., to handle route calculations, timetables, etc.

  @override
  String toString() {
    return 'Bus(id: $id, bus_name: $bus_name, route_AB: $route_AB, route_BA: $route_BA, bustype: $bustype)';
  }
}