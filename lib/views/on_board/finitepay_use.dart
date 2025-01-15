import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinitePayUse extends StatelessWidget {
  const FinitePayUse({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // MaterialApp(
        //   home:
        //   Scaffold(
        // backgroundColor: Colors.grey[200],
        // appBar: AppBar(
        //   title: const Text('Use of FinitePay'),
        //   backgroundColor: Colors.white,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     color: Colors.black,
        //     onPressed: () {},
        //   ),
        // ),
        // body:
        Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How Will You Use FinitePay?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'This helps us tailor a better experience for your business',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const Divider(thickness: 1, height: 32),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth <= 500) {
                  return layoutpage(context, 500);
                } else {
                  return layoutpage(context, 1000);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget layoutpage(BuildContext context, double size) {
    return size == 500
        ? SizedBox(
            height: Get.height,
            width: Get.width,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: Get.height / 3,
                    child: _buildOptionCard(
                      context: context,
                      icon: Icons.account_balance_wallet,
                      title: 'Pay-Ins',
                      description:
                          'To receive payments directly from businesses and individuals',
                      options: [
                        'Virtual Accounts',
                        'Checkout (Cards)',
                        'Checkout (Bank Transfer)',
                        'Checkout (Mobile Money)',
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 3,
                    child: _buildOptionCard(
                      context: context,
                      icon: Icons.payment,
                      title: 'Pay-Outs',
                      description:
                          'To send money directly into beneficiary accounts',
                      options: [
                        'Local Pay-Outs',
                        'International Pay-outs',
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 3,
                    child: _buildOptionCard(
                      context: context,
                      icon: Icons.currency_exchange,
                      title: 'Conversions',
                      description:
                          'Move money from one currency to another within the system',
                      options: [
                        'Multi-Currency Conversion',
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOptionCard(
                context: context,
                icon: Icons.account_balance_wallet,
                title: 'Pay-Ins',
                description:
                    'To receive payments directly from businesses and individuals',
                options: [
                  'Virtual Accounts',
                  'Checkout (Cards)',
                  'Checkout (Bank Transfer)',
                  'Checkout (Mobile Money)',
                ],
              ),
              _buildOptionCard(
                context: context,
                icon: Icons.payment,
                title: 'Pay-Outs',
                description: 'To send money directly into beneficiary accounts',
                options: [
                  'Local Pay-Outs',
                  'International Pay-outs',
                ],
              ),
              _buildOptionCard(
                context: context,
                icon: Icons.currency_exchange,
                title: 'Conversions',
                description:
                    'Move money from one currency to another within the system',
                options: [
                  'Multi-Currency Conversion',
                ],
              ),
            ],
          );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required List<String> options,
  }) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.purple,
                  size: 40,
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 16),
                ...options.map((option) {
                  return Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (bool? value) {},
                      ),
                      Text(option),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
