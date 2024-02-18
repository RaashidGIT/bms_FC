// import 'package:flutter/material.dart';
// import 'package:bms_sample/Sp_page/models/invoice.dart';

// class CreateInvoice extends StatefulWidget {
//   const CreateInvoice({super.key, required this.onNewInvoiceCreated});

//   final Function(Invoice) onNewInvoiceCreated;

//   @override
//   State<CreateInvoice> createState() => _CreateInvoiceState();
// }

// class _CreateInvoiceState extends State<CreateInvoice> {
//   final titleController = TextEditingController();
//   final bodyController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('New Invoice'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: titleController,
//               style: const TextStyle(fontSize: 28),
//               decoration: const InputDecoration(
//                   border: InputBorder.none, hintText: "Title"),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             TextFormField(
//               controller: bodyController,
//               style: const TextStyle(fontSize: 18),
//               decoration: const InputDecoration(
//                   border: InputBorder.none, hintText: "Invoice Content"),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (titleController.text.isEmpty) {
//             return;
//           }
//           if (bodyController.text.isEmpty) {
//             return;
//           }

//           final invoice = Invoice(
//             body: bodyController.text,
//             title: titleController.text,
//           );

//           widget.onNewInvoiceCreated(invoice);
//           Navigator.of(context).pop();
//         },
//         child: const Icon(Icons.save),
//       ),
//     );
//   }
// }
