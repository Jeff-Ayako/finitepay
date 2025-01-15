import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/views/create_beneficiary_page.dart';
import 'package:finitepay/views/current_currency_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BeneficiaryPage extends StatelessWidget {
  BeneficiaryPage({super.key, this.ispay});

  bool? ispay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 500) {
          return BalanceWidget(
            screenSize: 500,
          );
        } else {
          return BalanceWidget(
            screenSize: 1000,
          );
        }
      },
    ));
  }
}

Widget buildBalancesTable(double screenSize) {
  return Obx(() {
    // currencyCloudController.beneficiaries.value == null
    //     ? const Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     :

    if (currencyCloudController.beneficiaries.value != null &&
        screenSize > 500) {
      return DataTable(
        columns: const [
          DataColumn(
            label: Text(
              '',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Name',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Currency',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Account No',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'State',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Bank',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // DataColumn(label: SizedBox()),
        ],
        rows: currencyCloudController.beneficiaries.value!.beneficiaries
            .asMap()
            .entries
            .map(
          (entry) {
            return DataRow(
              cells: [
                //  buildBalanceRow('USD', '1000001125090004', 'USD 0', 'USD 0', 'USD 0'),
                const DataCell(CircleAvatar(
                  child: Icon(Icons.person_outline_outlined),
                )),

                DataCell(
                  Text(
                    entry.value.bankAccountHolderName,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    entry.value.currency,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    entry.value.accountNumber,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    entry.value.beneficiaryCity,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    entry.value.bankName,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          },
        ).toList(),
      );
    } else if (currencyCloudController.beneficiaries.value != null &&
        screenSize <= 500) {
      return DataTable(
        columns: const [
          DataColumn(
            label: Text(
              '',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // DataColumn(label: Text('Balance ID')),
          DataColumn(
            label: Text(
              'Name',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // DataColumn(label: Text('Locked Balance')),
          // DataColumn(label: Text('Ledger Balance')),
          DataColumn(label: SizedBox()),
        ],
        rows: currencyCloudController.beneficiaries.value!.beneficiaries
            .asMap()
            .entries
            .map(
          (entry) {
            return DataRow(
              cells: [
                const DataCell(
                  CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
                DataCell(
                  Text(
                    entry.value.bankAccountHolderName,
                  ),
                ),
                DataCell(
                  Text(
                    entry.value.accountNumber,
                  ),
                ),
                // DataCell(
                //   ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color(0xFF5A31F4),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     child: const Text(
                //       "View",
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                //   // Btn(
                //   //   ontap: () {},
                //   //   btnName: 'VIEW DETAILS',
                //   //   color: const Color(0xFF5A31F4),
                //   //   txtColor: Colors.white,
                //   // ),
                // ),
              ],
            );
          },
        ).toList(),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  });
}

DataRow buildBalanceRow(String currency, String balanceId,
    String availableBalance, String lockedBalance, String ledgerBalance) {
  return DataRow(
    cells: [
      DataCell(Row(
        children: [
          const CircleAvatar(
            child: Icon(Icons.monetization_on_outlined),
          ),
          // Image.asset('assets/${currency.toLowerCase()}_flag.png', width: 30),
          const SizedBox(width: 10),
          Text(currency),
        ],
      )),
      DataCell(Text(balanceId)),
      DataCell(Text(availableBalance)),
      DataCell(Text(lockedBalance)),
      DataCell(Text(ledgerBalance)),
      DataCell(ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text("VIEW DETAILS"),
      )),
    ],
  );
}

// ignore: must_be_immutable
class BalanceWidget extends StatelessWidget {
  BalanceWidget({super.key, required this.screenSize});

  double screenSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Sidebar

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Get exclusive access to services that can help your business grow',
                          style: TextStyle(
                            color: Colors.purple,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text('Learn More',
                                style: TextStyle(color: Colors.purple)),
                            Icon(Icons.arrow_forward, color: Colors.purple),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Beneficiaries',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    screenSize <= 500
                        ? Container()
                        : Row(
                            children: [
                              Btn(
                                txtColor: Colors.white,
                                ontap: () {},
                                btnName: 'Delete Beneficiary',
                                color: Colors.red,
                              ),
                              const SizedBox(width: 10),
                              Btn(
                                txtColor: Colors.white,
                                ontap: () => Get.to(
                                  () => const CreateBeneficiaryPage(),
                                ),
                                btnName: 'Add Beneficiary',
                                color: const Color(0xFF5A31F4),
                              ),
                            ],
                          ),
                  ],
                ),
                const SizedBox(height: 20),
                screenSize <= 500
                    ? Row(
                        children: [
                          Btn(
                            txtColor: Colors.black,
                            ontap: () {},
                            btnName: 'Create New Balance',
                            color: Colors.transparent,
                          ),
                          const SizedBox(width: 10),
                          Btn(
                            txtColor: Colors.white,
                            ontap: () => Get.to(
                              () => const CurrentCurrencyPage(),
                            ),
                            btnName: 'Fund Balance',
                            color: const Color(0xFF5A31F4),
                          ),
                        ],
                      )
                    : Container(),
                DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        isScrollable: true,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                          color: const Color(0xFF5A31F4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tabs: const [
                          Tab(text: "  My Beneficiary  "),
                          Tab(text: "  Balance Funding History  "),
                          Tab(text: "  Generate Statement  "),
                        ],
                      ),
                      SizedBox(
                        height:
                            Get.height, // Adjust this height based on content
                        child: TabBarView(
                          children: [
                            // My Balances Tab
                            buildBalancesTable(screenSize),
                            // Balance Funding History Tab
                            const Center(
                                child: Text("Balance Funding History")),
                            // Generate Statement Tab
                            const Center(child: Text("Generate Statement")),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}









// import 'package:finitepay/components/overrall_btn.dart';
// import 'package:finitepay/controllers/init_controllers.dart';
// import 'package:finitepay/views/create_beneficiary_page.dart';
// // import 'package:finitepay/views/current_currency_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // ignore: must_be_immutable
// class BeneficiaryPage extends StatelessWidget {
//    BeneficiaryPage({super.key , this.ispay});

//   bool? ispay;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           // Sidebar

//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.purple[50],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Get exclusive access to services that can help your business grow',
//                           style: TextStyle(color: Colors.purple),
//                         ),
//                         TextButton(
//                           onPressed: () {},
//                           child: const Row(
//                             children: [
//                               Text('Learn More',
//                                   style: TextStyle(color: Colors.purple)),
//                               Icon(Icons.arrow_forward, color: Colors.purple),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Beneficiaries',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           // ElevatedButton(
//                           //   onPressed: () {},
//                           //   style: ElevatedButton.styleFrom(
//                           //     // primary: Colors.purple,
//                           //     shape: RoundedRectangleBorder(
//                           //       borderRadius: BorderRadius.circular(10),
//                           //     ),
//                           //   ),
//                           //   child: const Text("Create New Balance"),
//                           // ),
//                           Btn(
//                             txtColor: Colors.white,
//                             ontap: () {},
//                             btnName: 'Delete Beneficiaries',
//                             color: Colors.red,
//                           ),

//                           const SizedBox(width: 10),
//                           Btn(
//                             txtColor: Colors.white,
//                             ontap: () => Get.to(
//                               () => const CreateBeneficiaryPage(),
//                             ),
//                             btnName: 'Create Beneficiary',
//                             color: const Color(0xFF5A31F4),
//                           ),
//                           // ElevatedButton(
//                           //   onPressed: () {},
//                           //   style: ElevatedButton.styleFrom(
//                           //     // primary: Colors.purple,
//                           //     shape: RoundedRectangleBorder(
//                           //       borderRadius: BorderRadius.circular(10),
//                           //     ),
//                           //   ),
//                           //   child: const Text("Fund Balance"),
//                           // ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   DefaultTabController(
//                     length: 3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TabBar(
//                           labelColor: Colors.white,
//                           unselectedLabelColor: Colors.black,
//                           indicator: BoxDecoration(
//                             color: const Color(0xFF5A31F4),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           tabs: const [
//                             Tab(text: "  My Balances  "),
//                             Tab(text: "  Balance Funding History  "),
//                             Tab(text: "  Generate Statement  "),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 400, // Adjust this height based on content
//                           child: TabBarView(
//                             children: [
//                               // My Balances Tab
//                               buildBalancesTable(),
//                               // Balance Funding History Tab
//                               const Center(
//                                 child: Text(
//                                   "Balance Funding History",
//                                   style: TextStyle(
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ),
//                               // Generate Statement Tab
//                               const Center(
//                                 child: Text(
//                                   "Generate Statement",
//                                   style: TextStyle(
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildBalancesTable() {
//     return Obx(
//       () => currencyCloudController.beneficiaries.value == null
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : DataTable(
//               columns: const [
//                 DataColumn(
//                   label: Text(
//                     'Name',
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Type',
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Account No',
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'City',
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Country',
//                   ),
//                 ),
//                 DataColumn(
//                   label: SizedBox(),
//                 ),
//               ],
//               rows: currencyCloudController.beneficiaries.value!.beneficiaries
//                   .map((beneficiaries) {
//                 return DataRow(cells: [
//                   //  buildBalanceRow('USD', '1000001125090004', 'USD 0', 'USD 0', 'USD 0'),
//                   DataCell(Row(
//                     children: [
//                       const CircleAvatar(
//                         child: Icon(Icons.person_outline_outlined),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         beneficiaries.bankAccountHolderName,
//                         style: const TextStyle(
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   )),
//                   DataCell(
//                     Text(
//                       beneficiaries.beneficiaryEntityType.toString(),
//                       style: const TextStyle(
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ),
//                   DataCell(
//                     Text(
//                       beneficiaries.accountNumber,
//                       style: const TextStyle(
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ),
//                   DataCell(
//                     Text(
//                       beneficiaries.beneficiaryCity,
//                       style: const TextStyle(
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ),
//                   DataCell(
//                     Text(
//                       beneficiaries.beneficiaryCountry,
//                       style: const TextStyle(
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ),
//                   // DataCell(Text(transcations.amount)),
//                   DataCell(
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF5A31F4),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child:  Text(
//                       ispay==true?"Pay" :  "View",
//                         style: const TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     // Btn(
//                     //   ontap: () {},
//                     //   btnName: 'VIEW DETAILS',
//                     //   color: const Color(0xFF5A31F4),
//                     //   txtColor: Colors.white,
//                     // ),
//                   ),
//                   // ElevatedButton(
//                   //   onPressed: () {},
//                   //   style: ElevatedButton.styleFrom(
//                   //     backgroundColor: Colors.purple,
//                   //     shape: RoundedRectangleBorder(
//                   //       borderRadius: BorderRadius.circular(10),
//                   //     ),
//                   //   ),
//                   //   child: const Text("VIEW DETAILS"),
//                   // ),
//                   // ),
//                 ]);
//               }).toList(),
//               // [
//               //   buildBalanceRow('USD', '1000001125090004', 'USD 0', 'USD 0', 'USD 0'),
//               //   buildBalanceRow('GBP', '1000001125090002', 'GBP 0', 'GBP 0', 'GBP 0'),
//               //   buildBalanceRow('NGN', '1000001125090001', 'NGN 0', 'NGN 0', 'NGN 0'),
//               //   buildBalanceRow('EUR', '1000001125090003', 'EUR 0', 'EUR 0', 'EUR 0'),
//               //   buildBalanceRow('GHS', '1000001125090005', 'GHS 0', 'GHS 0', 'GHS 0'),
//               //   buildBalanceRow('KES', '1000001125090006', 'KES 0', 'KES 0', 'KES 0'),
//               //   buildBalanceRow('ZAR', '1000001125090007', 'ZAR 0', 'ZAR 0', 'ZAR 0'),
//               // ],
//             ),
//     );
//   }

//   DataRow buildBalanceRow(String currency, String balanceId,
//       String availableBalance, String lockedBalance, String ledgerBalance) {
//     return DataRow(
//       cells: [
//         DataCell(Row(
//           children: [
//             const CircleAvatar(
//               child: Icon(Icons.monetization_on_outlined),
//             ),
//             // Image.asset('assets/${currency.toLowerCase()}_flag.png', width: 30),
//             const SizedBox(width: 10),
//             Text(currency),
//           ],
//         )),
//         DataCell(Text(balanceId)),
//         DataCell(Text(availableBalance)),
//         DataCell(Text(lockedBalance)),
//         DataCell(Text(ledgerBalance)),
//         DataCell(ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.purple,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           child: const Text("VIEW DETAILS"),
//         )),
//       ],
//     );
//   }
// }




















// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:finitepay/cards/cards_payment.dart';
// // // import 'package:finitepay/controllers/init_controllers.dart';
// // import 'package:finitepay/global/collection_methods.dart';
// // // import 'package:finitepay/controllers/init_controllers.dart';
// // import 'package:finitepay/views/payments/MpesaSTKfun.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // // import 'package:flutter_paystack_max/flutter_paystack_max.dart';
// // import 'package:get/get.dart';
// // // import 'package:flutter_paystack/flutter_paystack.dart';

// // class TransactionsPage extends StatefulWidget {
// //   const TransactionsPage({super.key});

// //   @override
// //   State<TransactionsPage> createState() => _TransactionsPageState();
// // }

// // class _TransactionsPageState extends State<TransactionsPage> {
// //   // var publicKey = 'pk_live_2dcf1fd2bb9ad3d36a73f65b7491efd95c6c729f';
// //   // final plugin = PaystackPlugin();

// //   bool initializingPayment = false;

// //   // void makePayment() async {
// //   //   const secretKey = 'sk_live_1be4d6b8e05e6e44f5820a33adeb97c59261b190';

// //   //   final request = PaystackTransactionRequest(
// //   //     reference: 'ps_${DateTime.now().microsecondsSinceEpoch}',
// //   //     secretKey: secretKey,
// //   //     email: 'test@mail.com',
// //   //     amount: 15 * 100,
// //   //     currency: PaystackCurrency.usd,
// //   //     channel: [
// //   //       PaystackPaymentChannel.mobileMoney,
// //   //       PaystackPaymentChannel.card,
// //   //       PaystackPaymentChannel.ussd,
// //   //       PaystackPaymentChannel.bankTransfer,
// //   //       PaystackPaymentChannel.bank,
// //   //       PaystackPaymentChannel.qr,
// //   //       PaystackPaymentChannel.eft,
// //   //     ],
// //   //   );

// //   //   setState(() => initializingPayment = true);
// //   //   final initializedTransaction =
// //   //       await PaymentService.initializeTransaction(request);

// //   //   if (!mounted) return;
// //   //   setState(() => initializingPayment = false);

// //   //   if (!initializedTransaction.status) {
// //   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //   //       backgroundColor: Colors.red,
// //   //       content: Text(initializedTransaction.message),
// //   //     ));

// //   //     return;
// //   //   }

// //   //   await PaymentService.showPaymentModal(
// //   //     context,
// //   //     transaction: initializedTransaction,
// //   //     // Callback URL must match the one specified on your paystack dashboard,
// //   //     callbackUrl: '...',
// //   //   );

// //   //   final response = await PaymentService.verifyTransaction(
// //   //     paystackSecretKey: secretKey,
// //   //     initializedTransaction.data?.reference ?? request.reference,
// //   //   );

// //   //   if (kDebugMode) Logger().i(response.toMap());
// //   // }

// //   @override
// //   void initState() {
// //     // plugin.initialize(publicKey: publicKey);
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     double width = MediaQuery.of(context).size.width;
// //     double height = MediaQuery.of(context).size.height;
// //     // bool obsecure = true;
// //     // final auth = FirebaseAuth.instance;
// //     // BuildContext? loadingDialogContext;
// //     // UserDetails userDetails = UserDetails();

// //     var amountController = TextEditingController();
// //     BuildContext? loadingDialogContext;

// //     var phoneNumberController = TextEditingController();

// //     // var phoneController = TextEditingController();
// //     final formcontrollers = GlobalKey<FormState>();
// //     Future<void> showLoading(String message) {
// //       return showDialog(
// //         context: context,
// //         barrierDismissible: false,
// //         builder: (BuildContext context) {
// //           loadingDialogContext = context;
// //           return AlertDialog(
// //             content: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               children: [
// //                 const CircularProgressIndicator(
// //                   backgroundColor: Colors.greenAccent,
// //                 ),
// //                 Text(
// //                   message,
// //                   textAlign: TextAlign.center,
// //                   style: const TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 )
// //               ],
// //             ),
// //           );
// //         },
// //       );
// //     }

// //     return Scaffold(
// //       // appBar: AppBar(
// //       //   title: Text(
// //       //     authenticationController.userDetails.value.businessName.toString(),
// //       //     style: const TextStyle(
// //       //       color: Colors.black,
// //       //     ),
// //       //   ),
// //       // ),
// //       body: Column(
// //         children: [
// //           const Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Expanded(
// //                 // padding: EdgeInsets.all(8.0),
// //                 child: Center(
// //                     child: Text(
// //                   'Gateways',
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 20,
// //                   ),
// //                 )),
// //               ),
// //               Expanded(
// //                 // padding: EdgeInsets.all(8.0),
// //                 child: Center(
// //                   child: Text(
// //                     'Transactions',
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 20,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const Divider(
// //             color: Color(0xFF5A31F4),
// //           ),
// //           Expanded(
// //             child: Row(
// //               children: [
// //                 Expanded(
// //                     flex: width <= 500 ? 1 : 10,
// //                     child: GridView.builder(
// //                       itemCount: collectionGateways.length,
// //                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                           crossAxisCount: width <= 500 ? 1 : 3),
// //                       itemBuilder: (context, index) {
// //                         return collectionGateways[index];
// //                       },
// //                     )),
// //                 const VerticalDivider(
// //                   color: Color(0xFF5A31F4),
// //                 ),
// //                 Expanded(
// //                   flex: width <= 500 ? 6 : 2,
// //                   child: Stack(
// //                     children: [
// //                       StreamBuilder<QuerySnapshot>(
// //                         stream: FirebaseFirestore.instance
// //                             .collection('mpesaData')
// //                             .snapshots(),
// //                         builder: (context, snapshot) {
// //                           if (snapshot.connectionState ==
// //                               ConnectionState.waiting) {
// //                             return const Center(
// //                                 child: CircularProgressIndicator());
// //                           }

// //                           if (!snapshot.hasData || snapshot.hasError) {
// //                             return const Center(
// //                                 child: Text('Error or no data found'));
// //                           }

// //                           // Get the list of documents
// //                           final docs = snapshot.data!.docs;

// //                           if (docs.isEmpty) {
// //                             return const Center(
// //                                 child: Text('No documents found'));
// //                           }

// //                           return ListView.builder(
// //                             itemCount: 100,
// //                             itemBuilder: (context, index) {
// //                               return ListTile(
// //                                 leading: const CircleAvatar(
// //                                   backgroundColor: Color(0xFF5A31F4),
// //                                   child: Icon(
// //                                     Icons.person,
// //                                     color: Colors.white,
// //                                   ),
// //                                 ),
// //                                 title: Text('jeffayako$index@gmail.com'),
// //                                 subtitle: Text('Amount 235$index'),
// //                               );
// //                             },
// //                           );

// //                           // Center(
// //                           //   child: SizedBox(
// //                           //     width: Get.width <= 500 ? 0 : Get.width / 2,
// //                           //     child: Card(
// //                           //       child: ListView.builder(
// //                           //         itemCount: docs.length,
// //                           //         itemBuilder: (context, index) {
// //                           //           // Access the document data
// //                           //           Map<String, dynamic> data = docs[index]
// //                           //               .data() as Map<String, dynamic>;

// //                           //           if (data.containsKey('Body') == false ||
// //                           //               data['Body']['stkCallback']
// //                           //                       .length
// //                           //                       .toString() ==
// //                           //                   4.toString()) {
// //                           //             // maincontroller.paymentsList.add(
// //                           //             //   double.parse(
// //                           //             //     data['Body']['stkCallback']['CallbackMetadata']['Item']
// //                           //             //             [index]['Value']
// //                           //             //         .toString(),
// //                           //             //   ),
// //                           //             // );
// //                           //           }

// //                           //           // Return a ListTile or any other widget to display the data
// //                           //           return (data.containsKey('Body') == false ||
// //                           //                   data['Body']['stkCallback']
// //                           //                           .length
// //                           //                           .toString() ==
// //                           //                       4.toString())
// //                           //               ? Container()
// //                           //               : ListTile(
// //                           //                   leading: const CircleAvatar(
// //                           //                     backgroundColor:
// //                           //                         Color(0xFF5A31F4),
// //                           //                     child: Icon(
// //                           //                       Icons.person,
// //                           //                       color: Colors.white,
// //                           //                     ),
// //                           //                   ),
// //                           //                   title: data.length.toString() ==
// //                           //                           7.toString()
// //                           //                       ? Container()
// //                           //                       : Text(
// //                           //                           data['Body'][
// //                           //                                       'stkCallback'] ==
// //                           //                                   null
// //                           //                               ? ''
// //                           //                               : "Number: ${data['Body']['stkCallback']['CallbackMetadata']['Item'][3]['Value'].toString()}",
// //                           //                         ),
// //                           //                   subtitle: Row(
// //                           //                     children: [
// //                           //                       Expanded(
// //                           //                         child: Text(
// //                           //                           data['Body'][
// //                           //                                       'stkCallback'] ==
// //                           //                                   null
// //                           //                               ? ''
// //                           //                               : "Amount: ${data['Body']['stkCallback']['CallbackMetadata']['Item'][0]['Value'].toString()}",
// //                           //                         ),
// //                           //                       ),
// //                           //                       IconButton(
// //                           //                         onPressed: () {
// //                           //                           FirebaseFirestore.instance
// //                           //                               .collection('mpesaData')
// //                           //                               .doc(docs[index].id)
// //                           //                               .delete();
// //                           //                         },
// //                           //                         icon: const Icon(
// //                           //                           Icons.delete,
// //                           //                           color: Colors.red,
// //                           //                         ),
// //                           //                       )
// //                           //                     ],
// //                           //                   ),
// //                           //                   trailing: const CircleAvatar(
// //                           //                     child: Icon(Icons.done),
// //                           //                   ),
// //                           //                 );
// //                           //         },
// //                           //       ),
// //                           //     ),
// //                           //   ),
// //                           // );
// //                         },
// //                       ),
// //                       Align(
// //                         alignment: Alignment.bottomCenter,
// //                         child: ElevatedButton(
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: const Color(0xFF5A31F4),
// //                           ),
// //                           onPressed: () {
// //                             Get.bottomSheet(
// //                               backgroundColor: Colors.white,
// //                               Center(
// //                                 child: SizedBox(
// //                                   // width: Get.width / 2,
// //                                   height: Get.height / 1.5,
// //                                   child: Center(
// //                                     child: SingleChildScrollView(
// //                                       child: Column(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.center,
// //                                         children: [
// //                                           Container(
// //                                             width: 400,
// //                                             padding: const EdgeInsets.all(24.0),
// //                                             decoration: BoxDecoration(
// //                                               color: Colors.white,
// //                                               borderRadius:
// //                                                   BorderRadius.circular(12.0),
// //                                               boxShadow: [
// //                                                 BoxShadow(
// //                                                   color: Colors.black
// //                                                       .withOpacity(0.1),
// //                                                   blurRadius: 10,
// //                                                   offset: const Offset(0, 4),
// //                                                 ),
// //                                               ],
// //                                             ),
// //                                             child: Form(
// //                                               key: formcontrollers,
// //                                               child: Column(
// //                                                 crossAxisAlignment:
// //                                                     CrossAxisAlignment.start,
// //                                                 children: [
// //                                                   Center(
// //                                                     child: Image.asset(
// //                                                       'assets/finitelw.png',
// //                                                       color: const Color(
// //                                                           0xFF5A31F4),
// //                                                       height: 100,
// //                                                     ),
// //                                                   ),
// //                                                   const Center(
// //                                                     child: Text(
// //                                                       'FinitePay',
// //                                                       style: TextStyle(
// //                                                         fontSize: 32.0,
// //                                                         fontWeight:
// //                                                             FontWeight.bold,
// //                                                         color:
// //                                                             Color(0xFF5A31F4),
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //                                                   const SizedBox(height: 24.0),
// //                                                   const Text(
// //                                                     'Test Payment',
// //                                                     style: TextStyle(
// //                                                       fontSize: 24.0,
// //                                                       fontWeight:
// //                                                           FontWeight.bold,
// //                                                       color: Colors.black87,
// //                                                     ),
// //                                                   ),
// //                                                   const SizedBox(height: 24.0),
// //                                                   TextFormField(
// //                                                     inputFormatters: [
// //                                                       FilteringTextInputFormatter
// //                                                           .allow(
// //                                                               RegExp("[0-9 +]"))
// //                                                     ],
// //                                                     controller:
// //                                                         phoneNumberController,
// //                                                     validator: (value) => (value!
// //                                                             .trim()
// //                                                             .isEmpty)
// //                                                         ? "Phone Number is required"
// //                                                         : (value.trim().length <
// //                                                                 9)
// //                                                             ? "Enter a valid phone number"
// //                                                             : null,
// //                                                     decoration: InputDecoration(
// //                                                       labelText:
// //                                                           'Enter Your Phone Number',
// //                                                       labelStyle:
// //                                                           const TextStyle(
// //                                                               color: Colors
// //                                                                   .black54),
// //                                                       border:
// //                                                           OutlineInputBorder(
// //                                                         borderRadius:
// //                                                             BorderRadius
// //                                                                 .circular(8.0),
// //                                                         borderSide:
// //                                                             const BorderSide(
// //                                                           color:
// //                                                               Color(0xFF5A31F4),
// //                                                         ),
// //                                                       ),
// //                                                       focusedBorder:
// //                                                           OutlineInputBorder(
// //                                                         borderRadius:
// //                                                             BorderRadius
// //                                                                 .circular(8.0),
// //                                                         borderSide:
// //                                                             const BorderSide(
// //                                                           color:
// //                                                               Color(0xFF5A31F4),
// //                                                         ),
// //                                                       ),
// //                                                       prefix:
// //                                                           const Text('+254 '),
// //                                                     ),
// //                                                     // initialValue: 'jeffayako1@gmail.com',
// //                                                   ),
// //                                                   const SizedBox(height: 16.0),
// //                                                   TextFormField(
// //                                                     controller:
// //                                                         amountController,
// //                                                     inputFormatters: [
// //                                                       FilteringTextInputFormatter
// //                                                           .allow(
// //                                                               RegExp("[0-9]"))
// //                                                     ],
// //                                                     // validator: (value) => value!.trim().isNotEmpty &&
// //                                                     //         value.trim().length > 7
// //                                                     //     ? null
// //                                                     //     : "Password must be at least 8 characters",
// //                                                     // obscureText: true,
// //                                                     decoration: InputDecoration(
// //                                                       labelText: 'Amount',
// //                                                       labelStyle:
// //                                                           const TextStyle(
// //                                                               color: Colors
// //                                                                   .black54),
// //                                                       border:
// //                                                           OutlineInputBorder(
// //                                                         borderRadius:
// //                                                             BorderRadius
// //                                                                 .circular(8.0),
// //                                                         borderSide:
// //                                                             const BorderSide(
// //                                                           color:
// //                                                               Color(0xFF5A31F4),
// //                                                         ),
// //                                                       ),
// //                                                       focusedBorder:
// //                                                           OutlineInputBorder(
// //                                                         borderRadius:
// //                                                             BorderRadius
// //                                                                 .circular(8.0),
// //                                                         borderSide:
// //                                                             const BorderSide(
// //                                                           color:
// //                                                               Color(0xFF5A31F4),
// //                                                         ),
// //                                                       ),

// //                                                       // suffixIcon: const Icon(
// //                                                       //   Icons.visibility,
// //                                                       //   color: Color(0xFF5A31F4),
// //                                                       // ),
// //                                                     ),
// //                                                     // initialValue: 'hhhhhhhhhhhhhhhhh',
// //                                                   ),
// //                                                   const SizedBox(height: 16.0),
// //                                                   // Row(
// //                                                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                                   //   children: [
// //                                                   //     Row(
// //                                                   //       children: [
// //                                                   //         Checkbox(
// //                                                   //           value: true,
// //                                                   //           onChanged: (value) {},
// //                                                   //           activeColor: const Color(0xFF5A31F4),
// //                                                   //         ),
// //                                                   //         const Text('Keep me signed in'),
// //                                                   //       ],
// //                                                   //     ),
// //                                                   //     TextButton(
// //                                                   //       onPressed: () {},
// //                                                   //       child: const Text(
// //                                                   //         'Forgot login details?',
// //                                                   //         style: TextStyle(color: Color(0xFF5A31F4)),
// //                                                   //       ),
// //                                                   //     ),
// //                                                   //   ],
// //                                                   // ),

// //                                                   const SizedBox(height: 24.0),
// //                                                   SizedBox(
// //                                                     width: double.infinity,
// //                                                     child: ElevatedButton(
// //                                                       onPressed: () {
// //                                                         showLoading(
// //                                                             "Loading...");
// //                                                         startCheckout(
// //                                                             userPhone:
// //                                                                 phoneNumberController
// //                                                                     .text
// //                                                                     .toString()
// //                                                                     .trimLeft(),
// //                                                             amount:
// //                                                                 double.parse(
// //                                                               amountController
// //                                                                   .text
// //                                                                   .toString(),
// //                                                             ));
// //                                                         // _onPressed();
// //                                                       },
// //                                                       style: ElevatedButton
// //                                                           .styleFrom(
// //                                                         padding:
// //                                                             const EdgeInsets
// //                                                                 .symmetric(
// //                                                                 vertical: 16.0),
// //                                                         backgroundColor:
// //                                                             const Color(
// //                                                                 0xFF5A31F4),
// //                                                         shape:
// //                                                             RoundedRectangleBorder(
// //                                                           borderRadius:
// //                                                               BorderRadius
// //                                                                   .circular(
// //                                                                       8.0),
// //                                                         ),
// //                                                       ),
// //                                                       child: const Text(
// //                                                         'Pay Via Mobile Money',
// //                                                         style: TextStyle(
// //                                                             fontSize: 16.0,
// //                                                             color:
// //                                                                 Colors.white),
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //                                                   const SizedBox(height: 24.0),
// //                                                   SizedBox(
// //                                                     width: Get.width,
// //                                                     child: ElevatedButton(
// //                                                       style: ElevatedButton
// //                                                           .styleFrom(
// //                                                         padding:
// //                                                             const EdgeInsets
// //                                                                 .symmetric(
// //                                                                 vertical: 16.0),
// //                                                         backgroundColor:
// //                                                             const Color(
// //                                                                 0xFF5A31F4),
// //                                                         shape:
// //                                                             RoundedRectangleBorder(
// //                                                           borderRadius:
// //                                                               BorderRadius
// //                                                                   .circular(
// //                                                                       8.0),
// //                                                         ),
// //                                                       ),
// //                                                       onPressed: () {
// //                                                         Get.back();
// //                                                         Get.to(
// //                                                           () =>
// //                                                               const CardPaymentScreen(),
// //                                                         );
// //                                                         // makePayment();
// //                                                       },
// //                                                       child: const Text(
// //                                                         'Pay Via Cards',
// //                                                         style: TextStyle(
// //                                                             fontSize: 16.0,
// //                                                             color:
// //                                                                 Colors.white),
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //                                                   // Center(
// //                                                   //   child: Padding(
// //                                                   //     padding: const EdgeInsets.all(8.0),
// //                                                   //     child: TextButton(
// //                                                   //       onPressed: () {
// //                                                   //         Get.to(
// //                                                   //           () => const CreateAccountPage(),
// //                                                   //         );
// //                                                   //       },
// //                                                   //       child: const Text(
// //                                                   //         'Create Account',
// //                                                   //         style: TextStyle(color: Color(0xFF5A31F4)),
// //                                                   //       ),
// //                                                   //     ),
// //                                                   //   ),
// //                                                   // ),
// //                                                 ],
// //                                               ),
// //                                             ),
// //                                           ),
// //                                           const SizedBox(height: 16.0),
// //                                           TextButton(
// //                                             onPressed: () {},
// //                                             child: const Text(
// //                                               'Need Support?',
// //                                               style: TextStyle(
// //                                                   // color: Colors.black54,
// //                                                   color: Colors.black),
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             );
// //                           },
// //                           child: const Text(
// //                             'Test Payment',
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                         ),
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }





// // import 'package:finitepay/controllers/init_controllers.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // // ignore: must_be_immutable
// // class BeneficiaryMainPage extends StatelessWidget {
// //   BeneficiaryMainPage({super.key, required this.index});
// //   int index;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Padding(
// //         padding: EdgeInsets.symmetric(horizontal: Get.width / 3),
// //         child: ListView(
// //           children: [
// //             ListTile(
// //               leading: const CircleAvatar(
// //                 child: Icon(Icons.person),
// //               ),
// //               title: Text(currencyCloudController.beneficiaries.value
// //                       ?.beneficiaries[index].bankAccountHolderName ??
// //                   'User'),
// //               subtitle: Text(currencyCloudController
// //                       .beneficiaries.value?.beneficiaries[index].email ??
// //                   'User'),
// //             ),
// //             detailsElementsBox(
// //                 'Id',
// //                 currencyCloudController
// //                         .beneficiaries.value?.beneficiaries[index].id ??
// //                     ''),
// //             detailsElementsBox(
// //                 'Email',
// //                 currencyCloudController
// //                         .beneficiaries.value?.beneficiaries[index].email ??
// //                     ''),
// //             detailsElementsBox(
// //                 'Account Number',
// //                 currencyCloudController.beneficiaries.value
// //                         ?.beneficiaries[index].accountNumber ??
// //                     ''),
// //             detailsElementsBox(
// //                 'Bank Name',
// //                 currencyCloudController
// //                         .beneficiaries.value?.beneficiaries[index].bankName ??
// //                     ''),
// //             detailsElementsBox(
// //                 'Currency',
// //                 currencyCloudController
// //                         .beneficiaries.value?.beneficiaries[index].currency ??
// //                     ''),
// //             detailsElementsBox(
// //                 'Account Holder Name',
// //                 currencyCloudController.beneficiaries.value
// //                         ?.beneficiaries[index].bankAccountHolderName ??
// //                     ''),
// //             detailsElementsBox(
// //                 'DOB',
// //                 currencyCloudController.beneficiaries.value
// //                         ?.beneficiaries[index].beneficiaryDateOfBirth ??
// //                     ''),
// //             detailsElementsBox(
// //                 'City',
// //                 currencyCloudController.beneficiaries.value
// //                         ?.beneficiaries[index].beneficiaryCity ??
// //                     ''),
// //             detailsElementsBox(
// //                 'BIC SWIFT',
// //                 currencyCloudController
// //                         .beneficiaries.value?.beneficiaries[index].bicSwift ??
// //                     ''),
// //             detailsElementsBox(
// //                 'Iban',
// //                 currencyCloudController
// //                         .beneficiaries.value?.beneficiaries[index].iban ??
// //                     ''),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget detailsElementsBox(String title, String titleElement) {
// //     return Column(
// //       children: [
// //         SizedBox(
// //           height: 40,
// //           child: Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text('$title: '),
// //                 Text(titleElement),
// //               ],
// //             ),
// //           ),
// //         ),
// //         const SizedBox(
// //           height: 10,
// //         )
// //       ],
// //     );
// //   }
// // }
