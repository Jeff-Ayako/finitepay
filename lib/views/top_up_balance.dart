import 'package:finitepay/components/overrall_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopUpBalanceScreen extends StatefulWidget {
  const TopUpBalanceScreen({super.key});

  @override
  _TopUpBalanceScreenState createState() => _TopUpBalanceScreenState();
}

class _TopUpBalanceScreenState extends State<TopUpBalanceScreen> {
  String selectedCurrency = 'USD';
  String selectedFundingOption = 'FinitePay Account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Top-up Balance',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left section for balance and funding options
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dropdown for currency selection
                    const Text(
                      'Balance*',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedCurrency,
                        underline: const SizedBox(),
                        items:
                            <String>['USD', 'EUR', 'GBP'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCurrency = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Funding options
                    const Text(
                      'Fund via',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            title: const Text('Fund via FinitePay Account'),
                            value: 'FinitePay Account',
                            groupValue: selectedFundingOption,
                            activeColor: Colors.amber,
                            onChanged: (String? value) {
                              setState(() {
                                selectedFundingOption = value!;
                              });
                            },
                          ),
                          const Divider(),
                          RadioListTile<String>(
                            title: const Text('Fund via Virtual Account'),
                            value: 'Virtual Account',
                            groupValue: selectedFundingOption,
                            activeColor: Colors.amber,
                            onChanged: (String? value) {
                              setState(() {
                                selectedFundingOption = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Right section for dynamic content based on selection
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display account details or request virtual account screen based on selection
                    if (selectedFundingOption == 'FinitePay Account')
                      _buildFinitePayAccountDetails()
                    else
                      _buildRequestVirtualAccount(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build FinitePay Account Details UI
  Widget _buildFinitePayAccountDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextRowWithCopy('Bank Name', 'Test Clear Bank London'),
          _buildTextRowWithCopy(
              'Account Name', 'FinitePay Technologies Limited'),
          _buildTextRowWithCopy('Swift Code', 'TESTGB22'),
          _buildTextRowWithCopy('IBAN', 'GB123456789EDF3345677'),
          _buildTextRowWithCopy('Correspondent Bank Swift', 'TESTGB2L'),
          _buildTextRowWithCopy('Country', 'United Kingdom'),
          _buildTextRowWithCopy('Currency', 'USD'),
          _buildTextRowWithCopy('Reference', '133323686118'),
          Btn(
             txtColor: Colors.black,
            ontap: () {},
            btnName: 'I\'ve Made Payment',
            color: Colors.transparent,
          )
        ],
      ),
    );
  }

  // Function to build the Request Virtual Account UI
  Widget _buildRequestVirtualAccount() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 60,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 16),
          const Text(
            'Request A Virtual Bank Account To Continue',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'You can top up your balance by simply funding your virtual bank account. The virtual bank account can also be used for your payment collections.',
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
              width: double.infinity,
              child: Btn(
                 txtColor: Colors.white,
                ontap: () {},
                btnName: 'Request Account',
                color: const Color(0xFF5A31F4),
              )
              // ElevatedButton(
              //   onPressed: () {
              //     // Handle request account logic here
              //   },
              //   child: Text(
              //     "Request Account",
              //     style: TextStyle(fontSize: 16),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     padding: EdgeInsets.all(16),
              //     backgroundColor: Theme.of(context).primaryColor,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              // ),

              ),
        ],
      ),
    );
  }

  // This function will allow copying text to the clipboard
  void _copyToClipboard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard!'),
      ),
    );
  }

  // Helper function to build the text with copy icon
  Widget _buildTextRowWithCopy(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy, size: 20, color: Colors.grey[600]),
                  onPressed: () {
                    _copyToClipboard(value, context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
