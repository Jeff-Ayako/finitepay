import 'package:flutter/material.dart';

List<Widget> collectionGateways = [
  Card(
    color: const Color.fromARGB(255, 5, 84, 8),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/M-PESA.png'),
      ),
    ),
  ),
  Card(
    color: Colors.red,
    child: Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/airmoney.png',
          // fit: BoxFit.cover,
        ),
      ),
    ),
  ),
  Card(
    color: Colors.white,
    child: Center(
      child: Image.asset('assets/visa.png'),
    ),
  ),
  Card(
    // color: Colors.green,
    child: Center(
      child: Image.asset('assets/mastercard.png'),
    ),
  ),
  Card(
    color: const Color.fromARGB(255, 5, 31, 84),
    child: Center(
      child: Image.asset('assets/unionpay.png'),
    ),
  ),
];
