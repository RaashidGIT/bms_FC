import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:bms_sample/Default_page/buses.dart';

var kLightTealColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 0, 156, 156), // Light teal seed color
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromRGBO(0, 53, 53, 1),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      theme: ThemeData.from(
        colorScheme: kLightTealColorScheme,
      ).copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor:
            kLightTealColorScheme.background, // Light teal background
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kLightTealColorScheme.surface,
          foregroundColor: kLightTealColorScheme.onSurface,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kLightTealColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kLightTealColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kLightTealColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        // ... other dark theme customizations
      ),
      themeMode: ThemeMode.system, //default
      debugShowCheckedModeBanner: false,
      home: const Buses(onSelectScreen: 'Bus Management System'),
    ),
  );
}
