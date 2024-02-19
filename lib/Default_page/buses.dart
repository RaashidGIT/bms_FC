import 'package:bms_sample/Admin_page/edit_bus.dart';
import 'package:bms_sample/Default_page/about.dart';
import 'package:bms_sample/Default_page/help.dart';
import 'package:bms_sample/Default_page/my_location_map.dart';
import 'package:bms_sample/Default_page/splash.dart';
import 'package:bms_sample/Sp_page/my_bus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bms_sample/login_page/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bms_sample/models/bus.dart';
class Buses extends StatefulWidget {
  Buses({
    super.key,
    required this.onSelectScreen,
  });

  final String onSelectScreen;
  

  @override
  State<Buses> createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  bool _noBusFound = false; // Variable to track if no bus is found
  bool _isLoading = false; // Track if the search is in progress

  final _firestore = FirebaseFirestore.instance; // Initialize here
  

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Bus Schedule',
      style: optionStyle,
    ),
    Text(
      'Index 1: Map',
    ),
    Text(
      'Index 2: About',
      style: optionStyle,
    ),
    Text(
      'Index 3: Help',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Management System'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              // Implement account icon button logic here
              Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (context) => const AuthScreen(),
                  builder: (context) => StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SplashScreen();
                        }

                        if (snapshot.hasData &&
                            AdminEmail == false &&
                            AdminPass == false) {
                          return const MyBus();
                          // to make two different routes.
                        }
                        if (snapshot.hasData &&
                            AdminEmail == true &&
                            AdminPass == true) {
                          return const AdminPage();
                        }
                        return const AuthScreen();
                      }),
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
                        // enableSuggestions: AutofillHints.,
                        controller: _fromController,
                        // Other TextFormField properties here
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 6),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'To'),
                        // enableSuggestions: AutofillHints.,
                        controller: _toController,
                        // Other TextFormField properties here
                      ),
                    ),

                    _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(),

                    _noBusFound
                    ? Center(
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
                          // Handle button press logic here
                            // Get values from the TextFields
                            String from = _fromController.text;
                            String to = _toController.text;

                            if (from.isEmpty || to.isEmpty) {
                          // Use ScaffoldMessenger to show Snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter both origin and destination.'),
                            ),
                          );
                          return;
                        }

                             setState(() {
                              _isLoading = true;
                              _noBusFound = false; // Reset on every search
                            });
                            // Perform the Firestore query
                            QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
                                .collection('Bus')
                                .where('route_AB', isEqualTo: from)
                                .where('route_BA', isEqualTo: to)
                                .get();

                            setState(() {
                          _isLoading = false;
                            if (snapshot.docs.isNotEmpty) {
                              // Handle found buses here
                              print('Bus found');
                            // Replace with actual bus data from snapshot
                          Bus bus = Bus(
                            bus_name: "Sample Bus Name",
                            bustype: Bustype.Ordinary, // Assuming "Ac" is a valid Bustype
                            route_AB: "Starting Point",
                            route_BA: "Ending Point",
                            // time_AB: DateTime.now(), // Assuming time_AB is a DateTime
                          );

                          // Display bus card
                              showBusCard(context, bus);
                            } else {
                              _noBusFound = true;
                            }
                          });
                            // Handle the query results
                                if (snapshot.docs.isNotEmpty) {
                                  // Found buses matching the route
                                  for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
                                    Bus bus = Bus.fromMap(doc.data());
                                    // Process the bus data here, e.g., display it on the screen
                                  }
                                } else {
                                  // No buses found for the route
                                  print('No buses found for route $from - $to');
                                  setState(() {
                                    _noBusFound = true; // Set the flag to true
                                  });

                                  Future.delayed(const Duration(seconds: 3), () {
                                    setState(() {
                                      _noBusFound = false;
                                    });
                                  });
                                }

                          // Build the ListView with the data
                          // _buildListView(from, to);
                        },
                        child: Text('Find Bus'),
                        style: ElevatedButton.styleFrom(
                          // Change the background color to green
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
          // Important: Remove any padding from the ListView.
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
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    'Bus Management System',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 17,
                        ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.access_time,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Bus Schedule',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 18,
                    ),
              ),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // _widgetOptions;
                // Then close the drawer
                Navigator.pop(context);
              },
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
          ],
        ),
      ),
    );
  }

  void showBusCard(BuildContext context, Bus bus) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bus.bus_name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'To: ${bus.route_BA}',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 5),
                        // Assuming last element of time_AB represents latest departure time
                        // Text(
                        //   DateFormat('h:mm a').format(bus.time_AB.last),
                        //   style: TextStyle(fontSize: 14),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'From: ${bus.route_AB}',
                          style: TextStyle(fontSize: 14),
                        ),
                        // Replace with actual track logic and button design
                        ElevatedButton(
                          onPressed: () => print('Track button pressed!'),
                          child: Text('Track'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
