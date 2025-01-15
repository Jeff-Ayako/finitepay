// import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/beneficiary/beneficiary_page.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/cyber_source_data.dart';
import 'package:finitepay/global/global_data.dart';
// import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/views/create_beneficiary.dart';
import 'package:finitepay/views/create_transfer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestMainPage extends StatelessWidget {
  const TestMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: MybalancedPage()

        // Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.blue,
        //         ),
        //         onPressed: () {
        //           fxController.getDetailedFxQuote('EUR', 'GBP', 'buy', 100);
        //         },
        //         child: const Text(
        //           'Get Detailed Quote',
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.blue,
        //         ),
        //         onPressed: () {
        //           fxController.getExchangeRates(
        //             'EURGBP',
        //           );
        //         },
        //         child: const Text(
        //           'Get Exchange Rates',
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.blue,
        //         ),
        //         onPressed: () {
        //           currencyCloudController.loginToCurrencyCloud(
        //               'jeff@finitepay.org',
        //               '41a86cf60bcff796a98dcbf1a2cc9739f632eb6a685b46201098747c9103d552');
        //         },
        //         child: const Text(
        //           'Get Authentication Token',
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.blue,
        //         ),
        //         onPressed: () {
        //           currencyCloudController.getBeneficiaryRequirements('DE', 'EUR');
        //         },
        //         child: const Text(
        //           'Transfer Funds  100 EUR ',
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.blue,
        //         ),
        //         onPressed: () {
        //           currencyCloudController.transferFundsAPI();
        //         },
        //         child: const Text(
        //           'Get Beneficiary requirements',
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       Row(
        //         children: [
        //           Expanded(
        //             child: Center(
        //               child: ElevatedButton(
        //                 style: ElevatedButton.styleFrom(
        //                   backgroundColor: Colors.blue,
        //                 ),
        //                 onPressed: () {
        //                   currencyCloudController.getBalanceForCurrency(
        //                     'EUR',
        //                   );
        //                 },
        //                 child: const Text(
        //                   'Get EUR Balance',
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //           Obx(
        //             () => currencyCloudController.currencyModel.value == null
        //                 ? const Text('')
        //                 : Center(
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         Text(
        //                           currencyCloudController
        //                               .currencyModel.value!.currency,
        //                         ),
        //                         Text(
        //                           currencyCloudController
        //                               .currencyModel.value!.amount,
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //           )
        //         ],
        //       ),
        //       const SizedBox(
        //         height: 30,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Expanded(
        //             child: ElevatedButton(
        //               onPressed: () {
        //                 currencyCloudController.getBalances();
        //               },
        //               child: const Text(
        //                 'Get All my currencies balance,',
        //               ),
        //             ),
        //           ),
        //           Expanded(
        //             child: Obx(() => Center(
        //                   child: currencyCloudController.allMycurrencies.value ==
        //                           null
        //                       ? Container()
        //                       : Row(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           crossAxisAlignment: CrossAxisAlignment.center,
        //                           children: [
        //                             const Text('List Lenght'),
        //                             Text(currencyCloudController
        //                                 .allMycurrencies.value!.balances.length
        //                                 .toString()),
        //                             Text(currencyCloudController.allMycurrencies
        //                                 .value!.balances[2].currency),
        //                             Text(currencyCloudController.allMycurrencies
        //                                 .value!.balances[2].amount),
        //                           ],
        //                         ),
        //                 )),
        //           )
        //         ],
        //       )
        //     ],
        //   ),
        // ),

        );
  }
}

class MybalancedPage extends StatelessWidget {
  const MybalancedPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    currencyCloudController
        .loginToCurrencyCloud('jeff@finitepay.org',
            '41a86cf60bcff796a98dcbf1a2cc9739f632eb6a685b46201098747c9103d552')
        .then((value) {});

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5A31F4),
            ),
            onPressed: () {
              Get.to(
                () => const CreateTransfer(),
              );
              // subAccountController.createSubaccount(
              //     'Jeff NkuNku',
              //     'individual',
              //     'Kiambu , Nairobi',
              //     'Nairobi',
              //     'KE',
              //     '43844',
              //     'UUID',
              //     'enabled',
              //     'KSI',
              //     'national_id',
              //     '366588345');
              // subAccountController.getPendingTransactions();
            },
            child: const Text(
              'Transfer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5A31F4),
            ),
            onPressed: () {
              subAccountController.createSubaccount(
                  'Jeff NkuNku',
                  'individual',
                  'Kiambu , Nairobi',
                  'Nairobi',
                  'KE',
                  '43844',
                  'UUID',
                  'enabled',
                  'KSI',
                  'national_id',
                  '366588345');
              // subAccountController.getPendingTransactions();
            },
            child: const Text(
              'Create SubAccount',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5A31F4),
            ),
            onPressed: () {
              currencyCloudController.getBeneficiaryRequirements('KE', 'KES');
            },
            child: const Text(
              'Get Beneficiary Requirements',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5A31F4),
            ),
            onPressed: () {
              Get.to(
                () => const CreateBeneficiary(),
              );
              // Get.bottomSheet(const CreateBeneficiary());
            },
            child: const Text(
              'Create A Beneficiary',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5A31F4),
            ),
            onPressed: () {},
            child: const Text(
              'Transact',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: Get.height,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                // padding: EdgeInsets.symmetric(
                //   horizontal: width <= 500 ? 0 : width / 4,
                //   vertical: 10,
                // ),
                padding: const EdgeInsets.all(10),
                child: Card(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Balances',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF5A31F4),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'Add A Currency',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        SizedBox(
                          height: Get.height / 2,
                          child: Obx(
                            () => ListView.builder(
                              itemCount: currencyCloudController
                                      .allMycurrencies.value?.balances.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const CircleAvatar(
                                    child:
                                        // ClipOval(
                                        //   child: Image.network(
                                        //     flags[index],
                                        //     height: Get.height,
                                        //     width: Get.width,
                                        //     fit: BoxFit.cover,
                                        //   ),
                                        // ),
                                        //     CountryFlag.simplified(
                                        //   CurrencyCloudController.countries  [index],
                                        //   height: CurrencyCloudController.size,
                                        //   aspectRatio: currencyCloudController.aspectRatio.value,
                                        // )

                                        Icon(
                                      Icons.monetization_on_outlined,
                                    ),
                                  ),
                                  title: Obx(
                                    () => Text(currencyCloudController
                                        .allMycurrencies
                                        .value!
                                        .balances[index]
                                        .currency),
                                  ),
                                  subtitle: Obx(
                                    () => Text(
                                      currencyCloudController.allMycurrencies
                                          .value!.balances[index].id,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  trailing: Obx(
                                    () => Text(currencyCloudController
                                        .allMycurrencies
                                        .value!
                                        .balances[index]
                                        .amount),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5A31F4),
                          ),
                          onPressed: () {
                            cybersourceController.createCyberSourceToken(
                                apiKey: cybersourceTestKey,
                                apiSecret: secretekey,
                                cardNumber: '5196010165077472',
                                expiryMonth: '12',
                                expiryYear: '28',
                                cardCvv: '810',
                                currency: 'USD',
                                amount: 1);
                          },
                          child: const Text(
                            'Fund Wallet',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Divider(),
                        const Center(
                          child: Text(
                            'FX Conversion Rates',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: Get.height,
                            child: Scaffold(
                              body: FutureBuilder<Map<String, dynamic>>(
                                future: fxController.fxRates,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else {
                                    // Extract the rates data
                                    Map<String, dynamic> rates =
                                        snapshot.data ?? {};
                                    List<String> currencyCodes =
                                        rates.keys.toList();

                                    return ListView.builder(
                                      itemCount: currencyCodes.length,
                                      itemBuilder: (context, index) {
                                        String currency = currencyCodes[index];
                                        double rate = rates[currency];

                                        return ListTile(
                                          leading: const CircleAvatar(
                                            child: Icon(
                                              Icons.account_balance,
                                            ),
                                          ),
                                          title: Text('$currency: $rate'),
                                          subtitle:
                                              Text('1 EUR = $rate $currency'),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Obx(
              () => currencyCloudController.transactionsObject.value! == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Scaffold(
                      appBar: AppBar(
                        title: const Text('Your Transcations'),
                        centerTitle: true,
                        actions: [
                          IconButton(
                            tooltip: 'Print Transaction Report',
                            onPressed: () {},
                            icon: const Icon(
                              Icons.print,
                            ),
                          ),
                        ],
                      ),
                      body: Center(
                        child: ListView.builder(
                          itemCount: currencyCloudController.transactionsObject
                                  .value?.transactions.length ??
                              0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          15), // Rounded corners
                                    ),
                                    // shape: RoundedRectangleBorder,
                                    tileColor: currencyCloudController
                                                .transactionsObject
                                                .value!
                                                .transactions[index]
                                                .status ==
                                            'pending'
                                        ? Colors.amber
                                        : Colors.transparent,
                                    // shape:ContinuousRectangleBorder,
                                    leading: const CircleAvatar(
                                      child: Icon(Icons.payment),
                                    ),
                                    title: Text(currencyCloudController
                                        .transactionsObject
                                        .value!
                                        .transactions[index]
                                        .currency
                                        .toString()),
                                    subtitle: Text(currencyCloudController
                                        .transactionsObject
                                        .value!
                                        .transactions[index]
                                        .amount),
                                    trailing: Text(currencyCloudController
                                        .transactionsObject
                                        .value!
                                        .transactions[index]
                                        .status),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            )),
            Expanded(
              child: Obx(
                () => currencyCloudController.transactionsObject.value! == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Scaffold(
                        appBar: AppBar(
                          title: const Text('Your Beneficiaries'),
                          centerTitle: true,
                          // actions: [
                          //   // IconButton(
                          //   //   tooltip: 'Print Transaction Report',
                          //   //   onPressed: () {},
                          //   //   icon: const Icon(
                          //   //     Icons.print,
                          //   //   ),
                          //   // ),
                          // ],
                        ),
                        body: Center(
                          child: ListView.builder(
                            itemCount: currencyCloudController.beneficiaries
                                    .value?.beneficiaries.length ??
                                0,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(
                                  () => ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ListTile(
                                      onTap: () {
                                        Get.to(
                                          () => BeneficiaryPage(
                                            // index: index,
                                          ),
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            15), // Rounded corners
                                      ),
                                      // shape: RoundedRectangleBorder,
                                      // tileColor: currencyCloudController
                                      //             .transactionsObject
                                      //             .value!
                                      //             .transactions[index]
                                      //             .status ==
                                      //         'pending'
                                      //     ? Colors.amber
                                      //     : Colors.transparent,
                                      // shape:ContinuousRectangleBorder,
                                      leading: const CircleAvatar(
                                        child:
                                            Icon(Icons.person_outline_outlined),
                                      ),
                                      title: Text(
                                        currencyCloudController
                                            .beneficiaries
                                            .value!
                                            .beneficiaries[index]
                                            .bankAccountHolderName
                                            .toString(),
                                      ),
                                      subtitle: Text(currencyCloudController
                                          .beneficiaries
                                          .value!
                                          .beneficiaries[index]
                                          .beneficiaryCountry),
                                      trailing: Text(currencyCloudController
                                          .beneficiaries
                                          .value!
                                          .beneficiaries[index]
                                          .accountNumber),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: dashtransacElements.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return dashtransacElements[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
