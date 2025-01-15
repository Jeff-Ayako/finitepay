import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class UsdEuroController extends GetxController {
  Future<Map<String, dynamic>> upGradingCardHolder(String cardHolderID) async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/sandbox/cardholder/upgrade_cardholder');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_test_592d60952bfc6138f84a9cd1dcae47f05bd1e8fb9a9010aef9c0f45cb3d642a5834a284f6d0f247d3d274fff27ee9603497f9c602bdf0dedb2462971352f5ea28c46447f9feae35b83b5c86395dc27bf539bf58f0fbfb7c3d30541bb30a98fa1e708a45ed5f5c66a257af216e9a27e138a229d3f211b47852a48d0df9a3a1b8d1714c5a74652ef465d100611ee1505368b7344d88f4fcccb252f9e39d0bb9b546c6475d90401f494d38836dbc7d1ed8befa7600cb73e541fd387a172089dbde20420a01225ae10190f4befd11ad16a759474e090dc21548bcde3f1ca8160a1d71609eaf4122d97e9a9f2e1bd5e18b36e37c965acaf6e17ff68e76c4415f970e2'
    };

    final body = jsonEncode({
      "cardholder_id": cardHolderID,
      "utility_bill":
          "https://i.pinimg.com/736x/2d/6d/e2/2d6de2dc050485f9b57065b310af18bf--utility-bill-bill-obrien.jpg",
      "bank_statement":
          "https://i.pinimg.com/474x/d2/5b/91/d25b912a167028d264b22c43bdd2fa5f.jpg",
      "occupation": "Developer",
      "income_band": "500000",
      "employment_status": "employed",
      "account_designation": "Payroll Account",
      "income_source": "Salary",
      "address": {
        "address": "Ruiru Kiambu",
        "lga": "",
        "city": "Nairobi",
        "state": "Nairobi",
        "country": "Kenya",
        "postal_code": "122920",
        "house_no": "12"
      },
      "selfie_image":
          "https://image.com", //this is optional and only required if the url you sent us at creation expires,
      "id_image":
          "https://image.com", //this is optional and only required if the url you sent us at creation expires,
      "back_id_image":
          "https://image.com", //this is optional and only required if the url you sent us at creation expires,
      "id_number":
          "https://image.com", //this is optional and only required if the url you sent us at creation expires,
      "issued_date": "2021-05-30",
      "expiry_date": "2028-05-30",
      "date_of_birth": "2000-01-01",
      "id_type": "KENYAN_NATIONAL_ID"
    });

    try {
      final response = await http.patch(url, headers: headers, body: body);

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        Get.snackbar(
          'Success',
          'Cardholder Upgrade Successfully.',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Upgrade cardholder.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

  Future<Map<String, dynamic>> createEuroDollarAccount(
      String cardHolderID, String currencyType) async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/sandbox/account');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_test_592d60952bfc6138f84a9cd1dcae47f05bd1e8fb9a9010aef9c0f45cb3d642a5834a284f6d0f247d3d274fff27ee9603497f9c602bdf0dedb2462971352f5ea28c46447f9feae35b83b5c86395dc27bf539bf58f0fbfb7c3d30541bb30a98fa1e708a45ed5f5c66a257af216e9a27e138a229d3f211b47852a48d0df9a3a1b8d1714c5a74652ef465d100611ee1505368b7344d88f4fcccb252f9e39d0bb9b546c6475d90401f494d38836dbc7d1ed8befa7600cb73e541fd387a172089dbde20420a01225ae10190f4befd11ad16a759474e090dc21548bcde3f1ca8160a1d71609eaf4122d97e9a9f2e1bd5e18b36e37c965acaf6e17ff68e76c4415f970e2'
    };

    final body = jsonEncode({
      "holder_id": cardHolderID,
      "holder_type": "personal",
      "label": "Salary Account",
      "currency": currencyType
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        Get.snackbar(
          'Success',
          '$currencyType account is currently being processed.',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to create $currencyType Account.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }


}
