import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/views/authenication/create_account_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTransfer extends StatelessWidget {
  const CreateTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Funds'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width / 3),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                txtForm(
                  'Currency',
                  maincontroller.currencyController,
                  (value) => (value!.trim().isEmpty)
                      ? "Currency is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Currency Name"
                          : null,
                ),
                txtForm(
                  'Source ID',
                  maincontroller.sourceAccount,
                  (value) => (value!.trim().isEmpty)
                      ? "Source ID is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Source ID"
                          : null,
                ),
                txtForm(
                  'Destination Account ID',
                  maincontroller.destinationAccount,
                  (value) => (value!.trim().isEmpty)
                      ? "Destination Account ID is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Destination Account ID"
                          : null,
                ),
                txtForm(
                  'Reason',
                  maincontroller.reason,
                  (value) => (value!.trim().isEmpty)
                      ? "Reason is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Reason"
                          : null,
                ),
                txtForm(
                  'Amount',
                  maincontroller.amountTransfer,
                  (value) => (value!.trim().isEmpty)
                      ? "Amount is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Amount"
                          : null,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {},
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 54, 73, 244)),
                      onPressed: () {},
                      child: const Text(
                        'Proceed',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
