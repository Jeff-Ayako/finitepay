import 'package:cached_network_image/cached_network_image.dart';
import 'package:finitepay/bridgecards_test/create_card_holder_page.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCountryPage extends StatelessWidget {
  const UserCountryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Select CardHolder Country",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
        body: Center(
          child: ListView.builder(
            itemCount: cardsController.flags.length,
            itemBuilder: (context, index) {
              return countryCard(index, cardsController.flags[index]);
            },
          ),
        ));
  }

  Widget countryCard(int index, Map country) {
    return ListTile(
      onTap: () => Get.to(
        () => CreateCardHolderPage(
          country: country['country'],
        ),
      ),
      leading: CircleAvatar(
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: country['flag'],
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ), //Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(url)),),),
      ),
      title: Text(
        country['country'],
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
