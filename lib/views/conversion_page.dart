import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/components/overrall_btn.dart';
// import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CurrencyConversionPage extends StatefulWidget {
  const CurrencyConversionPage({super.key});

  @override
  _CurrencyConversionPageState createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  String fromCurrency = 'USD';
  String toCurrency = 'KES';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      // appBar: AppBar(
      //   // backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () {
      //       // Handle back action
      //     },
      //   ),
      //   title: const Text(
      //     'Convert Currency',
      //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),

      body: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Convert between any available currency pairs',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 30),
                      // First dropdown and amount input
                      Obx(
                        () => buildCurrencyRow(
                            false,
                            0,
                            'I want to convert',
                            fromCurrency,
                            fxController.fromAmountController,
                            'Available Balance - ${currencyCloudController.allMycurrencies.value?.balances[maincontroller.currencyIndex.value].currency ?? 'KES'}: ${currencyCloudController.allMycurrencies.value?.balances[maincontroller.currencyIndex.value].amount ?? '0.0'}'),
                      ),
                      const SizedBox(height: 20),
                      // Second dropdown and amount input
                      buildCurrencyRow(true, 1, 'I want to receive', toCurrency,
                          fxController.toAmountController),
                      const SizedBox(height: 20),
                      Text(
                        'Conversions carried out in any E.A.T are settled after 24hrs.',
                        style:
                            TextStyle(color: Colors.purple[900], fontSize: 13),
                      ),
                      const Spacer(),
                      // Obx(
                      //   () => Text(
                      //     fxController.fxlistRates.toString(),
                      //   ),
                      // ),
                      Obx(
                        () => fxController.fxlistRates.value.isEmpty
                            ? Container()
                            : Text(
                                'Exchanging At: ${fxController.fxlistRates.value[0].toString()}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                      ),
                      Obx(
                        () => fxController.fxlistRates.value.isEmpty
                            ? Container()
                            : Text(
                                'Selling At: ${fxController.fxlistRates.value[1].toString()}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                      ),
                      Obx(
                        () => fxController.fxlistRates.value.isEmpty &&
                                fxController.fromAmountController.text.isEmpty
                            ? Container()
                            : Text(
                                'You Will Receive: ${double.parse(fxController.fromAmountController.text.toString()) * double.parse(fxController.fxlistRates.value[1].toString())}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: Get.width,
                    height: 60,
                    child: Btn(
                      ontap: () async {
                        if (fxController.fromAmountController.text.isEmpty &&
                            fxController.toAmountController.text.isEmpty) {
                          Get.snackbar(
                              backgroundColor: Colors.red,
                              'Error',
                              'Please Enter amount and currency to convert');
                        } else {
                          await FirebaseFirestore.instance
                              .collection('Balances')
                              .doc(fAuth.currentUser?.uid ?? '')
                              .collection('Wallets')
                              .doc(maincontroller.firstCurrency.value)
                              .set({
                            'currency': maincontroller.firstCurrency.value,
                            'amount': double.parse(currencyCloudController
                                        .allMycurrencies
                                        .value
                                        ?.balances[maincontroller
                                            .initialcurrencyIndex.value]
                                        .amount ??
                                    '0.0') -
                                double.parse(
                                    fxController.fromAmountController.text),
                            'updatedAt': DateTime.now(),
                          }).then((value) {
                            Get.snackbar(
                                backgroundColor: Colors.greenAccent,
                                'Success',
                                ' ${maincontroller.firstCurrency.value} Amount Detected successfully');
                          }).catchError((error) {
                            Get.snackbar(
                                backgroundColor: Colors.red,
                                'Error',
                                error.toString());
                          });

                          await FirebaseFirestore.instance
                              .collection('Balances')
                              .doc(fAuth.currentUser?.uid ?? '')
                              .collection('Wallets')
                              .doc(maincontroller.secondCurrency.value)
                              .set({
                            'currency': maincontroller.secondCurrency.value,
                            'amount': double.parse(fxController
                                    .fromAmountController.text
                                    .toString()) *
                                double.parse(fxController.fxlistRates.value[1]
                                    .toString()),
                            'updatedAt': DateTime.now(),
                          }).then((value) {
                            Get.snackbar(
                                backgroundColor: Colors.green,
                                'Success',
                                ' ${maincontroller.secondCurrency.value} Conversion Was Successful');
                          }).then((v) {
                            maincontroller.currentTabIndex.value = 1;
                            maincontroller.currentTabIndex.refresh();

                            successController.controllerBottomCenter.play();

                            currencyCloudController.getBalances().then((v) {
                              currencyCloudController.allMycurrencies.refresh();
                            });
                          }).catchError((error) {
                            Get.snackbar(
                                backgroundColor: Colors.red,
                                'Error',
                                error.toString());
                          });
                        }
                      },
                      txtColor: Colors.white,
                      btnName: 'Convert Now',
                      color: const Color(0xFF5A31F4),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Currency Row Widget
  Widget buildCurrencyRow(bool isEnabled, int index, String label,
      String currency, TextEditingController controller,
      [String? balance]) {
    // if (fromAmountController.text.toString().isEmpty) {
    // toAmountController.text =
    //     '${double.parse(fromAmountController.text.toString()) * double.parse(fxController.fxlistRates.value[1].toString())}';
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Currency Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: DropdownButton<String>(
                value: currency,
                items: currenciesAvailable
                    .asMap()
                    .entries
                    .map(
                      (entry) => DropdownMenuItem(
                        onTap: () {
                          if (index == 0) {
                            maincontroller.initialcurrencyIndex.value =
                                entry.key;
                          } else {
                            maincontroller.currencyIndex.value = entry.key;
                          }
                        },

                        value: entry.value,
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  width: Get.width,
                                  height: Get.height,
                                  fit: BoxFit.cover,
                                  imageUrl: flagsmap[entry.value],
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error_outline_outlined,
                                  ),
                                ),
                              ),

                              
                              
                              // Icon(Icons.monetization_on_outlined),
                            ),
                            // const Icon(Icons.monetization_on_outlined),
                            // Image.asset('assets/kenya_flag.png', width: 24), // Replace with correct flag image
                            const SizedBox(width: 8),
                            Text(entry.value),
                          ],
                        ),
                        // //Text(entry.value),
                      ),
                    )
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    currency = newValue!;
                    print(currency);
                  });
                  if (index == 1) {
                    maincontroller.secondCurrency.value = currency;
                    toCurrency = currency;
                    fxController.currencyPair.value =
                        '$fromCurrency$toCurrency'.trim();
                    print(
                      '$fromCurrency$toCurrency'.trim(),
                    );
                    fxController.getExchangeRates(
                      '$fromCurrency$toCurrency'.trim(),
                    );
                  } else if (index == 0) {
                    fromCurrency = currency;
                    maincontroller.firstCurrency.value = currency;
                  }
                  // print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2');

                  // print(
                  //     '${maincontroller.firstCurrency.value}${maincontroller.secondCurrency.value}'
                  //         .trim());
                },
                underline: const SizedBox(),
              ),
            ),
            const SizedBox(width: 12),
            // Amount Input Field
            Expanded(
              child: Obx(
                () => TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp("[0-9]"),
                    )
                  ],
                  // inputFormatters: [],
                  readOnly: isEnabled,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: fxController.fxlistRates.value.isEmpty
                        ? 'Enter Amount'
                        : '${double.parse(fxController.fromAmountController.text.toString()) * double.parse(fxController.fxlistRates.value[1].toString())}',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ],
        ),
        if (balance != null) ...[
          const SizedBox(height: 8),
          Text(
            balance,
            style: const TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );
  }
}
