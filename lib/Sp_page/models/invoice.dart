// model used by the card stored as invoice

import 'package:bms_sample/Sp_page/my_invoice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Invoice {
  final String tripNo;
  final String from;
  final String to;
  final int totalTickets;
  final int remainingTickets;
  final double price;
  final DateTime date;
  final String id;

  Invoice({
    required this.tripNo,
    required this.from,
    required this.to,
    required this.totalTickets,
    required this.remainingTickets,
    required this.price,
    required this.date,
    this.id = '',
  });

  factory Invoice.fromMap(Map<String, dynamic> data) {
    return Invoice(
      tripNo: data['tripNo'] as String,
      from: data['from'] as String,
      to: data['to'] as String,
      totalTickets: data['totalTickets'] as int,
      remainingTickets: data['remainingTickets'] as int,
      price: data['price'] as double,
      date: (data['date'] as Timestamp).toDate(),
    );
  }

}
