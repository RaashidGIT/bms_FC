// model used by the card stored as invoice

import 'package:bms_sample/Sp_page/my_invoice.dart';

class Invoice {
  final String tripNo;
  final String from;
  final String to;
  final int totalTickets;
  final int remainingTickets;
  final double price;
  final DateTime date;

  Invoice({
    required this.tripNo,
    required this.from,
    required this.to,
    required this.totalTickets,
    required this.remainingTickets,
    required this.price,
    required this.date,
  });
}
