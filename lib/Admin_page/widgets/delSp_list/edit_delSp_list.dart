// // widget file for the del_sp.dart

// import 'package:bms_sample/Admin_page/widgets/delSp_list/del_sp_item.dart';
// import 'package:bms_sample/Admin_page/models/delSp.dart';
// import 'package:flutter/material.dart';

// class DelSpsList extends StatelessWidget {
//   const DelSpsList({super.key, required this.delsps, required this.onRemoveDelSp});

//   final List<DelSp> delsps;
//   final void Function(DelSp delsp) onRemoveDelSp;

//   @override
//   Widget build(BuildContext context) {
//     // List views are scrollable
//     // List view.builders are scrollable widgets that create data on the fly when user requires it to
//     // save memory of the device
//     return ListView.builder(
//       itemCount: delsps.length,
//       itemBuilder: (ctx, index) => Dismissible(
//           key: ValueKey(delsps[index]),
//           background: Container(
//             color: Theme.of(context).colorScheme.error.withOpacity(0.85),
//             margin: EdgeInsets.symmetric(horizontal: 16),
//           ),
//           onDismissed: (direction) {
//             onRemoveDelSp(delsps[index]);
//           },
//           child: DelSpItem(delsps[index])),
//     );
//   }
// }
