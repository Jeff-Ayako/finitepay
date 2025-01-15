import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/views/top_up_balance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentCurrencyPage extends StatelessWidget {
  const CurrentCurrencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(width <= 500 ? 0 : 100.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    child: Icon(
                      Icons.monetization_on_outlined,
                    ),
                  ),
                  const Text('USD Balance'),
                  const Text('USD 0.0'),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Balance ID'),
                          Text('12454545'),
                        ],
                      ),
                      Btn(
                          txtColor: Colors.black,
                          ontap: () {},
                          btnName: 'Copy',
                          color: Colors.amber),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Locked Balance'),
                          Text('USD 0'),
                        ],
                      ),
                      Btn(
                          txtColor: Colors.black,
                          ontap: () {},
                          btnName: 'Copy',
                          color: Colors.amber),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Btn(
                        txtColor: Colors.black,
                        ontap: () {},
                        btnName: 'Make Payout',
                        color: Colors.transparent,
                      ),
                      Btn(
                        txtColor: Colors.black,
                        ontap: () => Get.to(
                          () => const TopUpBalanceScreen(),
                        ),
                        btnName: 'Fund Balance',
                        color: Colors.amber,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
