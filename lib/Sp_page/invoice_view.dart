// import 'package:bms_sample/Sp_page/models/invoice.dart';
// import 'package:flutter/material.dart';

// class InvoiceView extends StatelessWidget {
//   const InvoiceView(
//       {super.key,
//       required this.invoice,
//       required this.index,
//       required this.onInvoiceDeleted});

//   final Invoice invoice;
//   final int index;

//   final Function(int) onInvoiceDeleted;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Invoice View'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: const Text('Delete This ?'),
//                       content:
//                           Text('Invoice ${invoice.title} will be deleted!'),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             onInvoiceDeleted(index);
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text('DELETE'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text('CANCEL'),
//                         ),
//                       ],
//                     );
//                   });
//             },
//             icon: Icon(Icons.delete),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               invoice.title,
//               style: const TextStyle(
//                 fontSize: 26,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(
//               invoice.body,
//               style: const TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
