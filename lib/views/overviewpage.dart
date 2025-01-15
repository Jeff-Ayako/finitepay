import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:finitepay/components/make_payout_dialog.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/components/top_up_dialog.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/views/current_currency_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OverPageScreen extends StatelessWidget {
  const OverPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 500) {
          return OverViewWidget(
            screenSize: 500,
          );
        } else if (constraints.maxWidth <= 1000) {
          return OverViewWidget(
            screenSize: 1000,
          );
        } else {
          return OverViewWidget(
            screenSize: 1200,
          );
        }
      },
    ));
  }
}

// ignore: must_be_immutable
class OverViewWidget extends StatelessWidget {
  OverViewWidget({
    super.key,
    required this.screenSize,
  });
  double screenSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        'Hello, ${authenticationController.userDetails.value.fullname}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Text('Here is how Your Business is performing'),
                  ],
                ),
                screenSize <= 500
                    ? Container()
                    : Btn(
                        txtColor: Colors.black,
                        ontap: () => Get.dialog(
                          PayoutDialogue(
                            width: screenSize,
                          ),
                        ),
                        btnName: 'Make Payment',
                        color: Colors.transparent,
                      ),
                screenSize <= 500
                    ? Container()
                    : Btn(
                        txtColor: Colors.white,
                        ontap: () => Get.dialog(
                          TopupDialogBox(
                            width: screenSize,
                          ),
                        ),
                        btnName: 'Fund Balance',
                        color: const Color(0xFF5A31F4),
                      ),
              ],
            ),
            Row(
              children: [
                screenSize <= 500
                    ? Expanded(
                        child: Btn(
                          txtColor: Colors.black,
                          ontap: () => Get.dialog(
                            PayoutDialogue(
                              width: screenSize,
                            ),
                          ),
                          btnName: 'Make Payment',
                          color: Colors.transparent,
                        ),
                      )
                    : Container(),
                screenSize <= 500
                    ? Expanded(
                        child: Btn(
                          txtColor: Colors.white,
                          ontap: () => Get.dialog(
                            TopupDialogBox(
                              width: screenSize,
                            ),
                          ),
                          btnName: 'Fund Balance',
                          color: const Color(0xFF5A31F4),
                        ),
                      )
                    : Container(),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  height: Get.height,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                        // color: Theme.of(context),
                        width: .3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'My Balances',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Btn(
                            txtColor: Colors.black,
                            ontap: () => currencyCloudController.getBalances(),
                            btnName: 'Refresh',
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Obx(
                          () => currencyCloudController.allMycurrencies.value ==
                                  null
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : GridView.builder(
                                  itemCount: currencyCloudController
                                          .allMycurrencies
                                          .value
                                          ?.balances
                                          .length ??
                                      0,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    // crossAxisSpacing: 8,
                                    // mainAxisSpacing: 8,
                                    crossAxisCount: screenSize <= 500
                                        ? 1
                                        : screenSize <= 1000
                                            ? 2
                                            : 4,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () => Get.to(
                                          () => const CurrentCurrencyPage(),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(width: .2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                        'Available Balance'),
                                                    CircleAvatar(
                                                      child: ClipOval(
                                                        child:
                                                            CachedNetworkImage(
                                                          width: Get.width,
                                                          height: Get.height,
                                                          fit: BoxFit.cover,
                                                          imageUrl:
                                                              flags[index],
                                                          placeholder: (context,
                                                                  url) =>
                                                              const CircularProgressIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                            Icons
                                                                .error_outline_outlined,
                                                          ),
                                                        ),
                                                      ),

                                                      // Icon(
                                                      //   Icons.monetization_on_outlined,
                                                      // ),
                                                    ),
                                                  ],
                                                ),
                                                Obx(
                                                  () => Text(
                                                    '${currencyCloudController.allMycurrencies.value?.balances[index].currency ?? ''}:${currencyCloudController.allMycurrencies.value?.balances[index].amount ?? '0.0'}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Text('Ledger: '),
                                                    Text(
                                                      '${currencyCloudController.allMycurrencies.value?.balances[index].currency ?? ''}: ${currencyCloudController.allMycurrencies.value?.balances[index].amount ?? '0.0'}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Text('Locked: '),
                                                    Text(
                                                      '${currencyCloudController.allMycurrencies.value?.balances[index].currency ?? ''}: 0.0',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'Rolling Reserve: ',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF5A31F4),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${currencyCloudController.allMycurrencies.value?.balances[index].currency ?? ''}: 0.0',
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF5A31F4),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ConfettiWidget(
            confettiController: successController.controllerBottomCenter,
            blastDirection: -pi / 2,
            emissionFrequency: 0.01,
            numberOfParticles: 20,
            maxBlastForce: 100,
            minBlastForce: 80,
            gravity: 0.3,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            shouldLoop:
                true, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
            createParticlePath: successController.drawStar,
          ),
        ),
      ],
    );
  }
}
