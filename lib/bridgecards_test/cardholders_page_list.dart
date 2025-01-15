import 'package:avatar_glow/avatar_glow.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardHoldersList extends StatelessWidget {
  const CardHoldersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All the Card Holders'),
        actions: [
          IconButton(
              onPressed: () {
                cardsController.getallCardsIssued();
              },
              icon: const Icon(
                Icons.card_giftcard,
                color: Colors.black,
              ))
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: cardsController.cardholder.value!.data.cardholders.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: .3),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                    onTap: () {
                      // cardsController.createUSDCard(cardsController.cardholder
                      //     .value!.data.cardholders[index].cardholderId);
                    },
                    title: Row(
                      children: [
                        const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${cardsController.cardholder.value!.data.cardholders[index].firstName} ${cardsController.cardholder.value!.data.cardholders[index].lastName}',
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        Text(
                          cardsController.cardholder.value!.data
                              .cardholders[index].identityDetails.phone,
                        ),
                        Text(
                          cardsController.cardholder.value!.data
                              .cardholders[index].address.country,
                        ),
                        Text(
                          cardsController.cardholder.value!.data
                              .cardholders[index].cardholderId,
                        ),
                        Text(
                          cardsController.cardholder.value!.data
                              .cardholders[index].issuingAppId,
                        ),
                        Text(
                          cardsController.cardholder.value!.data
                              .cardholders[index].emailAddress,
                        ),
                        Text(
                          cardsController
                              .cardholder.value!.data.cardholders[index].phone,
                        ),
                        Text(
                          cardsController.cardholder.value!.data
                              .cardholders[index].identityDetails.dateOfBirth
                              .toString(),
                        ),
                        Text(
                          cardsController.cardholder.value!.data
                              .cardholders[index].identityDetails.idType,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        cardsController
                            .deleteCardHolder(
                          cardsController.cardholder.value!.data
                              .cardholders[index].cardholderId,
                        )
                            .then((value) {
                          cardsController.cardholder.value!.data.cardholders
                              .removeAt(index);
                        });
                      },
                      icon: AvatarGlow(
                        glowColor: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    )

                    // cardsController.cardholder.value!.data
                    //             .cardholders[index].identityDetails.blacklisted ==
                    //         true
                    //     ? const Text(
                    //         'Blacklisted',
                    //       )
                    //     : const Text(
                    //         'Active',
                    //       ),
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}
