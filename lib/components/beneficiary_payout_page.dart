import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/beneficiary/beneficiary_page.dart';
import 'package:finitepay/components/drop_down_btn.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/currency_cloud_api_requests.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_data.dart';
import 'package:finitepay/global/global_variables.dart';
// import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/views/authenication/create_account_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BeneficiaryPayOutPage extends StatelessWidget {
  BeneficiaryPayOutPage(
      {super.key, required this.selectedCurrency, required this.amount});

  String selectedCurrency;

  String amount;

  @override
  Widget build(BuildContext context) {
    CurrencyCloudController xurrencyCloudController =
        Get.put(CurrencyCloudController());
    // xurrencyCloudController.createBeneficiaryFunction();
    return Scaffold(
      appBar: AppBar(
        title:
            // Obx(
            //   () =>
            const Text(
          'Beneficiary Details',
        ),
      ),
      // ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: BeneficiaryPage(
              ispay: true,
            ),
          ),
          Expanded(
            flex: 1,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    txtForm(
                      'Beneficiary  Nickname',
                      maincontroller.beneficiaryNickName,
                      (value) => (value!.trim().isEmpty)
                          ? "Beneficiary  Nickname is required"
                          : (value.trim().length < 2)
                              ? "Enter a valid Beneficiary  Nickname "
                              : null,
                    ),
                    updatedDropDown(
                        controller: maincontroller.beneficiaryCountry,
                        items: countries,
                        hintTxt: 'Beneficiary Country'),
                    updatedDropDown(
                        controller: maincontroller.bankcountryController,
                        items: countries,
                        hintTxt: 'Bank Country'),
                    updatedDropDown(
                        controller: maincontroller.currencyController,
                        items: currenciesAvailable,
                        hintTxt: 'Select Currency'),
                    txtForm(
                      'Bank Account Holder Name',
                      maincontroller.accountNameHolderController,
                      (value) => (value!.trim().isEmpty)
                          ? "Bank Account Holder Name is required"
                          : (value.trim().length < 2)
                              ? "Enter a valid Bank Account Holder Name"
                              : null,
                    ),
                    updatedDropDown(
                      controller: maincontroller.beneficiaryTypeController,
                      items: registrationOptions,
                      hintTxt: 'Beneficiary Type',
                    ),
                    txtForm(
                      'BIC/SWIFT',
                      maincontroller.bicSwiftController,
                      (value) => (value!.trim().isEmpty)
                          ? "BIC/SWIFT is required"
                          : (value.trim().length < 2)
                              ? "Enter a valid BIC/SWIFT"
                              : null,
                    ),
                    txtForm(
                      'Account Number',
                      maincontroller.accountNumber,
                      (value) => (value!.trim().isEmpty)
                          ? "Account Number is required"
                          : (value.trim().length < 2)
                              ? "Enter a valid Account Number"
                              : null,
                    ),
                    txtForm(
                      'First Name',
                      maincontroller.firstNameController,
                      (value) => (value!.trim().isEmpty)
                          ? "First Name is required"
                          : (value.trim().length < 2)
                              ? "Enter a valid First Name"
                              : null,
                    ),
                    txtForm(
                      'Last Name',
                      maincontroller.lastNameController,
                      (value) => (value!.trim().isEmpty)
                          ? "Last Name is required"
                          : (value.trim().length < 2)
                              ? "Enter a valid Last Name"
                              : null,
                    ),
                    txtForm(
                      'Address',
                      maincontroller.addressController,
                      (value) => (value!.trim().isEmpty)
                          ? "Address is required"
                          : (value.trim().length < 2)
                              ? "Enter a valid Address"
                              : null,
                    ),
                    txtForm(
                      'City',
                      maincontroller.cityController,
                      (value) => (value!.trim().isEmpty)
                          ? "City is required"
                          : (value.trim().length < 2)
                              ? "Enter a valid City"
                              : null,
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ElevatedButton(
                        //   style:
                        //       ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        //   onPressed: () {},
                        //   child: const Text(
                        //     'Cancel',
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                        Btn(
                          txtColor: Colors.white,
                          ontap: () {
                            Get.back();
                          },
                          btnName: 'Cancel',
                          color: Colors.red,
                        ),

                        Btn(
                            txtColor: Colors.white,
                            ontap: () async {
                              await FirebaseFirestore.instance
                                  .collection('Transcations')
                                  .doc()
                                  .set({
                                'uid': fAuth.currentUser?.uid ?? '',
                                'email': fAuth.currentUser?.email ?? '',
                                'currency': selectedCurrency,
                                'beneficiaryName': maincontroller
                                    .accountNameHolderController.text,
                                'beneficiaryAccountNumber':
                                    maincontroller.accountNumber.text,
                                'amount': double.parse(currencyCloudController
                                            .allMycurrencies
                                            .value
                                            ?.balances[maincontroller
                                                .currencyIndex.value]
                                            .amount ??
                                        '0.0') +
                                    double.parse(
                                      amount,
                                    ),
                                'state': 'Test Mode',
                                'updatedAt': DateTime.now(),
                              }).then((value) async {
                                Get.snackbar(
                                    backgroundColor: Colors.green,
                                    'Success',
                                    ' $selectedCurrency Account Funded Successfully');

                                await FirebaseFirestore.instance
                                    .collection('Balances')
                                    .doc(fAuth.currentUser?.uid ?? '')
                                    .collection('Wallets')
                                    .doc(selectedCurrency)
                                    .set({
                                  'currency': selectedCurrency,
                                  'amount': double.parse(currencyCloudController
                                              .allMycurrencies
                                              .value
                                              ?.balances[maincontroller
                                                  .currencyIndex.value]
                                              .amount ??
                                          '0.0') -
                                      double.parse(
                                        amount,
                                      ),
                                  'updatedAt': DateTime.now(),
                                }).then((value) {
                                  Get.snackbar(
                                      backgroundColor: Colors.green,
                                      'Success',
                                      ' $selectedCurrency Account Funded Successfully');
                                }).then((v) {
                                  // setState(() {
                                  // amountController.clear();
                                  // selectedCurrency = '';
                                  currencyCloudController
                                      .getBalances()
                                      .then((v) {
                                    currencyCloudController.allMycurrencies
                                        .refresh();
                                  });
                                  // });

                                  // Get.back();
                                  // Get.back();
                                }).catchError((error) {
                                  Get.snackbar(
                                      backgroundColor: Colors.red,
                                      'Error',
                                      error.toString());
                                });
                              }).then((v) {
                                // setState(() {
                                // amountController.clear();
                                // selectedCurrency = '';
                                currencyCloudController.getBalances().then((v) {
                                  currencyCloudController.allMycurrencies
                                      .refresh();
                                });
                                // });

                                // Get.back();
                                // Get.back();
                              }).catchError((error) {
                                Get.snackbar(
                                    backgroundColor: Colors.red,
                                    'Error',
                                    error.toString());
                              });

                              // Get.back();
                            },
                            btnName: 'Pay Out',
                            color: const Color.fromARGB(255, 54, 73, 244)),

                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //       backgroundColor:
                        //           const Color.fromARGB(255, 54, 73, 244)),
                        //   onPressed: () {
                        //     xurrencyCloudController.createBeneficiaryFunction();

                        //     // Get.snackbar(
                        //     //   'Currency',
                        //     //   countryCodes[maincontroller.beneficiaryCountry.text]
                        //     //       .toString(),
                        //     // );
                        //   },
                        //   child: const Text(
                        //     'Proceed',
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
