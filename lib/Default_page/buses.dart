import 'package:bms_sample/Admin_page/edit_bus.dart';
import 'package:bms_sample/Default_page/about.dart';
import 'package:bms_sample/Default_page/help.dart';
import 'package:bms_sample/Default_page/my_location_map.dart';
import 'package:bms_sample/Default_page/splash.dart';
import 'package:bms_sample/Default_page/track_bus.dart';
import 'package:bms_sample/Sp_page/my_bus.dart';
import 'package:bms_sample/Default_page/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bms_sample/Default_page/availability.dart';
import 'package:bms_sample/login_page/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bms_sample/Admin_page/models/bus.dart';

class Buses extends StatefulWidget {
  const Buses({Key? key, required this.onSelectScreen}) : super(key: key);
  final String onSelectScreen;

  @override
  State<Buses> createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  bool _noBusFound = false;
  bool _isLoading = false;
  final _firestore = FirebaseFirestore.instance;
  int _selectedIndex = 0;
  List<Bus> foundBuses = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NextBus'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SplashScreen();
                      }
                      if (snapshot.hasData &&
                          AdminEmail == false &&
                          AdminPass == false) {
                        return const MyBus();
                      }
                      if (snapshot.hasData &&
                          AdminEmail == true &&
                          AdminPass == true) {
                        return const AdminPage();
                      }
                      return const AuthScreen();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 156, 175, 173),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 6),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'From'),
                        controller: _fromController,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 6),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'To'),
                        controller: _toController,
                      ),
                    ),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(),
                    _noBusFound
                        ? const Center(
                            child: Text(
                              'No Bus found',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : SizedBox(),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                        onPressed: () async {
                          String from = _fromController.text;
                          String to = _toController.text;
                          if (from.isEmpty || to.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please enter both origin and destination.'),
                              ),
                            );
                            return;
                          }
                          setState(() {
                            _isLoading = true;
                            _noBusFound = false;
                             foundBuses.clear(); // Clear the list before adding new buses
                          });
                          QuerySnapshot<Map<String, dynamic>> snapshot =
                              await _firestore
                                  .collection('Bus')
                                  .where('route_AB', isEqualTo: from)
                                  .where('route_BA', isEqualTo: to)
                                  .get();
                          setState(() {
                            _isLoading = false;
                            if (snapshot.docs.isNotEmpty) {
                              for (QueryDocumentSnapshot<
                                  Map<String, dynamic>> doc in snapshot.docs) {
                                Bus bus = Bus.fromMap(doc);
                                foundBuses.add(bus);
                                print('Bus name: ${bus.bus_name}');
                                print('Bustype: ${bus.bustype}');
                                print('Route from: ${bus.route_AB}');
                                print('Route to: ${bus.route_BA}');
                                print('time: ${bus.time}');
                              }
                              showBusCard(context, foundBuses);
                            } else {
                              _noBusFound = true;
                            }
                          });
                        },
                        child: Text('Find Bus'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 8, 51, 9),
                          foregroundColor: Colors.teal[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.directions_bus,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    'NextBus',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 24,
                        ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.map_outlined,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Map',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 18,
                    ),
              ),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyLocationMap(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.help_outline_outlined,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Help',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 18,
                    ),
              ),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HelpPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'About',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 18,
                    ),
              ),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showBusCard(BuildContext context, List<Bus> buses) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Available Buses'),
      content: SingleChildScrollView(
        child: Column(
          children: buses.map((bus) => buildBusCard(context, bus)).toList(),
        ),
      ),
    ),
  );
}

Widget buildBusCard(BuildContext context, Bus bus) {
  return Card(
    margin: const EdgeInsets.all(8),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BustypeIcons[bus.bustype] ??
                      Image.asset('assets/images/default_bus.png'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            bus.bus_name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          '${bus.time}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('To: ${bus.route_BA}',
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text('From: ${bus.route_AB}',
                              style: const TextStyle(fontSize: 14)),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            Map<String, double> locationData =
                                await fetchLatLon(bus.Regno);
                            showDialog(
                              context: context,
                              builder: (context) => Center(
                                child: AlertDialog(
                                  title: const Text('Location Data'),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          'Latitude: ${locationData['latitude']}'),
                                      const SizedBox(height: 8),
                                      Text(
                                          'Longitude: ${locationData['longitude']}'),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TrackBusPage(
                                                      latitude: locationData[
                                                                  'latitude']
                                                              ?.toDouble() ??
                                                          0.0,
                                                      longitude: locationData[
                                                                  'longitude']
                                                              ?.toDouble() ??
                                                          0.0,
                                                    )));
                                      },
                                      child: const Text('Map'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Text('Track'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: FutureBuilder<bool>(
                            future: BusService().getAvailability(bus.Regno),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text('Availability: Loading...');
                              } else {
                                if (snapshot.hasData) {
                                  bool availability = snapshot.data!;
                                  return Text(
                                      'Availability: ${availability ? "Yes" : "No"}');
                                } else {
                                  return const Text(
                                      'Error: Availability data unavailable');
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
