// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart' as latLng;

// class TrackBusPage extends StatelessWidget {
//   const TrackBusPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bus Location'), // Set your desired title here
//       ),
//       body: FlutterMap(
//         options: MapOptions(
//           initialCenter: latLng.LatLng(51.505, -0.09), // Center coordinates (latitude, longitude)
//           initialZoom: 13.0, // Initial zoom level
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: "https://api.mapbox.com/styles/v1/raashidmap/clt2s6qi000ld01qz7remhmr1/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmFhc2hpZG1hcCIsImEiOiJjbHQycm16d2wxanlvMmlsb25kNml0M213In0.3sL2VMG5KDjM7wfgcpuVnQ",
//             additionalOptions: {
//               'accessToken': 'pk.eyJ1IjoicmFhc2hpZG1hcCIsImEiOiJjbHQycm16d2wxanlvMmlsb25kNml0M213In0.3sL2VMG5KDjM7wfgcpuVnQ',
//               'id': 'mapbox.mapbox-streets-v8',
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }