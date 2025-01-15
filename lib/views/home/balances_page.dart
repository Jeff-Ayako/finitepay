import 'package:cached_network_image/cached_network_image.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/views/current_currency_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BalancesPage extends StatelessWidget {
  const BalancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 500) {
          return BalanceWidget(
            screenSize: 500,
          );
        } else {
          return BalanceWidget(
            screenSize: 1000,
          );
        }
      },
    ));
  }
}

Widget buildBalancesTable(double screenSize) {
  return Obx(() {
    // currencyCloudController.allMycurrencies.value == null
    //     ? const Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     :

    if (currencyCloudController.allMycurrencies.value != null &&
        screenSize > 500) {
      return DataTable(
        columns: const [
          DataColumn(
            label: Text(
              'Currency',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          DataColumn(
            label: Text(
              'Balance ID',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          DataColumn(
            label: Text(
              'Available Balance',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          DataColumn(
            label: Text(
              'Locked Balance',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          DataColumn(
            label: Text(
              'Ledger Balance',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          DataColumn(label: SizedBox()),
        ],
        rows: currencyCloudController.allMycurrencies.value!.balances
            .asMap()
            .entries
            .map(
          (entry) {
            return DataRow(
              cells: [
                //  buildBalanceRow('USD', '1000001125090004', 'USD 0', 'USD 0', 'USD 0'),
                DataCell(Row(
                  children: [
                    CircleAvatar(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          width: Get.width,
                          height: Get.height,
                          fit: BoxFit.cover,
                          imageUrl: flags[entry.key],
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error_outline_outlined,
                          ),
                        ),
                      ),

                      // Icon(Icons.monetization_on_outlined),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(entry.value.currency),
                  ],
                )),
                DataCell(
                  Text(
                    entry.value.id,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(Text(entry.value.currency)),
                DataCell(Text(entry.value.amount)),
                DataCell(Text(entry.value.currency)),
                DataCell(Text(entry.value.amount)),
              ],
            );
          },
        ).toList(),
      );
    } else if (currencyCloudController.allMycurrencies.value != null &&
        screenSize <= 500) {
      return DataTable(
        columns: const [
          DataColumn(
            label: Text(
              'Currency',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // DataColumn(label: Text('Balance ID')),
          DataColumn(
            label: Text(
              'Balance',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // DataColumn(label: Text('Locked Balance')),
          // DataColumn(label: Text('Ledger Balance')),
          DataColumn(label: SizedBox()),
        ],
        rows: currencyCloudController.allMycurrencies.value!.balances
            .asMap()
            .entries
            .map(
          (entry) {
            return DataRow(
              cells: [
                //  buildBalanceRow('USD', '1000001125090004', 'USD 0', 'USD 0', 'USD 0'),
                DataCell(Row(
                  children: [
                    CircleAvatar(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          width: Get.width,
                          height: Get.height,
                          fit: BoxFit.cover,
                          imageUrl: flags[entry.key],
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error_outline_outlined,
                          ),
                        ),
                      ),

                      // Icon(Icons.monetization_on_outlined),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(entry.value.currency),
                  ],
                )),
                // DataCell(
                //   Text(
                //     entry.value.id,
                //     style: const TextStyle(
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //   ),
                // ),
                // DataCell(Text(entry.value.currency)),
                // DataCell(Text(entry.value.amount)),
                // DataCell(Text(entry.value.currency)),
                DataCell(Text(entry.value.amount)),

                DataCell(
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A31F4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "View",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Btn(
                  //   ontap: () {},
                  //   btnName: 'VIEW DETAILS',
                  //   color: const Color(0xFF5A31F4),
                  //   txtColor: Colors.white,
                  // ),
                ),
              ],
            );
          },
        ).toList(),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  });
}

DataRow buildBalanceRow(String currency, String balanceId,
    String availableBalance, String lockedBalance, String ledgerBalance) {
  return DataRow(
    cells: [
      DataCell(Row(
        children: [
          const CircleAvatar(
            child: Icon(Icons.monetization_on_outlined),
          ),
          // Image.asset('assets/${currency.toLowerCase()}_flag.png', width: 30),
          const SizedBox(width: 10),
          Text(currency),
        ],
      )),
      DataCell(Text(balanceId)),
      DataCell(Text(availableBalance)),
      DataCell(Text(lockedBalance)),
      DataCell(Text(ledgerBalance)),
      DataCell(ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text("VIEW DETAILS"),
      )),
    ],
  );
}

// ignore: must_be_immutable
class BalanceWidget extends StatelessWidget {
  BalanceWidget({super.key, required this.screenSize});

  double screenSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Sidebar

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Get exclusive access to services that can help your business grow',
                          style: TextStyle(
                            color: Colors.purple,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text('Learn More',
                                style: TextStyle(color: Colors.purple)),
                            Icon(Icons.arrow_forward, color: Colors.purple),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Balance',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    screenSize <= 500
                        ? Container()
                        : Row(
                            children: [
                              Btn(
                                txtColor: Colors.black,
                                ontap: () {},
                                btnName: 'Create New Balance',
                                color: Colors.transparent,
                              ),
                              const SizedBox(width: 10),
                              Btn(
                                txtColor: Colors.white,
                                ontap: () => Get.to(
                                  () => const CurrentCurrencyPage(),
                                ),
                                btnName: 'Fund Balance',
                                color: const Color(0xFF5A31F4),
                              ),
                            ],
                          ),
                  ],
                ),
                const SizedBox(height: 20),
                screenSize <= 500
                    ? Row(
                        children: [
                          Btn(
                            txtColor: Colors.black,
                            ontap: () {},
                            btnName: 'Create New Balance',
                            color: Colors.transparent,
                          ),
                          const SizedBox(width: 10),
                          Btn(
                            txtColor: Colors.white,
                            ontap: () => Get.to(
                              () => const CurrentCurrencyPage(),
                            ),
                            btnName: 'Fund Balance',
                            color: const Color(0xFF5A31F4),
                          ),
                        ],
                      )
                    : Container(),
                DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        isScrollable: true,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                          color: const Color(0xFF5A31F4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tabs: const [
                          Tab(text: "  My Balances  "),
                          Tab(text: "  Balance Funding History  "),
                          Tab(text: "  Generate Statement  "),
                        ],
                      ),
                      SizedBox(
                        height:
                            Get.height, // Adjust this height based on content
                        child: TabBarView(
                          children: [
                            // My Balances Tab
                            buildBalancesTable(screenSize),
                            // Balance Funding History Tab
                            const Center(
                                child: Text("Balance Funding History")),
                            // Generate Statement Tab
                            const Center(child: Text("Generate Statement")),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
