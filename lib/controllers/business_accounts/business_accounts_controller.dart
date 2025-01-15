import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class BusinessAccountsController extends GetxController {
  Future<Map<String, dynamic>> createBusinessFunction(
      String cardHolderID, String currencyType) async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/sandbox/business/create_business');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_test_592d60952bfc6138f84a9cd1dcae47f05bd1e8fb9a9010aef9c0f45cb3d642a5834a284f6d0f247d3d274fff27ee9603497f9c602bdf0dedb2462971352f5ea28c46447f9feae35b83b5c86395dc27bf539bf58f0fbfb7c3d30541bb30a98fa1e708a45ed5f5c66a257af216e9a27e138a229d3f211b47852a48d0df9a3a1b8d1714c5a74652ef465d100611ee1505368b7344d88f4fcccb252f9e39d0bb9b546c6475d90401f494d38836dbc7d1ed8befa7600cb73e541fd387a172089dbde20420a01225ae10190f4befd11ad16a759474e090dc21548bcde3f1ca8160a1d71609eaf4122d97e9a9f2e1bd5e18b36e37c965acaf6e17ff68e76c4415f970e2'
    };

    final body = jsonEncode({
      "company_name": "TechNova Solutions Ltd",
      "unique_business_owners": [
        cardHolderID,
      ],
      "unique_business_owners_percentage_split": [
        100,
      ],
      "business_details": {
        "business_type": "SoleProprietor",
        "industry": "HotelMotel",
        "registration_number": "28938478123456",
        "tax_identification_number": "12-3456789",
        "incorporation_country": "US",
        "incorporation_certificate": "https://image.com",
        "business_address": {
          "address": "1845 Innovation Drive",
          "lga": "",
          "city": "Nairobi",
          "state": "Nairobi",
          "country": "Kenya",
          "postal_code": "78701",
          "house_no": "1845"
        },
        "registered_address": {
          "address": "1845 Innovation Drive",
          "lga": "",
          "city": "Nairobi",
          "state": "Nairobi",
          "country": "Kenya",
          "postal_code": "78701",
          "house_no": "1845"
        },
        "date_of_incorporation": "2024-01-15",
        "company_phone_no": "+254746071879",
        "company_email_address": "info@technova-solutions.com",
        "business_website": "https://www.technova-solutions.com",
        "description":
            "TechNova Solutions specializes in innovative software solutions for the hospitality industry, focusing on AI-driven guest experience enhancement and operational efficiency."
      },
      "meta_data": {}
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        FirebaseFirestore.instance
            .collection('BusinessAccounts')
            .doc(data['data']['business_id'])
            .set({
          'BusinessID': data['data']['business_id'],
          'creatorEmail': fAuth.currentUser?.email ?? '',
          'creatorUID': fAuth.currentUser?.uid ?? '',
        });
        Get.snackbar(
          'Success',
          'Business Created successfully',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to create a Business.'}',
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

  Future<Map<String, dynamic>> createBusinessAccount(
    String cardHolderID,
  ) async {
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
      "holder_type": "business",
      "label": "Business account",
      "currency": "USD"
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        // FirebaseFirestore.instance
        //     .collection('BusinessAccounts')
        //     .doc(data['data']['business_id'])
        //     .set({
        //   'BusinessID': data['data']['business_id'],
        //   'creatorEmail': fAuth.currentUser?.email ?? '',
        //   'creatorUID': fAuth.currentUser?.uid ?? '',
        // });
        Get.snackbar(
          'Success',
          'Business Acount Created successfully',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to create a Business Acount.'}',
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

  Future<Map<String, dynamic>> fetchBusinessAccountDetails(
    String businessID,
  ) async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/sandbox/account/$businessID');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_test_592d60952bfc6138f84a9cd1dcae47f05bd1e8fb9a9010aef9c0f45cb3d642a5834a284f6d0f247d3d274fff27ee9603497f9c602bdf0dedb2462971352f5ea28c46447f9feae35b83b5c86395dc27bf539bf58f0fbfb7c3d30541bb30a98fa1e708a45ed5f5c66a257af216e9a27e138a229d3f211b47852a48d0df9a3a1b8d1714c5a74652ef465d100611ee1505368b7344d88f4fcccb252f9e39d0bb9b546c6475d90401f494d38836dbc7d1ed8befa7600cb73e541fd387a172089dbde20420a01225ae10190f4befd11ad16a759474e090dc21548bcde3f1ca8160a1d71609eaf4122d97e9a9f2e1bd5e18b36e37c965acaf6e17ff68e76c4415f970e2'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          'Business Acount Created successfully',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to create a Business Acount.'}',
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

  Future<Map<String, dynamic>> fetchAccountBalance(
    String accountID,
  ) async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/sandbox/account/$accountID/balance/');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_test_592d60952bfc6138f84a9cd1dcae47f05bd1e8fb9a9010aef9c0f45cb3d642a5834a284f6d0f247d3d274fff27ee9603497f9c602bdf0dedb2462971352f5ea28c46447f9feae35b83b5c86395dc27bf539bf58f0fbfb7c3d30541bb30a98fa1e708a45ed5f5c66a257af216e9a27e138a229d3f211b47852a48d0df9a3a1b8d1714c5a74652ef465d100611ee1505368b7344d88f4fcccb252f9e39d0bb9b546c6475d90401f494d38836dbc7d1ed8befa7600cb73e541fd387a172089dbde20420a01225ae10190f4befd11ad16a759474e090dc21548bcde3f1ca8160a1d71609eaf4122d97e9a9f2e1bd5e18b36e37c965acaf6e17ff68e76c4415f970e2'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          'Fetched Account details successfully',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to fetch Account Details.'}',
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

  Future<Map<String, dynamic>> mockAccountCredit(
    String accountID,
  ) async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/sandbox/account/mock/credit');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_test_592d60952bfc6138f84a9cd1dcae47f05bd1e8fb9a9010aef9c0f45cb3d642a5834a284f6d0f247d3d274fff27ee9603497f9c602bdf0dedb2462971352f5ea28c46447f9feae35b83b5c86395dc27bf539bf58f0fbfb7c3d30541bb30a98fa1e708a45ed5f5c66a257af216e9a27e138a229d3f211b47852a48d0df9a3a1b8d1714c5a74652ef465d100611ee1505368b7344d88f4fcccb252f9e39d0bb9b546c6475d90401f494d38836dbc7d1ed8befa7600cb73e541fd387a172089dbde20420a01225ae10190f4befd11ad16a759474e090dc21548bcde3f1ca8160a1d71609eaf4122d97e9a9f2e1bd5e18b36e37c965acaf6e17ff68e76c4415f970e2'
    };

    final body = jsonEncode({
      "account_id": accountID,
      "description": "Transaction",
      "sender_name": "Sam G",
      "amount": "1000"
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          'Trascation Mocked successfully',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to fetch Account Details.'}',
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

  Future<Map<String, dynamic>> fetchAccountTransactions(
    String accountID,
  ) async {
    final url = Uri.parse(
        'https://bridgecard-issuing-app.com/accounts-service/v1/issuing/sandbox/account/$accountID/transactions/1/');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_test_592d60952bfc6138f84a9cd1dcae47f05bd1e8fb9a9010aef9c0f45cb3d642a5834a284f6d0f247d3d274fff27ee9603497f9c602bdf0dedb2462971352f5ea28c46447f9feae35b83b5c86395dc27bf539bf58f0fbfb7c3d30541bb30a98fa1e708a45ed5f5c66a257af216e9a27e138a229d3f211b47852a48d0df9a3a1b8d1714c5a74652ef465d100611ee1505368b7344d88f4fcccb252f9e39d0bb9b546c6475d90401f494d38836dbc7d1ed8befa7600cb73e541fd387a172089dbde20420a01225ae10190f4befd11ad16a759474e090dc21548bcde3f1ca8160a1d71609eaf4122d97e9a9f2e1bd5e18b36e37c965acaf6e17ff68e76c4415f970e2'
    };

    //   final body = jsonEncode({
    //   "account_id": accountID,
    //   "description": "Transaction",
    //   "sender_name": "Sam G",
    //   "amount": "1000"
    // });

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          'Trascations Fetched Successfully',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Fetch Trascations Details.'}',
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

  Future<Map<String, dynamic>> fetchTransactionByID(
      String accountID, String transcationRef) async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/sandbox/account/$accountID/transaction/$transcationRef');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_test_592d60952bfc6138f84a9cd1dcae47f05bd1e8fb9a9010aef9c0f45cb3d642a5834a284f6d0f247d3d274fff27ee9603497f9c602bdf0dedb2462971352f5ea28c46447f9feae35b83b5c86395dc27bf539bf58f0fbfb7c3d30541bb30a98fa1e708a45ed5f5c66a257af216e9a27e138a229d3f211b47852a48d0df9a3a1b8d1714c5a74652ef465d100611ee1505368b7344d88f4fcccb252f9e39d0bb9b546c6475d90401f494d38836dbc7d1ed8befa7600cb73e541fd387a172089dbde20420a01225ae10190f4befd11ad16a759474e090dc21548bcde3f1ca8160a1d71609eaf4122d97e9a9f2e1bd5e18b36e37c965acaf6e17ff68e76c4415f970e2'
    };

    //   final body = jsonEncode({
    //   "account_id": accountID,
    //   "description": "Transaction",
    //   "sender_name": "Sam G",
    //   "amount": "1000"
    // });

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          'Trascation Fetched Successfully',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Fetch Trascation Details.'}',
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

  Future<Map<String, dynamic>> addBeneficiary(
      String accountID, String transcationRef) async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/sandbox/account/transfers/add_beneficiary');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_test_592d60952bfc6138f84a9cd1dcae47f05bd1e8fb9a9010aef9c0f45cb3d642a5834a284f6d0f247d3d274fff27ee9603497f9c602bdf0dedb2462971352f5ea28c46447f9feae35b83b5c86395dc27bf539bf58f0fbfb7c3d30541bb30a98fa1e708a45ed5f5c66a257af216e9a27e138a229d3f211b47852a48d0df9a3a1b8d1714c5a74652ef465d100611ee1505368b7344d88f4fcccb252f9e39d0bb9b546c6475d90401f494d38836dbc7d1ed8befa7600cb73e541fd387a172089dbde20420a01225ae10190f4befd11ad16a759474e090dc21548bcde3f1ca8160a1d71609eaf4122d97e9a9f2e1bd5e18b36e37c965acaf6e17ff68e76c4415f970e2'
    };

    final body = jsonEncode({
      "account_id": accountID,
      "method": "Domestic Wire or International or ACH",
      "bank_address": {
        "line1": "1200 Capitol Avenue",
        "line2": "Suite 400",
        "city": "Austin",
        "state": "Texas",
        "country": "United States",
        "postal_code": "78701"
      },
      "beneficiary_address": {
        "line1": "1845 Innovation Drive",
        "line2": "Floor 3",
        "city": "Austin",
        "state": "Texas",
        "country": "United States",
        "postal_code": "78701"
      },
      "account_number": "1234567890",
      "routing_number": "111000025",
      "beneficiary_name": "TechNova Solutions Ltd",
      "bank_name": "Bank of America",
      "label": "Operations Account",
      "invoice": "https://google.com"
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          'Trascation Fetched Successfully',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Fetch Trascation Details.'}',
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

  Future<Map<String, dynamic>> fetchAllBeneficiaries(
      String accountID, String transcationRef) async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/sandbox/account/$accountID/transfers/beneficiaries');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_test_592d60952bfc6138f84a9cd1dcae47f05bd1e8fb9a9010aef9c0f45cb3d642a5834a284f6d0f247d3d274fff27ee9603497f9c602bdf0dedb2462971352f5ea28c46447f9feae35b83b5c86395dc27bf539bf58f0fbfb7c3d30541bb30a98fa1e708a45ed5f5c66a257af216e9a27e138a229d3f211b47852a48d0df9a3a1b8d1714c5a74652ef465d100611ee1505368b7344d88f4fcccb252f9e39d0bb9b546c6475d90401f494d38836dbc7d1ed8befa7600cb73e541fd387a172089dbde20420a01225ae10190f4befd11ad16a759474e090dc21548bcde3f1ca8160a1d71609eaf4122d97e9a9f2e1bd5e18b36e37c965acaf6e17ff68e76c4415f970e2'
    };

    //   final body = jsonEncode({
    //   "account_id": accountID,
    //   "description": "Transaction",
    //   "sender_name": "Sam G",
    //   "amount": "1000"
    // });

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          'Beneficiaries Fetched Successfully',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Fetch Beneficiaries Details.'}',
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

  Future<Map<String, dynamic>> makeTransferFunction(
      String accountID, String beneficiaryID) async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/sandbox/account/transfers');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_test_592d60952bfc6138f84a9cd1dcae47f05bd1e8fb9a9010aef9c0f45cb3d642a5834a284f6d0f247d3d274fff27ee9603497f9c602bdf0dedb2462971352f5ea28c46447f9feae35b83b5c86395dc27bf539bf58f0fbfb7c3d30541bb30a98fa1e708a45ed5f5c66a257af216e9a27e138a229d3f211b47852a48d0df9a3a1b8d1714c5a74652ef465d100611ee1505368b7344d88f4fcccb252f9e39d0bb9b546c6475d90401f494d38836dbc7d1ed8befa7600cb73e541fd387a172089dbde20420a01225ae10190f4befd11ad16a759474e090dc21548bcde3f1ca8160a1d71609eaf4122d97e9a9f2e1bd5e18b36e37c965acaf6e17ff68e76c4415f970e2'
    };

    final body = jsonEncode({
      "account_id": accountID,
      "beneficiary_id": beneficiaryID,
      "amount": "20000",
      "memo": "description",
      "transaction_reference": "transfer"
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          'Beneficiaries Fetched Successfully',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Fetch Beneficiaries Details.'}',
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

  Future<Map<String, dynamic>> getFXRates(
      String accountID, String beneficiaryID) async {
    final url = Uri.parse(
        'https://bridgecard-issuing-app.com/accounts-service/v1/issuing/get_fx_rate');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_test_592d60952bfc6138f84a9cd1dcae47f05bd1e8fb9a9010aef9c0f45cb3d642a5834a284f6d0f247d3d274fff27ee9603497f9c602bdf0dedb2462971352f5ea28c46447f9feae35b83b5c86395dc27bf539bf58f0fbfb7c3d30541bb30a98fa1e708a45ed5f5c66a257af216e9a27e138a229d3f211b47852a48d0df9a3a1b8d1714c5a74652ef465d100611ee1505368b7344d88f4fcccb252f9e39d0bb9b546c6475d90401f494d38836dbc7d1ed8befa7600cb73e541fd387a172089dbde20420a01225ae10190f4befd11ad16a759474e090dc21548bcde3f1ca8160a1d71609eaf4122d97e9a9f2e1bd5e18b36e37c965acaf6e17ff68e76c4415f970e2'
    };

    // final body = jsonEncode({
    //   "account_id": accountID,
    //   "beneficiary_id": beneficiaryID,
    //   "amount": "20000",
    //   "memo": "description",
    //   "transaction_reference": "transfer"
    // });

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          'Fetched FX Rates Successfully',
          backgroundColor: Colors.green,
        );
        print(response.body.toString());
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Fetch FX rates.'}',
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
