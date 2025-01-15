import 'dart:convert';

import 'package:finitepay/bridgecards_test/card_payment.dart';
import 'package:finitepay/controllers/fx_conversion_success_payload.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/main.dart';
import 'package:finitepay/models/detailed_fx_quote.dart';
import 'package:finitepay/models/exchangerate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;

class FxController extends GetxController {
  TextEditingController fromAmountController = TextEditingController();
  TextEditingController toAmountController = TextEditingController();
  final fxlistRates = [].obs;
  final currencyPair = ''.obs;
  final exchangeRates = Rxn<ExchangeRateModel>();
  final detailedFxquote = Rxn<DetailedFxQuote>();
  final conversionPayload = Rxn<ConversionPayload>();

  late Future<Map<String, dynamic>> fxRates;

  calculateAmountPayout() {
    if (fromAmountController.value.text.isNotEmpty) {
      toAmountController.text =
          '${double.parse(fromAmountController.text.toString()) * double.parse(fxController.fxlistRates.value[1].toString())}';
    }
  }

// Function to fetch FX rates from an API
  Future<Map<String, dynamic>> fetchFXRates() async {
    // Fixer.io API endpoint to get latest foreign exchange rates
    const String apiKey =
        '65ef5a5d35e9f3dca9d15bf290b1ba9c'; // Replace with your API key
    const String url = 'http://data.fixer.io/api/latest?access_key=$apiKey';

    // Send GET request to the API
    final response = await http.get(Uri.parse(url));

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response body (JSON)
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['rates']; // Returns the 'rates' part of the JSON response
    } else {
      throw Exception('Failed to load FX rates');
    }
  }

  Future<void> getExchangeRates(String typeConverted) async {
    var localpassword = await Hive.openBox(darkModeBox);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');
    var url = Uri.parse(
        'https://devapi.currencycloud.com/v2/rates/find?currency_pair=$typeConverted');

    var response = await http.get(
      url,
      headers: {
        // 'Content-Type': 'application/json',
        'X-Auth-Token': token, // Include the auth token in the headers
      },
    );

    // Check the response status
    if (response.statusCode == 200) {
      // exchangeRates.value = exchangeRateModelFromJson(response.body);
      Get.snackbar(backgroundColor: Colors.green, 'Success', response.body);
      // Parse the response body
      var data = jsonDecode(response.body);
      print('Conversion Data Received: $data');
      fxController.fxlistRates.value =
          data['rates'][currencyPair.value.toString()];
    } else {
      Get.snackbar(backgroundColor: Colors.red, 'Failed', response.body);
      // Handle error response
      print('Failed to get Conversion Data. '
          'Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> getDetailedFxQuote(String buyCurrency, String sellCurrency,
      String fixedSide, double amount) async {
    var localpassword = await Hive.openBox(darkModeBox);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');
    // Construct the URL with query parameters
    final url = Uri.https('api.currencycloud.com', '/v2/rates/detailed', {
      'buy_currency': buyCurrency,
      'sell_currency': sellCurrency,
      'fixed_side': fixedSide,
      'amount': amount.toString(),
    });

    // Make the GET request
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      Get.snackbar(backgroundColor: Colors.green, 'Success', response.body);
      detailedFxquote.value = detailedFxQuoteFromJson(responseData);
      print('Detailed FX Quote: $responseData');
    } else {
      Get.snackbar(backgroundColor: Colors.red, 'Failed', response.body);
      throw Exception('Failed to get detailed FX quote: ${response.body}');
    }
  }

  Future<void> getFxBuyingRate(String buyCurrency, String sellCurrency,
      String fixedSide, double amount) async {
    var localpassword = await Hive.openBox(darkModeBox);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');
    // Construct the URL with query parameters
    final url = Uri.https('api.currencycloud.com', '/v2/rates/detailed', {
      'buy_currency': buyCurrency,
      'sell_currency': sellCurrency,
      'fixed_side': fixedSide,
      'amount': amount.toString(),
    });

    // Make the GET request
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      Get.snackbar(backgroundColor: Colors.green, 'Success', response.body);
      detailedFxquote.value = detailedFxQuoteFromJson(responseData);
      print('Detailed FX Quote: $responseData');
    } else {
      Get.snackbar(backgroundColor: Colors.red, 'Failed', response.body);
      throw Exception('Failed to get detailed FX quote: ${response.body}');
    }
  }

  Future<void> doconversions(String buyCurrency, String sellCurrency,
      String reason, String fixedSide, double amount) async {
    var localpassword = await Hive.openBox(darkModeBox);
    print('Your Token is: ${localpassword.get('Token')}');
    var token = localpassword.get('Token');
    final response = await http.post(
        Uri.parse('api.currencycloud.com/v2/conversions/create'),
        headers: {
          'X-Auth-Token': token,
        },
        body: {
          'buy_currency': buyCurrency,
          'sell_currency': sellCurrency,
          'amount': amount,
          'fixed_side': fixedSide,
          'reason': reason,
          'term_agreement': true,
        });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      Get.snackbar(backgroundColor: Colors.green, 'Success', response.body);
      conversionPayload.value = conversionPayloadFromJson(responseData);
      print('Detailed FX Quote: $responseData');
    } else {
      Get.snackbar(backgroundColor: Colors.red, 'Failed', response.body);
      throw Exception('Failed to get detailed FX quote: ${response.body}');
    }
  }

  final apiUrl = "https://api.apilayer.com/fixer/latest";
  final apiKey =
      "eI36AZvsUXGytYn8uKTGsC6GJ0eUxez1"; // Replace with your actual API key
  final isLoading = false.obs;
  final resultMessage = "".obs;
  final usdToKesRate = 0.0.obs;
  final amountToPay = 0.0.obs;
  final totalAmountToPay = 0.0.obs;

  // Function to fetch FX rates from an API
  Future<Map<String, dynamic>> getCurrentApiConversionRates() async {
    showLoading("Please Wait...");

    // Fixer.io API endpoint to get latest foreign exchange rates
    const String apiKey =
        'eI36AZvsUXGytYn8uKTGsC6GJ0eUxez1'; // Replace with your API key
    const String url =
        'https://api.apilayer.com/fixer/latest?base=USD&symbols=KES';

    // Send GET request to the API
    final response = await http.get(
      headers: {'apikey': apiKey},
      Uri.parse(
        url,
      ),
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response body (JSON)
      Map<String, dynamic> data = jsonDecode(response.body);

      usdToKesRate.value = data['rates']['KES'] + 0.2;
      usdToKesRate.refresh();
      totalAmountToPay.value = usdToKesRate.value * 1.5;
      print(
        data['rates']['KES'],
      );
      Get.to(
        () => const CardPaymentPage(),
      );
      // Get.snackbar('Success', response.body.toString());
      return data['rates']; // Returns the 'rates' part of the JSON response
    } else {
      Get.snackbar(
        backgroundColor: Colors.red,
        'Error', 'Please try again');
      throw Exception('Failed to load FX rates');
    }
  }
}
