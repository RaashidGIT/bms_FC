import 'package:flutter/material.dart';
import 'package:bms_sample/Sp_page/models/invoice.dart';
import 'package:bms_sample/Sp_page/invoice_view.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard(
      {super.key,
      required this.invoice,
      required this.onInvoiceDeleted,
      required this.index});

  final Invoice invoice;
  final int index;
  final Function(int) onInvoiceDeleted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InvoiceView(
                  invoice: invoice,
                  index: index,
                  onInvoiceDeleted: onInvoiceDeleted,
                )));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invoice.title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                invoice.body,
                style: const TextStyle(
                  fontSize: 20,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
