import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, double>> fetchLatLon(String Regno) async {
  Map<String, double> location = {'latitude': 0.0, 'longitude': 0.0};

  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
      .collection('SPusers')
      .where('Regno', isEqualTo: Regno)
      .get();

  if (snapshot.docs.isNotEmpty) {
    DocumentSnapshot<Map<String, dynamic>> userDoc = snapshot.docs.first;
    if (userDoc.data()?.containsKey('latitude') == true && userDoc.data()?.containsKey('longitude') == true) {
      location['latitude'] = userDoc.data()!['latitude'];
      location['longitude'] = userDoc.data()!['longitude'];
    } else {
      print('Document for user ID: $Regno does not have "latitude" or "longitude" field(s)');
    }
  } else {
    print('No document found for user ID: $Regno');
  }

  return location;
}