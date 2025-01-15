// import 'package:finitepay/bridgecards_test/create_card_holder_page.dart';.\
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NoCardAvailablePage extends StatelessWidget {
  const NoCardAvailablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/fwhitelogo.png',
              color: Colors.deepPurple,
              height: 100,
            ),
            // const Divider(),
            Lottie.asset('assets/cards.json', height: 300),
            const Text(
              'Have No Card Create one Now',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Divider(),
            Btn(
              txtColor: Colors.white,
              ontap: () {
                maincontroller.shouldCreateCard.toggle();
              },
              btnName: 'Create a Virtual Card',
              color: Colors.deepPurple,
            )
          ],
        ),
      ),
    );
  }
}
