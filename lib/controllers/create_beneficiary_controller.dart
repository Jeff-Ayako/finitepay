import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class CreateBeneficiaryController extends GetxController{

// Function to create a new beneficiary in Currencycloud
Future<void> createBeneficiary(
    String authToken,
    String name,
    String bankAccountHolderName,
    String currency,
    String beneficiaryCountry,
    String accountNumber,
    String routingCodeType,
    String routingCodeValue) async {
  
  // Currencycloud API endpoint for creating beneficiaries
  var url = Uri.parse('https://api.currencycloud.com/v2/beneficiaries/create');

  // Create the request body
  var body = jsonEncode({
    'name': name,
    'bank_account_holder_name': bankAccountHolderName,
    'currency': currency,
    'beneficiary_country': beneficiaryCountry,
    'account_number': accountNumber,
    'routing_code_type_1': routingCodeType,
    'routing_code_value_1': routingCodeValue,
    // Add more fields as required by your use case
  });

  // Send POST request
  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'X-Auth-Token': authToken, // Authorization token from Currencycloud
    },
    body: body,
  );

  // Check the response status
  if (response.statusCode == 200) {
    // Parse the response body (beneficiary creation success)
    var data = jsonDecode(response.body);
    print('Beneficiary created successfully: $data');
  } else {
    // Handle error response
    print('Failed to create beneficiary. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
}