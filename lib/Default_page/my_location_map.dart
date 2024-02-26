import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class MyLocationMap extends StatefulWidget {
  const MyLocationMap({Key? key}) : super(key: key);

  @override
  State<MyLocationMap> createState() => _MyLocationMapState();
}

class _MyLocationMapState extends State<MyLocationMap> {
  final String _title = 'My Location';
  latLng.LatLng? _userLocation;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      _determinePosition();
    } else {
      // Handle permission denied case
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permission denied'),
        ),
      );
    }
  }

  Future<void> _determinePosition() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _userLocation = latLng.LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      // Handle location error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while determining your location'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _userLocation != null
          ? FlutterMap(
              options: MapOptions(
                initialCenter: _userLocation!,
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://api.mapbox.com/styles/v1/raashidmap/clt2s6qi000ld01qz7remhmr1/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmFhc2hpZG1hcCIsImEiOiJjbHQycm16d2wxanlvMmlsb25kNml0M213In0.3sL2VMG5KDjM7wfgcpuVnQ",
                  additionalOptions: {
                    'accessToken': 'pk.eyJ1IjoicmFhc2hpZG1hcCIsImEiOiJjbHQycm16d2wxanlvMmlsb25kNml0M213In0.3sL2VMG5KDjM7wfgcpuVnQ',
                    'id': 'mapbox.mapbox-streets-v8',
                  },
                ),
                CurrentLocationLayer(),
                // MarkerLayer(
                //   markers: [
                //     Marker(
                //       width: 40.0,
                //       height: 40.0,
                //       point: _userLocation!,
                //       builder: (ctx) => const Icon(Icons.location_on, color: Colors.blue), // Define and use the 'builder' parameter
                //     ),
                //   ],
                // ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}