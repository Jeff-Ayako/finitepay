// import 'package:finitepay/cards/cards_payment.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PaymentStatusScreen extends StatefulWidget {
  final String transactionId;

  const PaymentStatusScreen({super.key, required this.transactionId});

  @override
  _PaymentStatusScreenState createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Status")),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('mpesaData')
            .doc(widget.transactionId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No payment data found."));
          }
          print(snapshot.data!.data());

          var paymentData = snapshot.data!.data() as Map<String, dynamic>;

          String status = paymentData['status'] ?? 'Unknown';

          return Center(
            child: paymentData.length < 7
                ? const Text('Please Wait..')
                : Center(
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        statusWidget(paymentData['Body']['stkCallback']
                                ["ResultDesc"] ??
                            'Wait')
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget statusWidget(String paymentResults) {
    return Column(
      children: [
        Lottie.asset(
            paymentResults == 'The service request is processed successfully.'
                ? "assets/payment_success.json"
                : "assets/payment_failed.json"),
        Text(
          paymentResults == 'The service request is processed successfully.'
              ? "Payment Was Successful"
              : paymentResults, //"${paymentData['Body']['stkCallback']["ResultDesc"] ?? 'Wait'}",
          style: const TextStyle(fontSize: 20),
        ),
        Btn(
          txtColor: Colors.white,
          ontap: () {
            if (paymentResults ==
                'The service request is processed successfully.') {
              // print(cardsController.cardAmountInCents.value.toString());
              cardsController.registerKenyaCardHolder();
            } else {
              Get.back();
            }
          },
          btnName:
              paymentResults == 'The service request is processed successfully.'
                  ? "Tap to Create Your Virtual Card"
                  : 'Try Again',
          color:
              paymentResults == 'The service request is processed successfully.'
                  ? const Color.fromARGB(255, 8, 130, 12)
                  : const Color.fromARGB(255, 184, 23, 12),
        )
      ],
    );
  }
}
