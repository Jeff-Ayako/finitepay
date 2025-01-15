
import 'package:finitepay/bridgecards_test/all_cards_homepage.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/models/cards_models/paystack_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BridgeCardPageTest extends StatelessWidget {
  const BridgeCardPageTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Divider(),
            ElevatedButton(
              onPressed: () => cardsController.registerCardHolder(),
              child: const Text('Create Card'),
            ),
            const Divider(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () =>
                  cardsController.getAllCardHolders().then((value) {
                Get.back();
                Get.back();
              }),
              // {
              //   cardsController.registerCardHolder();
              // },
              child: const Text('Get All Card Holders'),
            ),
            const Divider(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () => cardsController.fundWalletsAccount(),
              // {
              //   cardsController.registerCardHolder();
              // },
              child: const Text('Fund Wallets'),
            ),
            const Divider(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              onPressed: () => cardsController.getissueingWalletBalance(),
              // {
              //   cardsController.registerCardHolder();
              // },
              child: const Text('Get Wallet Balance'),
            ),
            const Divider(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
              onPressed: () => cardsController.getbridgeFxRates(),
              child: const Text('Get Fx Rates'),
            ),
            const Divider(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () => cardsController.getCountriesStates(),
              child: const Text('Get Countries States.'),
            ),
            const Divider(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () => createRecipient(
                  name: 'Jeff Ayako',
                  accountNumber: '0746071879',
                  bankCode: 'MPESA'),
              child: const Text('Create Paystack Recipient.'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () {
                paystackService.initiateWithdrawal(
                    amount: '10', recipientCode: 'RCP_1tvx4ar70l6fefq');
              },
              child: const Text('Withdraw From Paystack.'),
            ),

            // CardsUnderAccountPage

            Btn(
              txtColor: Colors.white,
              ontap: () {
                Get.to(
                  () => const CardsUnderAccountPage(),
                );
              },
              btnName: 'Get to my cards',
              color: Colors.green,
            ),
            Btn(
              txtColor: Colors.white,
              ontap: () {
                cardsController.registerNigeriaCardHolder();
              },
              btnName: 'Password Test Encrypt',
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}

PaystackService paystackService = PaystackService();

// RCP_1tvx4ar70l6fefq

Future createCard() async {}
