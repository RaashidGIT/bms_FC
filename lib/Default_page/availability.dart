import 'package:cloud_firestore/cloud_firestore.dart';

class BusService {
  Future<bool> getAvailability(String regno) async {
    bool availability = false;
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('SPusers')
        .where('Regno', isEqualTo: regno)
        .get();
    
    if (snapshot.docs.isNotEmpty) {
      if (snapshot.docs.first.data().containsKey('availability')) {
        availability = snapshot.docs.first.get('availability');
      } else {
        print('Document with regno $regno does not have an "availability" field');
      }
    } else {
      print('No document found with regno $regno');
    }
    return availability;
  }
}