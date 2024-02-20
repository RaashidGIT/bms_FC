// // widget file for the edit_bus.dart

// import 'package:bms_sample/Default_page/widgets/buses_list/buses_item.dart';
// import 'package:bms_sample/Admin_page/models/bus.dart';
// import 'package:flutter/material.dart';

// class BusesListes extends StatelessWidget {
//   const BusesListes({super.key, required this.buseses, required this.onRemoveBuses});

//   final List<Bus> buseses;
//   final void Function(Bus bus) onRemoveBuses;

//   @override
//   Widget build(BuildContext context) {
//     // List views are scrollable
//     // List view.builders are scrollable widgets that create data on the fly when user requires it to
//     // save memory of the device
//     return ListView.builder(
//       itemCount: buseses.length,
//       itemBuilder: (ctx, index) => Dismissible(
//           key: ValueKey(buseses[index]),
//           background: Container(
//             color: Theme.of(context).colorScheme.error.withOpacity(0.85),
//             margin: EdgeInsets.symmetric(horizontal: 16),
//           ),
//           onDismissed: (direction) {
//             onRemoveBuses(buseses[index]);
//           },
//           child: BusesItem(buseses[index])),
//     );
//   }
// }
