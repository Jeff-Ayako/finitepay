import 'package:avatar_glow/avatar_glow.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/models/cards_models/card_transaction.dart';
import 'package:finitepay/views/home/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class SingleCardDetailsPage extends StatelessWidget {
  const SingleCardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        cardsController.customerCards.refresh();

        maincontroller.currentTabIndex.value = 1;

        Get.offAll(const DashBoardHomePage());

        return true; // or false, based on your requirement
      },
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  // Pass a refresh function to SecondPage
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           SecondPage(refreshCallback: refreshPage)),
                  // );
                  cardsController.customerCards.refresh();

                  maincontroller.currentTabIndex.value = 1;

                  Get.offAll(const DashBoardHomePage());
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text("My Mastercard"),
            backgroundColor: Colors.deepPurple,
            elevation: 0,
            actions: [
              FloatingActionButton(
                tooltip: 'Delete Card',
                elevation: 0,
                backgroundColor: Colors.deepPurple,
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: const Center(
                        child: Text(' Want to Delete Card'),
                      ),
                      content: SizedBox(
                        height: Get.height / 3,
                        width: Get.width,
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
                                  cardsController.actualCardDetails.value?.data
                                          .cardId ??
                                      '',
                                  cardsController.actualCardDetails.value?.data
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
                },
                child: AvatarGlow(
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth <= 800) {
                return Obx(
                  () => ListView.builder(
                    itemCount: cardsController
                            .customerCards.value?.data.cards.length ??
                        0,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // Card Section
                              _buildCardSection(),
                              Btn(
                                txtColor: Colors.white,
                                ontap: () {
                                  cardsController.showCardDetails.toggle();
                                },
                                btnName: 'View Card Details',
                                color: Colors.deepPurple,
                              ),
                              Obx(
                                () => cardsController.showCardDetails.value ==
                                        false
                                    ? Container()
                                    : Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Card Holder:'),
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
                                                  const Text('Card Number:'),
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
                                                  const Text('Expiry Date:'),
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
                                                  const Text('Currency Limit:'),
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
                                                  const Text('Card HolderId:'),
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
                                    onTap: () => cardsController.freezeCard(
                                        cardsController.actualCardDetails.value
                                                ?.data.cardId ??
                                            ''),
                                    child: _buildActionButton(
                                        "Freeze Card", Icons.lock_outline),
                                  ),
                                  InkWell(
                                      onTap: () => cardsController.unfreezeCard(
                                          cardsController.actualCardDetails
                                                  .value?.data.cardId ??
                                              ''),
                                      child: _buildActionButton("Unfreeze Card",
                                          Icons.lock_open_outlined)),
                                  InkWell(
                                      onTap: () {
                                        Share.share(
                                            'Get started with Finitepay Virtual Cards https://dashboard.finitepay.org/');
                                      },
                                      child: _buildActionButton(
                                          "Share", Icons.share)),
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
                      () => ListView.builder(
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
                                  _buildCardSection(),
                                  Btn(
                                    txtColor: Colors.white,
                                    ontap: () {
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
                                              "Share", Icons.share)),
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
                                itemBuilder: (BuildContext context, int index) {
                                  return _buildTransactionTile(
                                      cardsController.cardTransactions, index);
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
          )),
    );
  }

  Widget _buildCardSection() {
    return Container(
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
      child: cardsController.actualCardDetails.value!.data.isActive == false
          ? const Center(
              child: Text(
                'Card Frozen',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          : Column(
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
                            // '12/27',
                            // cardsController.decryptCardDetail(
                            //     cardsController
                            //             .singleCardDetails.value?.data.expiryMonth ??
                            //         '',
                            //     cardsController.bridgetestKey.value),
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
        title: Obx(() =>
            Text(cardTransactions.value!.data.transactions[index].description)),
        subtitle: Obx(() => Text(cardTransactions
            .value!.data.transactions[index].enrichedData.transactionCategory)),
        trailing: Obx(
          () => Text(
            cardTransactions.value!.data.transactions[index].amount,
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
