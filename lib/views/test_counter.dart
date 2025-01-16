import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestCounterPage extends StatelessWidget {
  const TestCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Btn(
          txtColor: Colors.purple,
          ontap: () {
            cardsController.startCountdown(45); // Start a 5-minute timer.
            showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (BuildContext context) {
                loadingDialogContext = context;
                return AlertDialog(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircularProgressIndicator(
                        backgroundColor: Colors.greenAccent,
                      ),
                      Obx(() {
                        final minutes =
                            cardsController.remainingSeconds.value ~/ 60;
                        final seconds =
                            cardsController.remainingSeconds.value % 60;
                        return Text(
                          'Please wait in... ${seconds.toString().padLeft(2, '0')}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          // style: const TextStyle(
                          //   fontWeight: FontWeight.bold,
                          // ),
                        );
                      })
                    ],
                  ),
                );
              },
            );
          
          
          },
          btnName: 'Test Countdown',
          color: Colors.green,
        ),
      ),
    );
  }
}
