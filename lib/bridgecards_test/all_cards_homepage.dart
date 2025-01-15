import 'package:finitepay/controllers/init_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardsUnderAccountPage extends StatelessWidget {
  const CardsUnderAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(
                'All Cards  ${cardsController.cardsUnderAccount.value!.data.cards.length}'),
          ),
        ),
        body: Obx(
          () => cardsController.cardsUnderAccount.value == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: cardsController
                      .cardsUnderAccount.value!.data.cards.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: .3),
                      ),
                      child: ListTile(
                        // leading: const CircleAvatar(
                        //   child: Icon(Icons.person),
                        // ),
                        onTap: () {
                          print(cardsController.cardsUnderAccount.value!.data
                              .cards[index].cardId);

                          // cardsController.getCardTransactions(cardsController
                          //     .cardsUnderAccount
                          //     .value!
                          //     .data
                          //     .cards[index]
                          //     .cardId);

                          cardsController.getCardToken(cardsController
                              .cardsUnderAccount
                              .value!
                              .data
                              .cards[index]
                              .cardId);
                        },
                        title: Row(
                          children: [
                            const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(cardsController.cardsUnderAccount.value!.data
                                .cards[index].cardName),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            Text(
                                'CardNumber: ${cardsController.cardsUnderAccount.value!.data.cards[index].cardNumber}'),
                            const Divider(),
                            Text(
                                'Card type: ${cardsController.cardsUnderAccount.value!.data.cards[index].cardType}'),
                            const Divider(),
                            Text(
                                'Cvv: ${cardsController.cardsUnderAccount.value!.data.cards[index].cvv}'),
                            const Divider(),
                            const Divider(),
                            Text(
                                'Expiry Month: ${cardsController.cardsUnderAccount.value!.data.cards[index].expiryMonth}'),
                            const Divider(),
                            const Divider(),
                            Text(
                                'Expiry Year: ${cardsController.cardsUnderAccount.value!.data.cards[index].expiryYear}'),
                            const Divider(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ));
  }
}
