import 'package:finitepay/global/payouts_opt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class PayoutPage extends StatelessWidget {
  const PayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Center(
          child: GridView.builder(
            itemCount: payoutopts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 16 / 9, crossAxisCount: 3),
            itemBuilder: (context, index) {
              //
              return PayoutOption(
                icon: payoutopts[index].icon,
                subtitle: payoutopts[index].subtitle,
                title: payoutopts[index].title,
              );
            },
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PayoutOption extends StatelessWidget {
  PayoutOption({
    super.key,
    required this.icon,
    required this.subtitle,
    required this.title,
  });

  String title;
  String subtitle;

  Icon icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Get.bottomSheet(
            Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'helllo',
                          border: OutlineInputBorder(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          print('Hello there bro');
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: icon,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey
                    // fontSize: 25,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
