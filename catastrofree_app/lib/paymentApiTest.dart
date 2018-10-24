import 'package:flutter_billing/flutter_billing.dart';
import 'package:flutter/material.dart';

class PaymentWidget extends StatelessWidget {
  final Billing billing = new Billing();
  final List<BillingProduct> products = await billing.getProducts(
    <String>[
      'my.product.id',
      'my.other.product.id',
    ]
  );


  @override
  Widget build(BuildContext context) {
    
  }
}