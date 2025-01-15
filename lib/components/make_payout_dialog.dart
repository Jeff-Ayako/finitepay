import 'package:finitepay/components/beneficiary_payout_page.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/constants/constants_file.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PayoutDialogue extends StatefulWidget {
   PayoutDialogue({super.key,required this.width});
  double width;
  @override
  _PayoutDialogueState createState() => _PayoutDialogueState();
}

class _PayoutDialogueState extends State<PayoutDialogue> {
  String? selectedCurrency;
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Container(
          width: width<=500? width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Start a Payout',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[900],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      Get.back();
                      // Close the modal
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Select the Currency to Payout',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              Text(
                'Select Currency*',
                style: TextStyle(fontSize: 16, color: Colors.purple[900]),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple[900]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text(
                      'Choose a balance',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    value: selectedCurrency,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                    items: currenciesAvailable
                        .asMap()
                        .entries
                        .map(
                          (entry) => DropdownMenuItem(
                            onTap: () {
                              maincontroller.currencyIndex.value = entry.key;
                            },
                            value: entry.value,
                            child: Text(entry.value),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Amount*',
                style: TextStyle(fontSize: 16, color: Colors.purple[900]),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: 'Enter amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              Center(
                  child: Btn(
                txtColor: Colors.white,
                ontap: () {
                  if (double.parse(amountController.text) >
                      double.parse(currencyCloudController
                              .allMycurrencies
                              .value
                              ?.balances[maincontroller.currencyIndex.value]
                              .amount ??
                          '0.0')) {
                    Get.snackbar(
                        backgroundColor: Colors.amber,
                        'Error',
                        'Amount to be sent can\'t more than Your Currency Balance');
                  } else {
                    Get.to(
                      () =>  BeneficiaryPayOutPage(selectedCurrency:selectedCurrency.toString(), amount: amountController.text.toString(),),
                    );
                  }

                  // await FirebaseFirestore.instance
                  //     .collection('Balances')
                  //     .doc(fAuth.currentUser?.uid ?? '')
                  //     .collection('Wallets')
                  //     .doc(selectedCurrency)
                  //     .set({
                  //   'currency': selectedCurrency,
                  //   'amount': double.parse(currencyCloudController
                  //               .allMycurrencies
                  //               .value
                  //               ?.balances[maincontroller.currencyIndex.value]
                  //               .amount ??
                  //           '0.0') +
                  //       double.parse(
                  //         amountController.text,
                  //       ),
                  //   'updatedAt': DateTime.now(),
                  // }).then((value) {
                  //   Get.snackbar(
                  //       backgroundColor: Colors.green,
                  //       'Success',
                  //       ' $selectedCurrency Account Funded Successfully');
                  // }).then((v) {
                  //   // setState(() {
                  //   amountController.clear();
                  //   // selectedCurrency = '';
                  //   currencyCloudController.getBalances().then((v) {
                  //     currencyCloudController.allMycurrencies.refresh();
                  //   });
                  //   // });

                  //   // Get.back();
                  //   // Get.back();
                  // }).catchError((error) {
                  //   Get.snackbar(
                  //       backgroundColor: Colors.red, 'Error', error.toString());
                  // });
                },
                btnName: 'CONTINUE',
                color: const Color(0xFF5A31F4),
              )

                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Handle top-up logic
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: selectedCurrency != null &&
                  //             amountController.text.isNotEmpty
                  //         ? Colors.purple[300]
                  //         : Colors.purple[100],
                  //     minimumSize: Size(double.infinity, 50),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  //   child: Text(
                  //     'CONTINUE',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),

                  ),
            ],
          ),
        ),
      ),
    );
  }
}
