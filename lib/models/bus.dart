import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = TimeOfDayFormat.h_colon_mm_space_a;

const uuid = Uuid();

enum Bustype { Ordinary, SF, FP, mini }

final BustypeIcons = {
  Bustype.Ordinary: Image.asset('assets/images/ordinary_black.png'),
  Bustype.SF: Image.asset('assets/images/SF_black.png'),
  Bustype.FP: Image.asset('assets/images/FP_black.png'),
  Bustype.mini: Image.asset('assets/images/mini_black.png'),
};

class Bus {
  Bus({
    required this.bus_name,
    required this.route_AB,
    required this.route_BA,
    // required this.time_AB,
    // required this.time_BA,
    // this.available = true,
    // required this.available,
    // // required this.currentLocation,
    // required this.email,
    // required this.password,
    // required this.bus_image,
    required this.bustype,
  }) : id = const Uuid().v4();

  final String id;
  final String bus_name;
  final String route_AB;
  // final List<String> route_AB;
  final String route_BA;
  // final List<String> route_BA;
  // final List<DateTime> time_AB;
  // final List<TimeOfDay> time_AB;
  // final List<DateTime> time_BA;
  // final List<TimeOfDay> time_BA;
  // final bool available;
  // GeoPoint currentLocation;
  // final String currentLocation;
  // final String email;
  // final String password;
  // File imageFile;
  // File bus_image;
  final Bustype bustype;

  // // Getter for formatted time strings with AM/PM
  // List<TimeOfDay> get formattedTimes => times
  //     .map((time) => time.format(context) + ' ' + time.period.toUpperCase())
  //     .toList();
}
