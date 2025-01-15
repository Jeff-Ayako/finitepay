import 'package:finitepay/controllers/init_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestTransactionsPage extends StatelessWidget {
  const TestTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: cardsController
                  .cardTransactions.value?.data.transactions.length ??
              0,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.monetization_on_outlined),
              ),
              title: Text(cardsController.cardTransactions.value?.data
                      .transactions[index].description ??
                  ''),
              subtitle: Text(cardsController.cardTransactions.value?.data
                      .transactions[index].enrichedData.transactionCategory ??
                  '-'),
              trailing: Text(cardsController.cardTransactions.value?.data
                      .transactions[index].amount ??
                  '-'),
            );
          },
        ),
      ),
    );
  }
}
