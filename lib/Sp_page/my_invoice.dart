import 'package:flutter/material.dart';
import 'package:bms_sample/Sp_page/models/invoice.dart';
import 'package:intl/intl.dart'; // Include this import to properly format date
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyInvoiceScreen extends StatefulWidget {
  const MyInvoiceScreen({super.key});

  @override
  State<MyInvoiceScreen> createState() => _MyInvoiceScreenState();
}

// MyFirestoreService.dart

class MyFirestoreService {
  static Future<void> addInvoice(String tripNo, String from, String to,
      int totalTickets, int remainingTickets, double price, DateTime selectedDate,) async {
    // Get the currently accessed user
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Get the user ID
      final userId = currentUser.uid;

      // Access the user's document in SPusers collection
      final docRef = FirebaseFirestore.instance.collection('SPusers').doc(userId);

       // Check for the existence of the "invoices" subcollection
      final hasInvoicesSubcollection =
          await docRef.collection('invoices').get().then((snapshot) => snapshot.docs.isNotEmpty);
          

       if (hasInvoicesSubcollection) {
        // Add invoice to the existing subcollection
        await docRef.collection('invoices').add({
          'tripNo': tripNo,
          'from': from,
          'to': to,
          'totalTickets': totalTickets,
          'remainingTickets': remainingTickets,
          'price': price,
          'date': selectedDate,
        });
      } else {
        // Create the "invoices" subcollection and add the first invoice
        await docRef.collection('invoices').add({
          'tripNo': tripNo,
          'from': from,
          'to': to,
          'totalTickets': totalTickets,
          'remainingTickets': remainingTickets,
          'price': price,
          'date': selectedDate,
        });
      }
    } else {
      // Handle the case where no user is signed in
      debugPrint('No user signed in, cannot add invoice to Firestore');
    }
  }

  static Future<void> deleteInvoice(String invoiceId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('SPusers')
          .doc(currentUser.uid)
          .collection('invoices')
          .doc(invoiceId)
          .delete();          
    } else {
      debugPrint('No user signed in, cannot delete invoice');
    }
  }
}


class _MyInvoiceScreenState extends State<MyInvoiceScreen> {
  List<Invoice> invoices = [];
  DateTime selectedDate = DateTime.now();
    // **Create an instance of FirebaseAuth**
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> _fetchInvoices() async {
    final user = auth.currentUser; // Use the created 'auth' instance
    if (user != null) {
      try {
        final invoiceRef = firestore.collection('SPusers').doc(user.uid).collection('invoices');
        final snapshot = await invoiceRef.orderBy('tripNo', descending: true).get();
        final fetchedInvoices = snapshot.docs
            .map((doc) => Invoice.fromMap(doc.data()))
            .toList();
        setState(() {
          invoices = fetchedInvoices;
        });
      } catch (error) {
        print('Error fetching invoices: $error');
      }
    } else {
      debugPrint('No user signed in, cannot fetch invoices');
    }
  }

  Future<void> _deleteInvoice(String invoiceId) async {
    try {
      await MyFirestoreService.deleteInvoice(invoiceId);
      setState(() {
        invoices.removeWhere((invoice) => invoice.id == invoiceId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invoice deleted successfully'),
        ),
      );
    } catch (error) {
      debugPrint('Error deleting invoice: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete invoice'),
        ),
      );
    }
  }

    @override
  void initState() {
    super.initState();
    _fetchInvoices();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: invoices.isEmpty
          ? Text("No invoices found.", style: TextStyle(fontSize: 18))
          : ListView.builder(
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    final dismissedInvoice = invoices.removeAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invoice deleted'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            setState(() {
                              invoices.insert(index, dismissedInvoice);
                            });
                          },
                        ),
                      ),
                    );
                    _deleteInvoice(dismissedInvoice.id);
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
                            Text("Date: ${DateFormat.yMd().format(invoices[index].date)}"),
                            Text("From: ${invoices[index].from} - To: ${invoices[index].to}"),
                            Text("Income: ${(invoices[index].totalTickets - invoices[index].remainingTickets) * invoices[index].price}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
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
    // DateTime selectedDate = ;

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
              onPressed: () async {
                if (tripNo.isNotEmpty &&
                    from.isNotEmpty &&
                    to.isNotEmpty &&
                    totalTickets > 0 &&
                    remainingTickets >= 0 &&
                    remainingTickets <= totalTickets &&
                    price > 0.0 ) {
                      // Call Firestore service to add data
                await MyFirestoreService.addInvoice(
                    tripNo, from, to, totalTickets, remainingTickets, price, selectedDate, );
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