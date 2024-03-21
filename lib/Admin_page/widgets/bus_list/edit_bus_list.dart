// widget file for the edit_bus.dart

import 'package:bms_sample/Admin_page/widgets/bus_list/bus_item.dart';
import 'package:bms_sample/Admin_page/models/bus.dart';
import 'package:flutter/material.dart';

class BusesList extends StatelessWidget {
  const BusesList({super.key, required this.buses, required this.onRemoveBus});

  final List<Bus> buses;
  final void Function(Bus bus) onRemoveBus;

  @override
  Widget build(BuildContext context) {
    // List views are scrollable
    // List view.builders are scrollable widgets that create data on the fly when user requires it to
    // save memory of the device
    return ListView.builder(
      itemCount: buses.length,
      itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(buses[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.85),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          onDismissed: (direction) {
            onRemoveBus(buses[index]);
          },
          child: BusItem(buses[index])),
    );
  }
}
