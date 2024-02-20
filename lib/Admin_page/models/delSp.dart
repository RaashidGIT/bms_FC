import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final Uuid uuid = Uuid();

class DelSp {
  final String id; // Unique identifier for each bus
  final String bus_name;
  final String email;
  final String username;
  final String Regno;

  // Constructor to create a new Bus
  DelSp({
    this.id = '',
    required this.bus_name,
    required this.email,
    required this.username,
    required this.Regno,
  });

  // Constructor to create a Bus from a Firestore document
  factory DelSp.fromMap(Map<String, dynamic> data) {
    // Handle potential errors here, e.g., check for required fields
    // Check for 'id' and generate if missing
  final String id = data['id'] as String? ?? uuid.v4();

    return DelSp(
      id: id,
      bus_name: data['bus_name'] as String,
      email: data['email'] as String,
      username: data['username'] as String,
      Regno: data['Regno'] as String,
    );
  }

  // Add other methods as needed...

  @override
  String toString() {
    return 'DelSp(id: $id, bus_name: $bus_name, email: $email, username: $username, Regno: $Regno,)';
  }
}