import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TrackBusPage extends StatefulWidget {
  const TrackBusPage({Key? key}) : super(key: key);

  @override
  State<TrackBusPage> createState() => _TrackBusPageState();
}

class Zoom {
  static double getBoundsZoom(LatLngBounds bounds, double zoomFit) {
    return zoomFit * 1.5;
  }
}

class _TrackBusPageState extends State<TrackBusPage> {
  late List<LatLng> polylineCoordinates = [];
  late LatLng initialCenter = const LatLng(51.505, -0.09);
  late double initialZoom = 13.0;

  Future<List<LatLng>> _fetchRouteCoordinates() async {
    final snapshot = await FirebaseFirestore.instance.collection('SPusers').get();

    if (snapshot.docs.isNotEmpty) {
      final routeData = snapshot.docs.first.data() as Map<String, dynamic>;

      final routeACoordinates = _convertToCoordinates(routeData['RouteA']);
      final routeBCoordinates = _convertToCoordinates(routeData['RouteB']);

      polylineCoordinates = [
        for (final coordinate in routeACoordinates) LatLng(coordinate.latitude, coordinate.longitude),
        for (final coordinate in routeBCoordinates) LatLng(coordinate.latitude, coordinate.longitude)
      ];

      if (polylineCoordinates.isNotEmpty) {
        initialCenter = _calculateCenter(polylineCoordinates);
        initialZoom = _calculateZoom(polylineCoordinates);
      }
    }

    return polylineCoordinates;
  }

  List<LatLng> _convertToCoordinates(dynamic routeData) {
    List<LatLng> coordinates = [];

    if (routeData is List) {
      for (final item in routeData) {
        if (item['latitude'] != null && item['longitude'] != null) {
          coordinates.add(LatLng(item['latitude'], item['longitude']));
        }
      }
    }

    return coordinates;
  }

  LatLng _calculateCenter(List<LatLng> coordinates) {
    double minLat = double.infinity;
    double maxLat = -double.infinity;
    double minLng = double.infinity;
    double maxLng = -double.infinity;

    for (final coordinate in coordinates) {
      if (coordinate.latitude < minLat) minLat = coordinate.latitude;
      if (coordinate.latitude > maxLat) maxLat = coordinate.latitude;
      if (coordinate.longitude < minLng) minLng = coordinate.longitude;
      if (coordinate.longitude > maxLng) maxLng = coordinate.longitude;
    }

    return LatLng((minLat + maxLat) / 2, (minLng + maxLng) / 2);
  }

  double _calculateZoom(List<LatLng> coordinates) {
    const double paddingFactor = 1.1;
    final bounds = LatLngBounds.fromPoints(coordinates);

    double zoomLat = Distance().distance(bounds.southWest, bounds.northWest);
    double zoomLng = Distance().distance(bounds.southWest, bounds.southEast);

    double zoomFit = zoomLat > zoomLng ? zoomLat : zoomLng;

    return Zoom.getBoundsZoom(bounds, zoomFit * paddingFactor);
  }

  void resetMapPosition() {
    setState(() {
      initialCenter = _calculateCenter(polylineCoordinates);
      initialZoom = _calculateZoom(polylineCoordinates);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LatLng>>(
      future: _fetchRouteCoordinates(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final routeACoordinates = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Bus Location'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: initialCenter,
                      initialZoom: initialZoom,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://api.mapbox.com/styles/v1/raashidmap/clt2s6qi000ld01qz7remhmr1/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmFhc2hpZG1hcCIsImEiOiJjbHQycm16d2wxanlvMmlsb25kNml0M213In0.3sL2VMG5KDjM7wfgcpuVnQ",
                        additionalOptions: {
                          'accessToken':
                              'pk.eyJ1IjoicmFhc2hpZG1hcCIsImEiOiJjbHQycm16d2wxanlvMmlsb25kNml0M213In0.3sL2VMG5KDjM7wfgcpuVnQ',
                          'id': 'mapbox.mapbox-streets-v8',
                        },
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: routeACoordinates,
                            color: Colors.blue,
                            strokeWidth: 5.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: resetMapPosition,
              tooltip: 'Reset Map Position',
              child: Icon(Icons.location_searching),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
