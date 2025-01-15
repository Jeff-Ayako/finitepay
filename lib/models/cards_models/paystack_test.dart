import 'dart:convert';
import 'package:http/http.dart' as http;

 const String paystackSecretKey = 'sk_live_1be4d6b8e05e6e44f5820a33adeb97c59261b190';

class PaystackService {
  final String paystackSecretKey = 'sk_live_1be4d6b8e05e6e44f5820a33adeb97c59261b190';

  Future<Map<String, dynamic>> initiateWithdrawal({
    required String amount,
    required String recipientCode, // The Paystack recipient code
  }) async {
    final url = Uri.parse('https://api.paystack.co/transfer');

    final headers = {
      'Authorization': 'Bearer $paystackSecretKey',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'source': 'balance',
      'amount': amount,
      'recipient': recipientCode,
      'reason': 'Withdrawal to M-Pesa',
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to initiate withdrawal: ${response.body}');
    }
  }
}

Future<Map<String, dynamic>> createRecipient({
  required String name,
  required String accountNumber, // M-Pesa number
  required String bankCode,      // Bank code for M-Pesa (e.g., 'MPESA')
}) async {
  final url = Uri.parse('https://api.paystack.co/transferrecipient');

  final headers = {
    'Authorization': 'Bearer $paystackSecretKey',
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    'type': 'mobile_money',
    'name': name,
    'account_number': accountNumber,
    'bank_code': bankCode,
    'currency': 'KES',
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to create recipient: ${response.body}');
  }
}

