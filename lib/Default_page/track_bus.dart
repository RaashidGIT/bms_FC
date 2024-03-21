import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class TrackBusPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  const TrackBusPage({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  _TrackBusPageState createState() => _TrackBusPageState();
}

class _TrackBusPageState extends State<TrackBusPage> {
  late latLng.LatLng initialCenter;

  @override
  void initState() {
    super.initState();
    initialCenter = latLng.LatLng(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Location'),
      ),
      body: Center(
        child: widget.latitude == 0.0 && widget.longitude == 0.0
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off_outlined, size: 50.0, color: Colors.grey),
                  SizedBox(height: 16.0),
                  Text(
                    'No location data available',
                    style: TextStyle(color: Colors.grey, fontSize: 18.0),
                  ),
                ],
              )
        : Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: initialCenter, // Use initialCenter for dynamic updates
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/raashidmap/clt2s6qi000ld01qz7remhmr1/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmFhc2hpZG1hcCIsImEiOiJjbHQycm16d2wxanlvMmlsb25kNml0M213In0.3sL2VMG5KDjM7wfgcpuVnQ',
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1IjoicmFhc2hpZG1hcCIsImEiOiJjbHQycm16d2wxanlvMmlsb25kNml0M213In0.3sL2VMG5KDjM7wfgcpuVnQ',
                    'id': 'mapbox.mapbox-streets-v8',
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      child: const Icon(Icons.location_on, size: 50.0, color: Colors.red,),
                      width: 80.0,
                      height: 80.0,
                      point: initialCenter,
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    initialCenter = latLng.LatLng(widget.latitude, widget.longitude);
                  });
                },
                child: const Icon(Icons.my_location_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
