import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/mpesapay/api_caller.dart';
import 'package:flutter/material.dart';

class TestPageTrigger extends StatelessWidget {
  const TestPageTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Btn(
          txtColor: Colors.white,
          ontap: () {
            RequestHandle().mSTKRequest(
              amount: 1,
              phone: '0746071879',
              mTimeStamp: DateTime.now().toString(),
            );
            print('Hello World');
          },
          btnName: 'Trigger STK Push',
          color: Colors.green,
        ),
      ),
    );
  }
}
