import 'package:flutter/material.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: OverviewPage(),
//     );
//   }
// }

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
              'assets/finitepay_logo.png'), // Replace with your logo asset
        ),
        title: Row(
          children: [
            const Text(
              'finitepay',
              style: TextStyle(
                  color: Colors.purple,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Test Mode',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Integration Support',
                style: TextStyle(color: Colors.grey[800])),
          ),
          TextButton(
            onPressed: () {},
            child: Text('API Documentation',
                style: TextStyle(color: Colors.grey[800])),
          ),
          Switch(
              value: false, onChanged: (value) {}, activeColor: Colors.purple),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.grey[800]),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text("J"), // Placeholder for user avatar or initials
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 220,
            color: Colors.grey[50],
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const ListTile(
                  title:
                      Text("Onboarding", style: TextStyle(color: Colors.grey)),
                  leading: Icon(Icons.work_outline, color: Colors.grey),
                ),
                ListTile(
                  title:
                      const Text("Overview", style: TextStyle(color: Colors.purple)),
                  leading: const Icon(Icons.dashboard_outlined, color: Colors.purple),
                  tileColor: Colors.purple[50],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                const ListTile(
                  title: Text("Balances"),
                  leading: Icon(Icons.account_balance_wallet_outlined),
                ),
                const ExpansionTile(
                  title: Text("Pay-Ins"),
                  leading: Icon(Icons.attach_money_outlined),
                  children: [
                    ListTile(title: Text("Option 1")),
                    ListTile(title: Text("Option 2")),
                  ],
                ),
                const ExpansionTile(
                  title: Text("Pay-Outs"),
                  leading: Icon(Icons.money_outlined),
                  children: [
                    ListTile(title: Text("Option 1")),
                    ListTile(title: Text("Option 2")),
                  ],
                ),
                const ListTile(
                  title: Text("Conversions"),
                  leading: Icon(Icons.swap_horiz),
                ),
                const ListTile(
                  title: Text("Settlements"),
                  leading: Icon(Icons.receipt_long),
                ),
                const ListTile(
                  title: Text("Users And Roles"),
                  leading: Icon(Icons.people_outline),
                ),
              ],
            ),
          ),
          // Main Content
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
                        const Text(
                          'Get exclusive access to services that can help your business grow',
                          style: TextStyle(color: Colors.purple),
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
                  const Text(
                    "Hello, Jeff Ayako!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Here’s how Finitepay is performing",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Balances',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Make Payout"),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Fund Balance"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      buildBalanceCard('US', '0', 'assets/us_flag.png'),
                      buildBalanceCard('£', '0', 'assets/uk_flag.png'),
                      buildBalanceCard('₦', '0', 'assets/ng_flag.png'),
                      buildBalanceCard('€', '0', 'assets/eu_flag.png'),
                      buildBalanceCard('GHS', '0', 'assets/gh_flag.png'),
                      buildBalanceCard('KES', '0', 'assets/ke_flag.png'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("View All Balances"),
                    ),
                  ),
                ],
              ),
            ), 
          ),
        ],
      ),
    );
  }

  Widget buildBalanceCard(String currency, String amount, String flagAsset) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(flagAsset, width: 30, height: 20),
                const Spacer(),
                const Icon(Icons.more_vert),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Available Balance',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 5),
            Text(
              '$currency $amount',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              'Ledger: $currency $amount',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 5),
            Text(
              'Locked: $currency $amount',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 5),
            Text(
              'Rolling Reserve: $currency $amount',
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
