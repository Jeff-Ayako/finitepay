import 'package:flutter/material.dart';

class PayoutModel {
  String title;
  String subtitle;
  Icon icon;

  PayoutModel(
      {required this.subtitle, required this.icon, required this.title});
}

List<PayoutModel> payoutopts = [
  PayoutModel(icon:const Icon(Icons.account_balance  ) , subtitle: 'Send Money to any Bank Account', title: 'Bank Tranfer'),
  PayoutModel(icon:const Icon(Icons.receipt  ) , subtitle: 'Buy Airtime or Paybills', title: 'Pay a Bill'),
  PayoutModel(icon:const Icon(Icons.payment  ) , subtitle: 'Cash Pick Up', title: 'Bank Tranfer'),
  PayoutModel(icon:const Icon(Icons.mobile_friendly  ) , subtitle: 'Mobile Money', title: 'Send Through Mobile Money'),
  PayoutModel(icon:const Icon(Icons.face  ) , subtitle: 'Finitepay Transfer', title: 'Send to another finitepay Account'),
  // PayoutModel(icon:const Icon(Icons.account_balance  ) , subtitle: 'Send Money to any Bank Account', title: 'Bank Tranfer'),
];
