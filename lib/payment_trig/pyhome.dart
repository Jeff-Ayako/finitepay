import 'package:finitepay/controllers/init_controllers.dart';
import 'package:flutter/material.dart';

class PyhomeTest extends StatelessWidget {
  const PyhomeTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            cardsController.registerCardHolder();
          },
          child: const Text('Create Card User'),
        ),
      ),
    );
  }
}



// Bridgecard production url https://issuecards.api.bridgecard.co/v1/issuing
// Sandbox testing environment https://issuecards.api.bridgecard.co/v1/issuing/sandbox




