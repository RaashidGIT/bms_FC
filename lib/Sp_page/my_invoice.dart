import 'package:flutter/material.dart';
import 'package:bms_sample/Sp_page/models/invoice.dart';
import 'package:intl/intl.dart'; // Include this import to properly format date

class MyInvoiceScreen extends StatefulWidget {
  const MyInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<MyInvoiceScreen> createState() => _MyInvoiceScreenState();
}

class _MyInvoiceScreenState extends State<MyInvoiceScreen> {
  List<Invoice> invoices = [];
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            // Temporarily remove the invoice
            final dismissedInvoice = invoices.removeAt(index);

            // Show a Snackbar with undo button
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Invoice deleted'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Add the invoice back to the list
                    setState(() {
                      invoices.insert(index, dismissedInvoice);
                    });
                  },
                ),
              ),
            );
          },
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: Card(
            child: SingleChildScrollView(
            child: ListTile(
              title: Text("Trip No: ${invoices[index].tripNo}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date: ${DateFormat.yMd().format(invoices[index].date)}"), // Added date display
                  Text("From: ${invoices[index].from} - To: ${invoices[index].to}"),
                  Text("Income: ${(invoices[index].totalTickets - invoices[index].remainingTickets) * invoices[index].price}"),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {},
              ),
            ),
            ),
          ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddInvoiceDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddInvoiceDialog() {
    String tripNo = "";
    String from = "";
    String to = "";
    int totalTickets = 0;
    int remainingTickets = 0;
    double price = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Invoice"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Trip No'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => tripNo = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'From'),
                  onChanged: (value) => from = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'To'),
                  onChanged: (value) => to = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Total Tickets'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => totalTickets = int.tryParse(value) ?? 0,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Remaining Tickets'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => remainingTickets = int.tryParse(value) ?? 0,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => price = double.tryParse(value) ?? 0.0,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (tripNo.isNotEmpty &&
                    from.isNotEmpty &&
                    to.isNotEmpty &&
                    totalTickets > 0 &&
                    remainingTickets >= 0 &&
                    remainingTickets <= totalTickets &&
                    price > 0.0) {
                  setState(() {
                    invoices.add(Invoice(
                      tripNo: tripNo,
                      from: from,
                      to: to,
                      totalTickets: totalTickets,
                      remainingTickets: remainingTickets,
                      price: price,
                      date: selectedDate,
                    ));
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all fields correctly.'),
                    ),
                  );
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}