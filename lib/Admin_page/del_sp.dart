// // The first page admins see after loggin in

// // ignore_for_file: unused_import

// import 'package:bms_sample/Admin_page/del_sp.dart';
// import 'package:bms_sample/Admin_page/widgets/delSp_list/edit_delSp_list.dart';
// import 'package:bms_sample/Admin_page/widgets/delSp_list/del_sp_item.dart';
// import 'package:bms_sample/Admin_page/models/delSp.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DelSpPage extends StatefulWidget {
//   const DelSpPage({super.key});

//   @override
//   State<DelSpPage> createState() => _DelSpPageState();
// }

// class _DelSpPageState extends State<DelSpPage> {
//   final List<DelSp> _registeredDelSps = []; // Empty list to store fetched buses

  //  void _removeDelSp(DelSp delsp) async {
  //   final delspIndex = _registeredDelSps.indexOf(delsp);

  //   // UI update
  //   setState(() {
  //     _registeredDelSps.remove(delsp);
  //   });

  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       duration: const Duration(seconds: 3),
  //       content: const Text('Bus deleted.'),
  //       action: SnackBarAction(
  //         label: 'Undo',
  //         onPressed: () {
  //           setState(() {
  //             _registeredDelSps.insert(delspIndex, delsp);
  //           });
  //         },
  //       ),
  //     ),
  //   );

  //   // Delete from Firestore in the background
  // Future.delayed(const Duration(seconds: 3), () async {
  //   try {
  //     await FirebaseFirestore.instance.collection('SPusers').doc(delsp.id).delete();
  //     // Success message or visual cue if desired
  //   } catch (error) {
  //     // Handle errors gracefully (e.g., retry, log, show an error message)
  //     print(error);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error deleting bus: ${error.toString()}'),
  //         duration: const Duration(seconds: 5),
  //         action: SnackBarAction(
  //           label: 'Retry',
  //           onPressed: () => _removeDelSp(delsp), // Retry deletion on tap
  //         ),
  //       ),
  //     );
  //   }
  // });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   Widget mainContent = Center(
  //     child: Text('No buses to delete.'),
  //   );

    // if (_registeredDelSps.isNotEmpty) {
    //   mainContent = DelSpsList(
    //     delsps: _registeredDelSps,
    //     onRemoveDelSp: _removeDelSp,
    //   );
    // }

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Delete existing bus'),
    //   ),
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: FutureBuilder<QuerySnapshot>(
      //         future: FirebaseFirestore.instance.collection('SPusers').get(),
      //         builder: (context, snapshot) {
      //           if (snapshot.hasError) {
      //             return Center(child: Text('Error: ${snapshot.error}'));
      //           }
      //           if (snapshot.hasData) {
      //             _registeredDelSps.clear(); 
      //             for (var doc in snapshot.data!.docs) {
      //             _registeredDelSps.add(DelSp.fromMap(doc.data() as Map<String, dynamic>));
      //           }
      //             return DelSpsList(
      //               delsps: _registeredDelSps,
      //               onRemoveDelSp: _removeDelSp,
      //             );
      //           }
      //           return const Center(child: CircularProgressIndicator());
      //         },
      //       ),
      //     ),
      //   ],
      // ),
//     );
//   }
// }
