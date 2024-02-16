import 'package:bms_sample/Admin_page/add_sp.dart';
import 'package:bms_sample/Admin_page/edit_bus.dart';
import 'package:bms_sample/Default_page/about.dart';
import 'package:bms_sample/Default_page/help.dart';
import 'package:bms_sample/Default_page/my_location_map.dart';
import 'package:bms_sample/Default_page/splash.dart';
import 'package:bms_sample/Sp_page/my_bus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bms_sample/widgets/bus_list_builder.dart';
// import 'package:bms_2/login_page/login_page.dart';
import 'package:bms_sample/login_page/auth.dart';
import 'package:bms_sample/main.dart';

class Buses extends StatefulWidget {
  const Buses({
    super.key,
    required this.onSelectScreen,
  });

  final String onSelectScreen;

  @override
  State<Buses> createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  // void _setScreen(String identifier) async {
  //   Navigator.of(context).pop();
  //   if (identifier == 'filters') {
  //     await Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (ctx) => const DrawerItem(),
  //       ),
  //     );
  //   }
  // }

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
  ];

  // _buildListView(String from, String to) {
  //   return DecoratedBox(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: ListView.builder(
  //       padding: const EdgeInsets.all(24), // Margin around the box
  //       itemCount: 5, // Replace with your actual number of items
  //       itemBuilder: (context, index) {
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(
  //               vertical: 16), // Spacing between items
  //           child: Row(
  //             children: [
  //               const Icon(Icons.directions_bus), // Bus icon
  //               const SizedBox(width: 16),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text('Bus Name $index'),
  //                     Text('Destination $index'),
  //                   ],
  //                 ),
  //               ),
  //               Column(
  //                 children: [
  //                   const Text('10:30 AM'), // Replace with actual time logic
  //                   ElevatedButton(
  //                     onPressed: () {}, // Handle track button logic
  //                     child: const Text('Track'),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

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
                        // controller: _fromController,
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
                        // controller: _toController,
                        // Other TextFormField properties here
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle button press logic here

                          String from = _fromController.text;
                          String to = _toController.text;

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
}
