import 'package:flutter/material.dart';
import 'package:bms_sample/Sp_page/models/invoice.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyInvoiceScreen extends StatefulWidget {
  const MyInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<MyInvoiceScreen> createState() => _MyInvoiceScreenState();
}

class MyFirestoreService {
  static Future<String> addInvoice(
      String tripNo,
      String from,
      String to,
      int totalTickets,
      int remainingTickets,
      double price,
      DateTime selectedDate) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final userId = currentUser.uid;
      final docRef =
          FirebaseFirestore.instance.collection('SPusers').doc(userId);

      // Create a new invoice data map
      Map<String, dynamic> invoiceData = {
        'tripNo': tripNo,
        'from': from,
        'to': to,
        'totalTickets': totalTickets,
        'remainingTickets': remainingTickets,
        'price': price,
        'date': selectedDate,
      };

      final newDocRef = await docRef.collection('invoices').add(invoiceData);
      return newDocRef.id; // Return the ID of the newly added document
    } else {
      debugPrint('No user signed in, cannot add invoice to Firestore');
      return ''; // Return an empty string or handle error as needed
    }
  }

  static Future<void> deleteInvoice(String invoiceId) async {
    if (invoiceId.isNotEmpty) {
      // Ensure invoiceId is not empty
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        try {
          final docRef = FirebaseFirestore.instance
              .collection('SPusers')
              .doc(currentUser.uid)
              .collection('invoices')
              .doc(invoiceId);
          await docRef.delete();
        } catch (error) {
          print('Error deleting invoice: $error');
        }
      } else {
        debugPrint('No user signed in, cannot delete invoice');
      }
    } else {
      debugPrint('Invoice ID is empty, cannot delete invoice');
    }
  }
}

class _MyInvoiceScreenState extends State<MyInvoiceScreen> {
  List<Invoice> invoices = [];
  DateTime selectedDate = DateTime.now();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> _fetchInvoices() async {
    final user = auth.currentUser;
    if (user != null) {
      try {
        final invoiceRef = firestore
            .collection('SPusers')
            .doc(user.uid)
            .collection('invoices');
        final snapshot = await invoiceRef.get();
        final fetchedInvoices = snapshot.docs
            .map((doc) => Invoice.fromMap(doc.data(), doc.id))
            .where((invoice) =>
                invoice.date.year == selectedDate.year &&
                invoice.date.month == selectedDate.month &&
                invoice.date.day == selectedDate.day)
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
            ? const Text("No invoices found.", style: TextStyle(fontSize: 18))
            : ListView.builder(
                itemCount: invoices.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      final dismissedInvoice = invoices.removeAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invoice deleted'),
                        ),
                      );
                      MyFirestoreService.deleteInvoice(dismissedInvoice
                          .id); // Changed to MyFirestoreService.deleteInvoice
                    },
                    background: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(16),
                      child: const Icon(
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
                              Text(
                                  "Date: ${DateFormat.yMd().format(invoices[index].date)}"),
                              Text(
                                  "From: ${invoices[index].from} - To: ${invoices[index].to}"),
                              Text(
                                  "Income: ${(invoices[index].totalTickets - invoices[index].remainingTickets) * invoices[index].price}"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _showTotalIncomeDialog();
            },
            child: const Icon(Icons.attach_money),
            tooltip: 'Calculate Total Income',
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              ).then((pickedDate) {
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                  _fetchInvoices();
                }
              });
            },
            child: const Icon(Icons.tune),
            tooltip: 'Select Date',
          ),
          const SizedBox(width: 5),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _fetchInvoices();
              });
            },
            child: const Icon(Icons.refresh),
            tooltip: 'Reload',
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _showAddInvoiceDialog,
            child: const Icon(Icons.add),
            tooltip: 'Add Invoice',
          ),
        ],
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
          title: const Text("Add New Invoice"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Date'),
                  readOnly: true,
                  controller: TextEditingController(
                      text: DateFormat.yMd().format(selectedDate)),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((pickedDate) {
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    });
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Trip No'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => tripNo = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'From'),
                  onChanged: (value) => from = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'To'),
                  onChanged: (value) => to = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Total Tickets'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => totalTickets = int.tryParse(value) ?? 0,
                ),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Remaining Tickets'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      remainingTickets = int.tryParse(value) ?? 0,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Price'),
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
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (tripNo.isNotEmpty &&
                    from.isNotEmpty &&
                    to.isNotEmpty &&
                    totalTickets > 0 &&
                    remainingTickets >= 0 &&
                    remainingTickets <= totalTickets &&
                    price > 0.0) {
                  void _addInvoice() async {
                    // Call the addInvoice method and wait for it to complete
                    String newInvoiceId = await MyFirestoreService.addInvoice(
                        tripNo,
                        from,
                        to,
                        totalTickets,
                        remainingTickets,
                        price,
                        selectedDate);

                    // Once the addInvoice operation completes, update the state
                    setState(() {
                      invoices.add(Invoice(
                        tripNo: tripNo,
                        from: from,
                        to: to,
                        totalTickets: totalTickets,
                        remainingTickets: remainingTickets,
                        price: price,
                        date: selectedDate,
                        id: newInvoiceId, // Use the generated ID here
                      ));
                    });
                  }
                  // Call the _addInvoice function where needed
                  _addInvoice();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields correctly.'),
                    ),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showTotalIncomeDialog() async {
    double totalMonthIncome = 0.0;
    double totalSelectedDateIncome = 0.0;

    final user = auth.currentUser;
    if (user != null) {
      try {
        final invoiceRef = firestore
            .collection('SPusers')
            .doc(user.uid)
            .collection('invoices');
        final startOfMonth = DateTime(selectedDate.year, selectedDate.month);
        final endOfMonth =
            DateTime(selectedDate.year, selectedDate.month + 1, 0, 23, 59, 59);
        final snapshot = await invoiceRef
            .where('date',
                isGreaterThanOrEqualTo: startOfMonth,
                isLessThanOrEqualTo: endOfMonth)
            .get();

        for (var doc in snapshot.docs) {
          final invoice = Invoice.fromMap(doc.data(), doc.id);
          double income =
              (invoice.totalTickets - invoice.remainingTickets) * invoice.price;
          totalMonthIncome += income;
          if (invoice.date.year == selectedDate.year &&
              invoice.date.month == selectedDate.month &&
              invoice.date.day == selectedDate.day) {
            totalSelectedDateIncome += income;
          }
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Total Income"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "Total Income for ${DateFormat.yMd().format(selectedDate)}: $totalSelectedDateIncome"),
                  const SizedBox(height: 10),
                  Text(
                      "Total Income for ${DateFormat.yMMMM().format(selectedDate)}: $totalMonthIncome"),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      } catch (error) {
        print('Error fetching invoices: $error');
      }
    } else {
      debugPrint('No user signed in, cannot fetch invoices');
    }
  }
}
