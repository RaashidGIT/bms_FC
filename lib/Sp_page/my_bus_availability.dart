import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    String sourceDestination = "";
    String finalDestination = "";
    String route_AB = "";
    String route_BA = "";

  @override
  void initState() {
    super.initState();
    // Fetch data from Firestore here
    fetchBusData();
  }

  Future<void> fetchBusData() async {
  // Assuming a user identifier is available
  final userId = user!.uid;

  // Fetch SPuser data
  final spUserDocSnapshot = await FirebaseFirestore.instance
      .collection('SPusers')
      .doc(userId)
      .get();

  if (spUserDocSnapshot.exists) {
    // Get bus reference from SPuser document
    final busRef = spUserDocSnapshot.get('bus_ref');

    // Check if bus reference exists
    if (busRef != null) {
      // Fetch bus data
      final busDocSnapshot = await busRef.get();

      if (busDocSnapshot.exists) {
        // Update state with fetched data
        setState(() {
          busName = busDocSnapshot.get('bus_name');
          route_AB = busDocSnapshot.get('route_AB'); // assuming the field name is 'route_AB'
          route_BA = busDocSnapshot.get('route_BA');
          username = spUserDocSnapshot.get('username');
          email = spUserDocSnapshot.get('email');
          imageUrl = spUserDocSnapshot.get('image_url');
        });
      } else {
        // Handle case where bus document doesn't exist
        print('Bus document not found for bus_ref: $busRef');
      }
    } else {
      // Handle case where bus reference is missing in SPuser document
      print('Bus reference not found in SPuser document for user: $userId');
    }
  } else {
    // Handle case where SPuser document doesn't exist
    print('SPuser document not found for user: $userId');
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
                          Text(
                            'Bus Name: $busName',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20), // Increased gap
                          Text(
                            'Username: $username',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Email: $email',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Route A: $sourceDestination', // Replace with actual data
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Route B: $finalDestination', // Replace with actual data
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          // Text(
                          //   'Time A: {timeA}', // Replace with actual data
                          //   style: const TextStyle(fontSize: 20),
                          // ),
                          // const SizedBox(height: 20),
                          // Text(
                          //   'Time B: {timeB}', // Replace with actual data
                          //   style: const TextStyle(fontSize: 20),
                          // ),
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
              // ... other widgets for invoice page (if applicable)
            ],
          ),
          Positioned(
            bottom: 20, // Adjust offset as needed
            right: 20, // Adjust offset as needed
            child: Row(
              children: [
                Text(statusText, style: TextStyle(fontSize: 16, color: _isSelected ? Colors.green : Colors.red,)),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isSelected = !_isSelected;
                      availability = _isSelected; // Update availability based on _isSelected
                    });
                  },
                  child: Container(
                    width: 50, // Adjust width as needed
                    height: 50, // Adjust height as needed
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