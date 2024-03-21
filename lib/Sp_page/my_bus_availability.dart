import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:geolocator/geolocator.dart';

class MyBusAvailability extends StatefulWidget {
  const MyBusAvailability({super.key});

  @override
  State<MyBusAvailability> createState() => _MyBusAvailabilityState();
}
class _MyBusAvailabilityState extends State<MyBusAvailability> {
  bool _isSelected = false;
  bool availability = false;

  final user = FirebaseAuth.instance.currentUser; // Get current user

  String get statusText => _isSelected ? 'Online' : 'Offline';

  // Replace these with actual data fetching logic
    String busName = "";
    String username = "";
    String email = "";
    String imageUrl = "";
    String regNo = "";
    String route_A = "";
    String route_B = "";

    void startLocationUpdates() {
  Timer.periodic(Duration(minutes: 5), (timer) {
    updateLocation(true); // Update location every 5 minutes
  });
}

  @override
  void initState() {
    super.initState();
    // Fetch data from Firestore here
    fetchBusData();
    startLocationUpdates(); // Start periodic location updates
  }

  Future<void> fetchBusData() async {
  final userId = user!.uid;

  // Fetch SPuser data directly
  final spUserDocSnapshot = await FirebaseFirestore.instance
      .collection('SPusers')
      .doc(userId)
      .get();

  if (spUserDocSnapshot.exists) {
    setState(() {
      busName = spUserDocSnapshot.get('bus_name');
      route_A = spUserDocSnapshot.get('RouteA');
      route_B = spUserDocSnapshot.get('RouteB');
      regNo = spUserDocSnapshot.get('Regno');
      username = spUserDocSnapshot.get('username');
      email = spUserDocSnapshot.get('email');
      imageUrl = spUserDocSnapshot.get('image_url');
      // Update _isSelected based on availability field
      _isSelected = spUserDocSnapshot.get('availability') ?? false; // Default to offline if not found
    });
  } else {
    print('SPuser document not found for user: $userId');
  }
}

void showPermissionDeniedSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Permission Denied'),
    ),
  );
}

void updateLocation(bool available) async {
    if (available) {
      if (!await Geolocator.isLocationServiceEnabled()) {
      showPermissionDeniedSnackbar(context);
      return;
    }
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;

      FirebaseFirestore.instance
          .collection('SPusers')
          .doc(user!.uid)
          .update({
            'availability': available,
            'latitude': latitude, // Store latitude 
            'longitude': longitude, // Store longitude 
          });
    } else {
      FirebaseFirestore.instance
          .collection('SPusers')
          .doc(user!.uid)
          .update({
            'availability': available,
            'latitude': null, // Clear latitude data when not available
            'longitude': null, // Clear longitude data when not available
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.teal[50], // Light teal background
                  borderRadius: BorderRadius.circular(15), // Circular border
                  border: Border.all(color: Colors.teal, width: 3), // Teal border
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                margin: const EdgeInsets.all(20), // Adjust spacing as needed
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Bus Name: ',
                                  style: TextStyle(fontSize: 20, color: Colors.teal),
                                ),
                                TextSpan(
                                  text: busName,
                                  style: const TextStyle(fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20), // Increased gap
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Reg no.: ',
                                  style: TextStyle(fontSize: 20, color: Colors.teal),
                                ),
                                TextSpan(
                                  text: regNo,
                                  style: const TextStyle(fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Username: ',
                                  style: TextStyle(fontSize: 20, color: Colors.teal),
                                ),
                                TextSpan(
                                  text: username,
                                  style: const TextStyle(fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Email: ',
                                  style: TextStyle(fontSize: 20, color: Colors.teal),
                                ),
                                TextSpan(
                                  text: email,
                                  style: const TextStyle(fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Source : ',
                                  style: TextStyle(fontSize: 20, color: Colors.teal),
                                ),
                                TextSpan(
                                  text: route_A, 
                                  style: const TextStyle(fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Destination : ',
                                  style: TextStyle(fontSize: 20, color: Colors.teal),
                                ),
                                TextSpan(
                                  text: route_B, 
                                  style: const TextStyle(fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20), // Gap between text and image
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 100,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!, width: 2), // Dummy image border
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: imageUrl.isNotEmpty
                  ? CachedNetworkImage( // Use CachedNetworkImage for efficient loading
                      imageUrl: imageUrl,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : Center(
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
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Row(
              children: [
                Text(statusText, style: TextStyle(fontSize: 16, color: _isSelected ? Colors.green : Colors.red)),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isSelected = !_isSelected;
                      availability = _isSelected;
                      updateLocation(availability); // Call function to update location based on availability
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _isSelected ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      _isSelected ? Icons.cancel : Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}