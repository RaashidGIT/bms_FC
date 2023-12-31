import 'package:flutter/material.dart';

class MyLocationMap extends StatefulWidget {
  const MyLocationMap({super.key});

  @override
  State<MyLocationMap> createState() => _MyLocationMapState();
}

class _MyLocationMapState extends State<MyLocationMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My location'),
      ),
      body: const Center(
        child: Text('Your Location'),
      ),
    );
  }
}
