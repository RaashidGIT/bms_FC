// ignore_for_file: unused_import

import 'package:bms_sample/Sp_page/create_invoice.dart';
import 'package:bms_sample/Sp_page/models/invoice.dart';
import 'package:bms_sample/Sp_page/widgets/Invoice_card.dart';
import 'package:flutter/material.dart';

// class MyInvoiceScreen extends StatefulWidget {
//   const MyInvoiceScreen({super.key});

//   @override
//   State<MyInvoiceScreen> createState() => _MyInvoiceScreenState();
// }

// class _MyInvoiceScreenState extends State<MyInvoiceScreen> {
//   List<Invoice> notes = List.empty(growable: true);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Invoice Management"),
//       ),
//       body: ListView.builder(
//         itemCount: notes.length,
//         itemBuilder: (context, index) {
//           return InvoiceCard(
//               invoice: invoices[index],
//               index: index,
//               onInvoiceDeleted: onInvoiceDeleted);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => CreateInvoice(
//                     onNewInvoiceCreated: onNewInvoiceCreated,
//                   )));
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   void onNewInvoiceCreated(Invoice invoice) {
//     invoices.add(invoice);
//     setState(() {});
//   }

//   void onInvoiceDeleted(int index) {
//     invoices.removeAt(index);
//     setState(() {});
//   }
// }
// The above code is not working for some reason. using the below code as a temperorary adjustment..

class MyInvoiceScreen extends StatelessWidget {
  const MyInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('Add Invoice')],
    );
  }
}
