import 'package:finitepay/bridgecards_test/animated_virtual_card.dart';
import 'package:finitepay/bridgecards_test/create_card_holder_page.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/components/txt_input.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/models/cards_models/card_transaction.dart';
import 'package:finitepay/views/home/dashboard_page.dart';
// import 'package:finitepay/views/overviewpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class TestCustomerCards extends StatelessWidget {
  const TestCustomerCards({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        cardsController.customerCards.refresh();

        maincontroller.currentTabIndex.value = 1;

        Get.offAll(const DashBoardHomePage());

        return true; // or false, based on your requiremen
        // return 0;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Your Cards'),
        // ),
        body: maincontroller.cardholderDB != null
            ? LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth <= 800) {
                    return Obx(
                      () =>
                          // cardsController
                          //             .isCardholderPresentButNoCards.value ==
                          //         true
                          //     ? SizedBox(
                          //         // color: Colors.red,
                          //         height: Get.height,
                          //         child: Center(
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Text(
                          //                     'Your CardHolder Details were Created Successfully Tap to Create Your Card'),
                          //                 Btn(
                          //                   txtColor: Colors.white,
                          //                   ontap: () {},
                          //                   btnName: 'Complete Card Creation',
                          //                   color: const Color.fromARGB(
                          //                       255, 14, 143, 19),
                          //                 )
                          //                 // ElevatedButton(onPressed: (){}, child: )
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     :

                          ListView.builder(
                        itemCount: cardsController
                                .customerCards.value?.data.cards.length ??
                            0,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: Get.height,
                            width: Get.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                children: [
                                  // Card Section
                                  //_buildCardSection(),
                                  SizedBox(
                                    height: Get.height / 3,
                                    child: const VirtualCardScreen(),
                                  ),
                                  const Divider(),
                                  Btn(
                                    txtColor: Colors.white,
                                    ontap: () {
                                      Get.dialog(AlertDialog(
                                        title: const Center(
                                            child: Text('Migrate Card')),
                                        content: SizedBox(
                                          height: Get.height / 2,
                                          width: Get.width,
                                          child: Column(
                                            children: [
                                              const Text(
                                                  'Choose the Card Brand to Migrate to'),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Obx(
                                                        () => ListTile(
                                                          title: const Text(
                                                              'Visa'),
                                                          leading:
                                                              Radio<String>(
                                                            value: 'Visa',
                                                            groupValue:
                                                                cardsController
                                                                    .cardBrand
                                                                    .value,
                                                            onChanged: (String?
                                                                value) {
                                                              // setState(() {
                                                              cardsController
                                                                      .cardBrand
                                                                      .value =
                                                                  value!;
                                                              // });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Obx(
                                                        () => ListTile(
                                                          title: const Text(
                                                              'Mastercard'),
                                                          leading:
                                                              Radio<String>(
                                                            value: 'Mastercard',
                                                            groupValue:
                                                                cardsController
                                                                    .cardBrand
                                                                    .value,
                                                            onChanged: (String?
                                                                value) {
                                                              // setState(() {
                                                              cardsController
                                                                      .cardBrand
                                                                      .value =
                                                                  value!;
                                                              // });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    TxtInput(
                                                      inputName:
                                                          'Enter a 4 Digit Pin',
                                                      controller:
                                                          cardsController.pin,
                                                      ispin: true,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        // for below version 2 use this
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9]')),
                                                        // for version 2 and greater youcan also use this
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                    ),
                                                    Btn(
                                                      txtColor: Colors.white,
                                                      ontap: () {
                                                        cardsController.migrateCardFunction(
                                                            cardsController
                                                                    .actualCardDetails
                                                                    .value
                                                                    ?.data
                                                                    .cardholderId ??
                                                                '',
                                                            cardsController
                                                                    .actualCardDetails
                                                                    .value
                                                                    ?.data
                                                                    .cardId ??
                                                                '',
                                                            cardsController
                                                                .cardBrand
                                                                .value,
                                                            cardsController
                                                                .pin.text
                                                                .toString());
                                                      },
                                                      btnName:
                                                          'Complete Migration',
                                                      color: const Color(
                                                          0xFF5A31F4),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                      //cardsController.showCardDetails.toggle();
                                    },
                                    btnName: 'Migrate Card',
                                    color: Colors.deepPurple,
                                  ),

                                  Btn(
                                    txtColor: Colors.white,
                                    ontap: () {
                                      // print(
                                      //   cardsController.actualCardDetails.value
                                      //           ?.data.cardholderId ??
                                      //       '',
                                      // );

                                      // businessAccountsController
                                      //     .createBusinessAccount(
                                      //   cardsController.actualCardDetails.value
                                      //           ?.data.cardholderId ??
                                      //       '',
                                      // );

                                      // usdEuroController.createEuroDollarAccount(
                                      //     cardsController.actualCardDetails.value
                                      //             ?.data.cardholderId ??
                                      //         '',
                                      //     "EUR");

                                      // usdEuroController.upGradingCardHolder(
                                      //     cardsController.actualCardDetails.value
                                      //             ?.data.cardholderId ??
                                      //         '');

                                      cardsController.showCardDetails.toggle();
                                    },
                                    btnName: 'View Card Details',
                                    color: Colors.deepPurple,
                                  ),
                                  Obx(
                                    () => cardsController
                                                .showCardDetails.value ==
                                            false
                                        ? Container()
                                        : Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                          'Card Holder:'),
                                                      Obx(() => Text(
                                                            cardsController
                                                                    .actualCardDetails
                                                                    .value
                                                                    ?.data
                                                                    .cardName ??
                                                                '',
                                                          ))
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                          'Card Number:'),
                                                      Obx(() => Text(
                                                            cardsController
                                                                    .actualCardDetails
                                                                    .value
                                                                    ?.data
                                                                    .cardNumber ??
                                                                '',
                                                          ))
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                          'Expiry Date:'),
                                                      Obx(() => Text(
                                                            '${cardsController.actualCardDetails.value?.data.expiryMonth ?? ''}/ ${cardsController.actualCardDetails.value?.data.expiryYear ?? ''}',
                                                          ))
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text('CVV:'),
                                                      Obx(
                                                        () => Text(
                                                          cardsController
                                                                  .actualCardDetails
                                                                  .value
                                                                  ?.data
                                                                  .cvv ??
                                                              '',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text('Balance'),
                                                      Obx(
                                                        () => Text(
                                                          cardsController
                                                                  .actualCardDetails
                                                                  .value
                                                                  ?.data
                                                                  .balance ??
                                                              '',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text('Card Type:'),
                                                      Obx(
                                                        () => Text(
                                                          cardsController
                                                                  .actualCardDetails
                                                                  .value
                                                                  ?.data
                                                                  .cardType ??
                                                              '',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                          'Currency Limit:'),
                                                      Obx(
                                                        () => Text(
                                                          cardsController
                                                                  .actualCardDetails
                                                                  .value
                                                                  ?.data
                                                                  .currentCardLimit ??
                                                              '',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                          'Card HolderId:'),
                                                      Obx(
                                                        () => Text(
                                                          cardsController
                                                                  .actualCardDetails
                                                                  .value
                                                                  ?.data
                                                                  .cardholderId ??
                                                              '',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text('Card Brand:'),
                                                      Obx(
                                                        () => Text(
                                                          cardsController
                                                                  .actualCardDetails
                                                                  .value
                                                                  ?.data
                                                                  .brand ??
                                                              '',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ),

                                  Btn(
                                    txtColor: Colors.white,
                                    ontap: () {
                                      Get.dialog(AlertDialog(
                                        title: const Center(
                                            child: Text('Migrate Card')),
                                        content: SizedBox(
                                          height: Get.height / 3,
                                          width: Get.width,
                                          child: Column(
                                            children: [
                                              const Text(
                                                  'Unloading your card will move your money to Your Finitepay account'),
                                              // Expanded(
                                              //   child: Column(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment
                                              //             .spaceBetween,
                                              //     children: [
                                              //       Expanded(
                                              //         child: Obx(
                                              //           () => ListTile(
                                              //             title:
                                              //                 const Text('Visa'),
                                              //             leading: Radio<String>(
                                              //               value: 'Visa',
                                              //               groupValue:
                                              //                   cardsController
                                              //                       .cardBrand
                                              //                       .value,
                                              //               onChanged:
                                              //                   (String? value) {
                                              //                 // setState(() {
                                              //                 cardsController
                                              //                     .cardBrand
                                              //                     .value = value!;
                                              //                 // });
                                              //               },
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //       Expanded(
                                              //         child: Obx(
                                              //           () => ListTile(
                                              //             title: const Text(
                                              //                 'Mastercard'),
                                              //             leading: Radio<String>(
                                              //               value: 'Mastercard',
                                              //               groupValue:
                                              //                   cardsController
                                              //                       .cardBrand
                                              //                       .value,
                                              //               onChanged:
                                              //                   (String? value) {
                                              //                 // setState(() {
                                              //                 cardsController
                                              //                     .cardBrand
                                              //                     .value = value!;
                                              //                 // });
                                              //               },
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),

                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    TxtInput(
                                                      inputName:
                                                          'Enter amount to Unload',
                                                      controller:
                                                          cardsController
                                                              .amountTranscated,
                                                      ispin: false,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        // for below version 2 use this
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9]')),
                                                        // for version 2 and greater youcan also use this
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                    ),
                                                    Btn(
                                                      txtColor: Colors.white,
                                                      ontap: () {
                                                        cardsController
                                                            .unloadCard(
                                                          cardsController
                                                                  .actualCardDetails
                                                                  .value
                                                                  ?.data
                                                                  .cardId ??
                                                              '',
                                                          cardsController
                                                              .amountTranscated
                                                              .text
                                                              .toString(),
                                                        );
                                                      },
                                                      btnName:
                                                          'Complete Transaction',
                                                      color: const Color(
                                                          0xFF5A31F4),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                      //cardsController.showCardDetails.toggle();
                                    },
                                    btnName: 'Withdraw from Card',
                                    color: Colors.deepPurple,
                                  ),

                                  // const SizedBox(height: 20),
                                  // Actions Section
                                  const Divider(),
                                  GestureDetector(
                                    onTap: () {
                                      print(cardsController.actualCardDetails
                                              .value?.data.cardId ??
                                          '');
                                    },
                                    child: Text(
                                      "Actions",
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () => cardsController.freezeCard(
                                            cardsController.actualCardDetails
                                                    .value?.data.cardId ??
                                                ''),
                                        child: _buildActionButton(
                                            "Freeze Card", Icons.lock_outline),
                                      ),
                                      InkWell(
                                          onTap: () => cardsController
                                              .unfreezeCard(cardsController
                                                      .actualCardDetails
                                                      .value
                                                      ?.data
                                                      .cardId ??
                                                  ''),
                                          child: _buildActionButton(
                                              "Unfreeze Card",
                                              Icons.lock_open_outlined)),
                                      InkWell(
                                        onTap: () {
                                          Share.share(
                                              'Get started with Finitepay Virtual Cards https://dashboard.finitepay.org/');
                                        },
                                        child: _buildActionButton(
                                          "Share",
                                          Icons.share,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.dialog(
                                            AlertDialog(
                                              title: const Center(
                                                child: Text(
                                                    ' Want to Delete Card'),
                                              ),
                                              content: SizedBox(
                                                height: Get.height / 2,
                                                width: Get.width <= 800
                                                    ? Get.width
                                                    : Get.width / 2,
                                                child: Column(
                                                  children: [
                                                    const Icon(
                                                      Icons.warning_outlined,
                                                      size: 100,
                                                      color: Colors.red,
                                                    ),
                                                    const Text(
                                                      'Please ensure you have withdrawn all funds from the card before deleting so that You do not Loss your money',
                                                    ),
                                                    const Divider(),
                                                    Btn(
                                                      txtColor: Colors.white,
                                                      ontap: () => cardsController.deleteCard(
                                                          cardsController
                                                                  .actualCardDetails
                                                                  .value
                                                                  ?.data
                                                                  .cardId ??
                                                              '',
                                                          cardsController
                                                                  .actualCardDetails
                                                                  .value
                                                                  ?.data
                                                                  .cardholderId ??
                                                              ''),
                                                      btnName: 'Delete Card',
                                                      color: Colors.red,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );

                                          // Share.share(
                                          //     'Get started with Finitepay Virtual Cards https://dashboard.finitepay.org/');
                                        },
                                        child: _buildActionButton(
                                          "Delete Card",
                                          Icons.delete,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  // Transaction History
                                  Text(
                                    "Recent Transactions",
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: Get.height / 3,
                                    child: Obx(
                                      () => ListView.builder(
                                        itemCount: cardsController
                                                .cardTransactions
                                                .value
                                                ?.data
                                                .transactions
                                                .length ??
                                            0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return _buildTransactionTile(
                                              cardsController.cardTransactions,
                                              index);
                                        },
                                        // children: List.generate(5, (index) => _buildTransactionTile()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );

                          // ListTile(
                          //   leading: const CircleAvatar(
                          //     child: Icon(Icons.credit_card),
                          //   ),
                          //   title: Text(cardsController
                          //           .customerCards.value?.data.cards[index].cardName ??
                          //       ''),
                          //   subtitle: Text(cardsController
                          //           .customerCards.value?.data.cards[index].brand ??
                          //       ''),
                          // );
                        },
                      ),
                    );
                  } else {
                    return Row(
                      children: [
                        Expanded(
                            child: Obx(
                          () => maincontroller.cardholderDB == null ||
                                  cardsController.customerCards.value == null
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  itemCount: cardsController.customerCards.value
                                          ?.data.cards.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height: Get.height,
                                      width: Get.width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView(
                                          children: [
                                            // Card Section
                                            _buildCardSection(),
                                            Btn(
                                              txtColor: Colors.white,
                                              ontap: () {
                                                cardsController.showCardDetails
                                                    .toggle();
                                              },
                                              btnName: 'View Card Details',
                                              color: Colors.deepPurple,
                                            ),
                                            Obx(
                                              () => cardsController
                                                          .showCardDetails
                                                          .value ==
                                                      false
                                                  ? Container()
                                                  : Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Card Holder:'),
                                                                Obx(() => Text(
                                                                      cardsController
                                                                              .actualCardDetails
                                                                              .value
                                                                              ?.data
                                                                              .cardName ??
                                                                          '',
                                                                    ))
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Card Number:'),
                                                                Obx(() => Text(
                                                                      cardsController
                                                                              .actualCardDetails
                                                                              .value
                                                                              ?.data
                                                                              .cardNumber ??
                                                                          '',
                                                                    ))
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Expiry Date:'),
                                                                Obx(() => Text(
                                                                      '${cardsController.actualCardDetails.value?.data.expiryMonth ?? ''}/ ${cardsController.actualCardDetails.value?.data.expiryYear ?? ''}',
                                                                    ))
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'CVV:'),
                                                                Obx(
                                                                  () => Text(
                                                                    cardsController
                                                                            .actualCardDetails
                                                                            .value
                                                                            ?.data
                                                                            .cvv ??
                                                                        '',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Balance'),
                                                                Obx(
                                                                  () => Text(
                                                                    cardsController
                                                                            .actualCardDetails
                                                                            .value
                                                                            ?.data
                                                                            .balance ??
                                                                        '',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Card Type:'),
                                                                Obx(
                                                                  () => Text(
                                                                    cardsController
                                                                            .actualCardDetails
                                                                            .value
                                                                            ?.data
                                                                            .cardType ??
                                                                        '',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Currency Limit:'),
                                                                Obx(
                                                                  () => Text(
                                                                    cardsController
                                                                            .actualCardDetails
                                                                            .value
                                                                            ?.data
                                                                            .currentCardLimit ??
                                                                        '',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Card HolderId:'),
                                                                Obx(
                                                                  () => Text(
                                                                    cardsController
                                                                            .actualCardDetails
                                                                            .value
                                                                            ?.data
                                                                            .cardholderId ??
                                                                        '',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Card Brand:'),
                                                                Obx(
                                                                  () => Text(
                                                                    cardsController
                                                                            .actualCardDetails
                                                                            .value
                                                                            ?.data
                                                                            .brand ??
                                                                        '',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                            ),

                                            // const SizedBox(height: 20),
                                            // Actions Section
                                            const Divider(),
                                            Text(
                                              "Actions",
                                              style: GoogleFonts.lato(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  onTap: () => cardsController
                                                      .freezeCard(cardsController
                                                              .actualCardDetails
                                                              .value
                                                              ?.data
                                                              .cardId ??
                                                          ''),
                                                  child: _buildActionButton(
                                                      "Freeze Card",
                                                      Icons.lock_outline),
                                                ),
                                                InkWell(
                                                    onTap: () => cardsController
                                                        .unfreezeCard(
                                                            cardsController
                                                                    .actualCardDetails
                                                                    .value
                                                                    ?.data
                                                                    .cardId ??
                                                                ''),
                                                    child: _buildActionButton(
                                                        "Unfreeze Card",
                                                        Icons
                                                            .lock_open_outlined)),
                                                InkWell(
                                                    onTap: () {
                                                      Share.share(
                                                          'Get started with Finitepay Virtual Cards https://dashboard.finitepay.org/');
                                                    },
                                                    child: _buildActionButton(
                                                        "Share", Icons.share)),
                                                InkWell(
                                                  onTap: () {
                                                    Get.dialog(
                                                      AlertDialog(
                                                        title: const Center(
                                                          child: Text(
                                                              ' Want to Delete Card'),
                                                        ),
                                                        content: SizedBox(
                                                          height:
                                                              Get.height / 2,
                                                          width: Get.width <=
                                                                  800
                                                              ? Get.width
                                                              : Get.width / 2,
                                                          child: Column(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .warning_outlined,
                                                                size: 100,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              const Text(
                                                                'Please ensure you have withdrawn all funds from the card before deleting so that You do not Loss your money',
                                                              ),
                                                              const Divider(),
                                                              Btn(
                                                                txtColor: Colors
                                                                    .white,
                                                                ontap: () => cardsController.deleteCard(
                                                                    cardsController
                                                                            .actualCardDetails
                                                                            .value
                                                                            ?.data
                                                                            .cardId ??
                                                                        '',
                                                                    cardsController
                                                                            .actualCardDetails
                                                                            .value
                                                                            ?.data
                                                                            .cardholderId ??
                                                                        ''),
                                                                btnName:
                                                                    'Delete Card',
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );

                                                    // Share.share(
                                                    //     'Get started with Finitepay Virtual Cards https://dashboard.finitepay.org/');
                                                  },
                                                  child: _buildActionButton(
                                                    "Delete Card",
                                                    Icons.delete,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );

                                    // ListTile(
                                    //   leading: const CircleAvatar(
                                    //     child: Icon(Icons.credit_card),
                                    //   ),
                                    //   title: Text(cardsController
                                    //           .customerCards.value?.data.cards[index].cardName ??
                                    //       ''),
                                    //   subtitle: Text(cardsController
                                    //           .customerCards.value?.data.cards[index].brand ??
                                    //       ''),
                                    // );
                                  },
                                ),
                        )),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Recent Transactions",
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Obx(
                                  () => ListView.builder(
                                    itemCount: cardsController.cardTransactions
                                            .value?.data.transactions.length ??
                                        0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _buildTransactionTile(
                                          cardsController.cardTransactions,
                                          index);
                                    },
                                    // children: List.generate(5, (index) => _buildTransactionTile()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const Expanded(
                        //   child: OverPageScreen(),
                        // ),
                      ],
                    );
                  }
                },
              )
            : CreateCardHolderPage(
                country: 'Kenya',
              ),
      ),
    );
  }

  Widget _buildCardSection() {
    return Obx(
      () => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: cardsController.actualCardDetails.value?.data.isActive ?? false
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/fwhitelogo.png',
                            width: 50,
                          ),
                          Text(
                            "Mastercard",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/master.png',
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => Text(
                      "**** **** **** ${cardsController.actualCardDetails.value?.data.last4 ?? ''}",
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 22,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Card Holder",
                            style: GoogleFonts.lato(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          Obx(
                            () => Text(
                              cardsController
                                      .actualCardDetails.value?.data.cardName ??
                                  '',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expires",
                            style: GoogleFonts.lato(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          // Obx(
                          //   () =>
                          Obx(
                            () => Text(
                              '${cardsController.actualCardDetails.value?.data.expiryMonth ?? ''}/ ${cardsController.actualCardDetails.value?.data.expiryYear ?? ''}',

                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16,
                                textStyle: const TextStyle(
                                    overflow: TextOverflow.ellipsis),
                                fontWeight: FontWeight.bold,
                              ),
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            : const Center(
                child: Text(
                  'Card Frozen',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.deepPurple,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label, style: GoogleFonts.lato(fontSize: 14)),
      ],
    );
  }

  Widget _buildTransactionTile(
    Rxn<CardTransactions> cardTransactions,
    int index,
  ) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.shopping_cart, color: Colors.white),
        ),
        title: Obx(() => Text(
            cardTransactions.value?.data.transactions[index].description ??
                '')),
        subtitle: Obx(() => Text(cardTransactions.value?.data
                .transactions[index].enrichedData.transactionCategory ??
            '')),
        trailing: Obx(
          () => Text(
            cardTransactions.value?.data.transactions[index].amount ?? '',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
