import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bms_sample/Admin_page/sp_image_picker.dart';

class DelSpScreen extends StatefulWidget {
  const DelSpScreen({super.key});

  @override
  State<DelSpScreen> createState() {
    return _AdminAuthScreenState();
  }
}

class _AdminAuthScreenState extends State<DelSpScreen> {
  final _form = GlobalKey<FormState>();

  Future<void> getSPusersData() async {
    // Get a reference to the SPusers collection
    final collection = FirebaseFirestore.instance.collection('SPusers');

    // Fetch all documents (adjust query as needed)
    final querySnapshot = await collection.get();

    // Process each document
    for (final document in querySnapshot.docs) {
      final data = document.data();
      final rgno = data['Rgno'];
      final busRef = data['bus_ref'];
      // ... extract other fields

      // Display or use the retrieved data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete existing bus'),
      ),
      // Set backgroundColor to your preference (optional)
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Hi",
          style: TextStyle(
            fontSize: 30, // Adjust font size as desired
            fontWeight: FontWeight.bold, // Optional
            color: Colors.black, // Change text color if needed
          ),
        ),
      ),
    );
  }
}
