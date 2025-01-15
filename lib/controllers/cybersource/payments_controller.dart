import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class CybersourceController extends GetxController {
  Future<String> createCyberSourceToken({
  required String apiKey,
  required String apiSecret,
  required String cardNumber,
  required String expiryMonth,
  required String expiryYear,
  required String cardCvv,
  required String currency,
  required double amount,
}) async {
  const String tokenUrl = 'https://api.cybersource.com/v2/payments';  // Sandbox URL

  // Basic authentication header (for CyberSource)
  String basicAuth = 'Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}';

  final response = await http.post(
    Uri.parse(tokenUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': basicAuth,
    },
    body: jsonEncode({
      "clientReferenceInformation": {
        "code": "TC50171_3"
      },
      "processingInformation": {
        "capture": true
      },
      "paymentInformation": {
        "card": {
          "number": cardNumber,
          "expirationMonth": expiryMonth,
          "expirationYear": expiryYear,
          "securityCode": cardCvv
        }
      },
      "orderInformation": {
        "amountDetails": {
          "totalAmount": amount.toString(),
          "currency": currency
        },
        "billTo": {
          "firstName": "John",
          "lastName": "Doe",
          "address1": "123 Main Street",
          "locality": "San Francisco",
          "administrativeArea": "CA",
          "postalCode": "94105",
          "country": "US",
          "email": "test@example.com",
          "phoneNumber": "4155551212"
        }
      }
    }),
  );

  if (response.statusCode == 201) {
    var data = jsonDecode(response.body);
    return data['id'];  // Return payment token (or ID of the transaction)
  } else {
    throw Exception('Failed to create payment token');
  }
}


  Future triggerPayment() async {
    var headers = {
      'v-c-merchant-id': 'testrest',
      'Date': '',
      'Host': 'apitest.cybersource.com',
      'Digest': '',
      'Signature': '',
      'Content-Type': 'application/json',
      'User-Agent': 'Mozilla/5.0'
    };
    var request = http.Request(
        'POST', Uri.parse('https://apitest.cybersource.com/pts/v2/payments/'));
    request.body = json.encode({
      "clientReferenceInformation": {"code": "test_payment"},
      "processingInformation": {"commerceIndicator": "internet"},
      "orderInformation": {
        "billTo": {
          "firstName": "John",
          "lastName": "Doe",
          "address1": "1 Market St",
          "postalCode": "94105",
          "locality": "san francisco",
          "administrativeArea": "CA",
          "country": "US",
          "phoneNumber": "4158880000",
          "company": "Visa",
          "email": "test@cybs.com"
        },
        "amountDetails": {"totalAmount": "102.21", "currency": "USD"}
      },
      "paymentInformation": {
        "card": {
          "expirationYear": "2031",
          "number": "4111111111111111",
          "securityCode": "123",
          "expirationMonth": "12"
        }
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response);
      print(await response.stream.bytesToString());
    } else {
      print(response);
      print(response.reasonPhrase);
    }
  }
}
