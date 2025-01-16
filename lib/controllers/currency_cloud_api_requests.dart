import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/main.dart';
import 'package:finitepay/models/all_currencies_model.dart';
import 'package:finitepay/models/beneficiaries_model.dart';
import 'package:finitepay/models/beneficiary_modal.dart';
import 'package:finitepay/models/currencymodel.dart';
import 'package:finitepay/models/paidsuccessmodel.dart';
import 'package:finitepay/models/transactions_made.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:world_flags/world_flags.dart';

class CurrencyCloudController extends GetxController {
  static const size = kMinInteractiveDimension / 2;
  static const countries = WorldCountry.list;

  final aspectRatio = ValueNotifier(FlagConstants.defaultAspectRatio);

  final currencyModel = Rxn<CurrencyModel>();
  final beneficiaries = Rxn<BeneficiariesFound>();
  final allMycurrencies = Rxn<AllCurrencies>();
  final beneficiaryObject = Rxn<BeneficiaryModal>();
  final paidobject = Rxn<SuccessPaymentModal>();

  final transactionsObject = Rxn<TransactionsMade>();
  // BeneficiaryModal
  final token = ''.obs;
  final eurcurrencyBal = ''.obs;

  final currenttimeZone = ''.obs;

  void getTimeZone() {
    DateTime now = DateTime.now();
    String timeZone = DateFormat('zzz')
        .format(now); // Will print the time zone abbreviation (e.g., "GMT+2")

    currenttimeZone.value = timeZone;
    print('Current Time Zone: $timeZone');
  }

  Future<void> getTransactionsDetails() async {
    var localpassword = await Hive.openBox(darkModeBox);
    // localpassword.put('NationalID', usernationsID);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');
    // Currencycloud API endpoint for authentication
    var url =
        Uri.parse('https://devapi.currencycloud.com/v2/transactions/find');

    // Send POST request
    var response = await http.get(
      url,
      headers: {
        'X-Auth-Token': token,
      },
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response body (should contain the auth token)
      var data = jsonDecode(response.body);

      print(data);

      transactionsObject.value = transactionsMadeFromJson(response.body);

      // Get.snackbar(backgroundColor: Colors.green, 'Success', '$data');
      print('Found the following transactions: $data');
    } else {
      Get.snackbar(
          backgroundColor: Colors.red,
          'Falled ',
          'Could not load transactions: ${response.statusCode}, ${response.body}');
      // print('Login successful! Auth token: ${response.body}');
      // Handle error response
      print('Failed Transactions Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> findAllBeneficiaries() async {
    var localpassword = await Hive.openBox(darkModeBox);
    // localpassword.put('NationalID', usernationsID);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');
    // Currencycloud API endpoint for authentication
    var url =
        Uri.parse('https://devapi.currencycloud.com/v2/beneficiaries/find');

    // Send POST request
    var response = await http.post(
      url,
      headers: {
        'X-Auth-Token': token,
      },
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response body (should contain the auth token)
      var data = jsonDecode(response.body);

      beneficiaries.value = beneficiariesFoundFromJson(response.body);

      print(data);

      // transactionsObject.value = transactionsMadeFromJson(response.body);

      // Get.snackbar(backgroundColor: Colors.green, 'Success', '$data');
      print('Found the following Beneficiaries: $data');
    } else {
      // Get.snackbar(
      //     backgroundColor: Colors.red,
      //     'Falled ',
      //     'Could not load Beneficiaries: ${response.statusCode}, ${response.body}');
      // print('Login successful! Auth token: ${response.body}');
      // Handle error response
      print('Failed Beneficiaries Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> loginToCurrencyCloud(String loginId, String apiKey) async {
    // Currencycloud API endpoint for authentication
    var url = Uri.parse('https://devapi.currencycloud.com/v2/authenticate/api');

    // Request body (login credentials)
    var body = jsonEncode({
      'login_id': loginId,
      'api_key': apiKey,
    });

    // Send POST request
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response body (should contain the auth token)
      var data = jsonDecode(response.body);
      String authToken = data['auth_token'];

      token.value = authToken;

      var localpassword = await Hive.openBox(darkModeBox);
      localpassword.put('Token', data['auth_token'].toString());
      print('Your Token is: ${localpassword.get('NationalID')}');

      // Get.snackbar(
      //     backgroundColor: Colors.green,
      //     'Success',
      //     'Your Aunthentication token is $authToken');
      print('Login successful! Auth token: $authToken');
    } else {
      // Get.snackbar(
      //     backgroundColor: Colors.red,
      //     'Falled ',
      //     'Your Aunthentication token is ${response.statusCode}, ${response.body}');

      // print('Login successful! Auth token: ${response.body}');
      // Handle error response
      print('Failed to login. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> getPendingTransactions() async {
    var localpassword = await Hive.openBox(darkModeBox);
    // localpassword.put('NationalID', usernationsID);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');
    const String transactionsUrl =
        'https://api.currencycloud.com/v2/transactions/find';

    final response = await http.get(
      Uri.parse('$transactionsUrl?status=pending'),
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token, // Ensure this is the correct token
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('Pending Transactions: ${data['transactions']}');
    } else if (response.statusCode == 401) {
      print('Error: Unauthorized. Token may have expired or is invalid.');
      throw Exception(
          'Failed to fetch pending transactions. Status: 401 Unauthorized.');
    } else {
      print(
          'Error: Status code ${response.statusCode}. Response: ${response.body}');
      throw Exception(
          'Failed to fetch pending transactions. Status: ${response.statusCode}');
    }
  }

  Future getfirebaseBalances(String currentCurrency, int index) async {
    await FirebaseFirestore.instance
        .collection('Balances')
        .doc(fAuth.currentUser?.uid ?? '')
        .collection('Wallets')
        .doc(currentCurrency)
        .get()
        .then(
      (value) {
        allMycurrencies.value!.balances[index].amount =
            double.parse(value.data()?['amount'].toString() ?? 0.00.toString())
                .toStringAsFixed(2);

        currencyCloudController.allMycurrencies.refresh();
      },
    );
  }

  Future getBalanceForCurrency(String currency) async {
    var localpassword = await Hive.openBox(darkModeBox);
    // localpassword.put('NationalID', usernationsID);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');

    // Currencycloud API endpoint for authentication
    var url =
        Uri.parse('https://devapi.currencycloud.com/v2/balances/$currency');

    // Send POST request
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'X-Auth-Token': token},
      // body: body,
    );
    // Check if the request was successful
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      eurcurrencyBal.value = response.body;

      currencyModel.value = currencyModelFromJson(response.body);

      print(currencyModel.value!.accountId.toString());

      Get.snackbar(
          backgroundColor: Colors.green,
          'Success',
          'Your Aunthentication token is  $data');
      print('Login successful! Auth token: ');
    } else {
      Get.snackbar(
          backgroundColor: Colors.red,
          'Falled ',
          'Following error occured ${response.statusCode}, ${response.body}');
      // print('Login successful! Auth token: ${response.body}');
      // Handle error response
      print('Failed to login. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  // /v2/balances/find

  Future getBalances() async {
    var localpassword = await Hive.openBox(darkModeBox);
    // localpassword.put('NationalID', usernationsID);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');

    // Currencycloud API endpoint for authentication
    var url = Uri.parse('https://devapi.currencycloud.com/v2/balances/find');

    // Send POST request
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'X-Auth-Token': token},
      // body: body,
    );
    // Check if the request was successful
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      eurcurrencyBal.value = response.body;

      allMycurrencies.value = allCurrenciesFromJson(response.body);

      for (int i = 0; i <= allMycurrencies.value!.balances.length; i++) {
        getfirebaseBalances(allMycurrencies.value!.balances[i].currency, i);
      }

      print(currencyModel.value!.accountId.toString());

      // Get.snackbar(
      //     backgroundColor: Colors.green,
      //     'Success',
      //     'Your Aunthentication token is  $data');
      print('Login successful! Auth token: ');
    } else {
      Get.snackbar(
          backgroundColor: Colors.red,
          'Falled ',
          'Following error occured ${response.statusCode}, ${response.body}');
      // print('Login successful! Auth token: ${response.body}');
      // Handle error response
      print('Failed to login. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  // Function to get beneficiary requirements from Currencycloud
  Future<void> getBeneficiaryRequirements(
      String beneficiaryCountry, String currency) async {
    var localpassword = await Hive.openBox(darkModeBox);
    // localpassword.put('NationalID', usernationsID);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');
    // Currencycloud API endpoint for beneficiary requirements
    var url = Uri.parse(
        'https://devapi.currencycloud.com/v2/reference/beneficiary_required_details');

    // Set up query parameters
    var queryParams = {
      'bank_account_country': beneficiaryCountry,
      'currency': currency,
    };

    // Add the query parameters to the URL
    var fullUrl = url.replace(queryParameters: queryParams);

    // Send GET request
    var response = await http.get(
      fullUrl,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token, // Include the auth token in the headers
      },
    );

    // Check the response status
    if (response.statusCode == 200) {
      // beneficiaryObject.value = beneficiaryModalFromJson(response.body);
      Get.snackbar(backgroundColor: Colors.green, 'Success', response.body);
      // Parse the response body
      var data = jsonDecode(response.body);
      print('Beneficiary Requirements: ${data.toString()}');
    } else {
      Get.snackbar(backgroundColor: Colors.red, 'Failed', response.body);
      // Handle error response
      print('Failed to get beneficiary requirements. '
          'Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  // Function to get beneficiary requirements from Currencycloud
  Future<void> createBeneficiaryFunction() async {
    var localpassword = await Hive.openBox(darkModeBox);
    // localpassword.put('NationalID', usernationsID);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');
    // Currencycloud API endpoint for beneficiary requirements
    var url =
        Uri.parse('https://devapi.currencycloud.com/v2/beneficiaries/create');

    // // Set up query parameters
    // var queryParams = {
    //   'bank_account_country': beneficiaryCountry,
    //   'currency': currency,
    // };

    // Add the query parameters to the URL
    // var fullUrl = url.replace(queryParameters: queryParams);

    // Send GET request
    var response = await http.post(url, headers: {
      // 'Content-Type': 'application/json',
      'X-Auth-Token': token,
    }, body: {
      // "name":"Helina",
      "bank_account_holder_name":
          maincontroller.accountNameHolderController.text.toString(),
      "currency":
          countryCodes[maincontroller.currencyController.text.toString()]
              .toString(),
      "email": "kemunto2@gmail.com",
      "bank_country":
          countryCodes[maincontroller.currencyController.text.toString()]
              .toString(),
      "beneficiary_address": maincontroller.addressController.text.toString(),
      "beneficiary_country":
          countryCodes[maincontroller.beneficiaryCountry.text.toString()]
              .toString(),
      "account_number": maincontroller.accountNumber.text.toString(),
      "routing_code_type_1": "aba",
      "routing_code_value_1": "rtriw",
      "routing_code_type_2": "faeefa",
      "routing_code_value_2": "jhkakjhkjfa",
      "bic_swift": maincontroller.bicSwiftController.text.toString(),
      "iban": "aba29292929",
      "default_beneficiary": "abb67d2f-ad4d-4428-b0e0-0dd1e91ac294",
      "bank_address": "BankMore",
      "bank_name": "Equity",
      "bank_account_type": "checking",
      "beneficiary_entity_type": "individual",
      "beneficiary_first_name":
          maincontroller.firstNameController.text.toString(),
      "beneficiary_last_name":
          maincontroller.lastNameController.text.toString(),
      "beneficiary_city": maincontroller.cityController.text.toString(),
      "beneficiary_postcode": "43844",
      "beneficiary_state_or_province": "France",
      "beneficiary_date_of_birth": "1999-05-23",
      "beneficiary_identification_type": "national_id",
      "beneficiary_identification_value": "36658828",
      // "payment_types": [],
      "on_behalf_of": "12949321801840814084018041",
      "beneficiary_external_reference": "hrwqhriqroiq"
    });

    // Check the response status
    if (response.statusCode == 200) {
      // beneficiaryObject.value = beneficiaryModalFromJson(response.body);
      Get.snackbar(backgroundColor: Colors.green, 'Success', response.body);
      // Parse the response body
      var data = jsonDecode(response.body);
      print('Beneficiary Requirements: ${data.toString()}');
    } else {
      Get.snackbar(backgroundColor: Colors.red, 'Failed', response.body);
      // Handle error response
      print('Failed to get beneficiary requirements. '
          'Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future transferFundsAPI() async {
    var localpassword = await Hive.openBox(darkModeBox);
    // localpassword.put('NationalID', usernationsID);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');

    // Currencycloud API endpoint for authentication
    var url = Uri.parse('https://devapi.currencycloud.com/v2/transfers/create');

    // Send POST request
    var response = await http.post(
      url,
      headers: {
        // 'Content-Type': 'application/json',
        'X-Auth-Token': token
      },
      body: {
        'currency': 'EUR',
        'source_account_id': 'aea097c2-39e4-49b5-aaa6-c860ca55ca0b',
        'destination_account_id': '22ed17b5-b90c-424e-aa78-d24928b1778e',
        'reason': 'Hair making',
        'amount': '102'
      },
    );
    // Check if the request was successful
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // eurcurrencyBal.value = response.body;

      print(data);

      // allMycurrencies.value = allCurrenciesFromJson(response.body);

      // print(currencyModel.value!.accountId.toString());

      Get.snackbar(
          backgroundColor: Colors.green,
          'Success',
          'Your Aunthentication token is  $data');
      print('Login successful! Auth token: ');
    } else {
      Get.snackbar(
          backgroundColor: Colors.red,
          'Falled ',
          'Following error occured ${response.statusCode}, ${response.body}');
      // print('Login successful! Auth token: ${response.body}');
      // Handle error response
      print('Failed to login. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> createBeneficiary(Map<String, String> beneficiaryData) async {
    var localpassword = await Hive.openBox(darkModeBox);
    // localpassword.put('NationalID', usernationsID);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');
    final url =
        Uri.parse('https://api.currencycloud.com/v2/beneficiaries/create');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
      body: json.encode(beneficiaryData),
    );

    if (response.statusCode == 200) {
      print('Beneficiary created: ${response.body}');
    } else {
      throw Exception('Failed to create beneficiary: ${response.body}');
    }
  }

  Future<void> makePaymentsAPI(Map<String, String> beneficiaryData) async {
    var localpassword = await Hive.openBox(darkModeBox);
    // localpassword.put('NationalID', usernationsID);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');
    final url = Uri.parse('https://api.currencycloud.com/v2/payments/create');

    final response = await http.post(
      url,
      headers: {
        // 'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
      body: json.encode({
        'currency': 'EUR',
        'beneficiary_id': 'aea097c2-39e4-49b5-aaa6-c860ca55ca0b',
        'amount': '1000',
        'reason': '',
        'payment_type': 'regular',
        'reference': '2021-014',
        'unique_request_id': '4abd730f-bb50-4b4a-8890-f46addff222b',
      }),
    );

    if (response.statusCode == 200) {
      paidobject.value = successPaymentModalFromJson(response.body);
      print('Beneficiary created: ${response.body}');
    } else {
      throw Exception('Failed to create beneficiary: ${response.body}');
    }
  }

  getXtoken() {
    http.post(
      Uri.parse('https://api.currencycloud.com/v2/authenticate/api'),
      // headers: {'content-type': 'application/json'},\
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        "login_id": "jeff@finitepay.org",
        "api_key":
            "41a86cf60bcff796a98dcbf1a2cc9739f632eb6a685b46201098747c9103d552",
      },
    ).then((value) {
      print(value.statusCode);
      print(value.body);
      print(value.headers);
    });
  }

  @override
  void onInit() {
    // fxController.fxRates = fxController.fetchFXRates();
    // getTimeZone();
    loginToCurrencyCloud('jeff@finitepay.org',
            '41a86cf60bcff796a98dcbf1a2cc9739f632eb6a685b46201098747c9103d552')
        .then((value) {
      authenticationController.getuserdetails();
      getBalances();

      findAllBeneficiaries();
      getTransactionsDetails();
    });

    super.onInit();
  }

  @override
  void onClose() {
    aspectRatio.dispose();
    super.onClose();
  }
}



//  BENEFICIARY REQUIREMENTS FOR KENYA BASED INDIVDUALS
// {
//     "details": [
//         {
//             "payment_type": "priority",
//             "beneficiary_entity_type": "individual",
//             "beneficiary_address": "^.{1,255}",
//             "beneficiary_city": "^.{1,255}",
//             "beneficiary_country": "^[A-z]{2}$",
//             "beneficiary_first_name": "^([^0-9]{2,255})$",
//             "beneficiary_last_name": "^([^0-9]{2,255})$",
//             "acct_number": "^[0-9A-Z]{1,50}$",
//             "bic_swift": "^[0-9A-Z]{8}$|^[0-9A-Z]{11}$"
//         },
//         {
//             "payment_type": "priority",
//             "beneficiary_entity_type": "company",
//             "beneficiary_address": "^.{1,255}",
//             "beneficiary_city": "^.{1,255}",
//             "beneficiary_country": "^[A-z]{2}$",
//             "beneficiary_company_name": "^(?!\\d+$).{1,255}$",
//             "acct_number": "^[0-9A-Z]{1,50}$",
//             "bic_swift": "^[0-9A-Z]{8}$|^[0-9A-Z]{11}$"
//         }
//     ]
// }

//  BENEFICIARY REQUIREMENTS FOR US BASED INDIVDUALS


// {
//     "details": [
//         {
//             "payment_type": "regular",
//             "beneficiary_address": "^.{1,255}",
//             "beneficiary_city": "^.{1,255}",
//             "beneficiary_country": "^[A-z]{2}$",
//             "beneficiary_entity_type": "individual",
//             "beneficiary_first_name": "^([^0-9]{2,255})$",
//             "beneficiary_last_name": "^([^0-9]{2,255})$",
//             "beneficiary_state_or_province": "^.{1,255}",
//             "beneficiary_postcode": "^.{1,12}$",
//             "aba": "^\\d{9}$",
//             "acct_number": "^[0-9A-Z]{1,17}$"
//         },
//         {
//             "payment_type": "regular",
//             "beneficiary_address": "^.{1,255}",
//             "beneficiary_city": "^.{1,255}",
//             "beneficiary_country": "^[A-z]{2}$",
//             "beneficiary_entity_type": "company",
//             "beneficiary_company_name": "^(?!\\d+$).{1,255}$",
//             "beneficiary_state_or_province": "^.{1,255}",
//             "beneficiary_postcode": "^.{1,12}$",
//             "aba": "^\\d{9}$",
//             "acct_number": "^[0-9A-Z]{1,17}$"
//         },
//         {
//             "payment_type": "priority",
//             "beneficiary_state_or_province": "^.{1,255}",
//             "beneficiary_postcode": "^.{1,12}$",
//             "beneficiary_entity_type": "individual",
//             "beneficiary_address": "^.{1,255}",
//             "beneficiary_city": "^.{1,255}",
//             "beneficiary_country": "^[A-z]{2}$",
//             "beneficiary_first_name": "^([^0-9]{2,255})$",
//             "beneficiary_last_name": "^([^0-9]{2,255})$",
//             "acct_number": "^[0-9A-Z]{1,17}$",
//             "aba": "^\\d{9}$"
//         },
//         {
//             "payment_type": "priority",
//             "beneficiary_entity_type": "company",
//             "beneficiary_address": "^.{1,255}",
//             "beneficiary_city": "^.{1,255}",
//             "beneficiary_country": "^[A-z]{2}$",
//             "beneficiary_company_name": "^(?!\\d+$).{1,255}$",
//             "beneficiary_state_or_province": "^.{1,255}",
//             "beneficiary_postcode": "^.{1,12}$",
//             "acct_number": "^[0-9A-Z]{1,17}$",
//             "aba": "^\\d{9}$"
//         },
//         {
//             "payment_type": "priority",
//             "beneficiary_state_or_province": "^.{1,255}",
//             "beneficiary_postcode": "^.{1,12}$",
//             "beneficiary_entity_type": "individual",
//             "beneficiary_address": "^.{1,255}",
//             "beneficiary_city": "^.{1,255}",
//             "beneficiary_country": "^[A-z]{2}$",
//             "beneficiary_first_name": "^([^0-9]{2,255})$",
//             "beneficiary_last_name": "^([^0-9]{2,255})$",
//             "acct_number": "^[0-9A-Z]{1,17}$",
//             "bic_swift": "^[0-9A-Z]{8}$|^[0-9A-Z]{11}$"
//         },
//         {
//             "payment_type": "priority",
//             "beneficiary_entity_type": "company",
//             "beneficiary_address": "^.{1,255}",
//             "beneficiary_city": "^.{1,255}",
//             "beneficiary_country": "^[A-z]{2}$",
//             "beneficiary_company_name": "^(?!\\d+$).{1,255}$",
//             "beneficiary_state_or_province": "^.{1,255}",
//             "beneficiary_postcode": "^.{1,12}$",
//             "acct_number": "^[0-9A-Z]{1,17}$",
//             "bic_swift": "^[0-9A-Z]{8}$|^[0-9A-Z]{11}$"
//         }
//     ]
// }


// SA REQUIREMENTS
// {
//     "details": [
//         {
//             "payment_type": "priority",
//             "beneficiary_entity_type": "individual",
//             "beneficiary_address": "^.{1,255}",
//             "beneficiary_city": "^.{1,255}",
//             "beneficiary_country": "^[A-z]{2}$",
//             "beneficiary_first_name": "^([^0-9]{2,255})$",
//             "beneficiary_last_name": "^([^0-9]{2,255})$",
//             "iban": "([A-Z0-9]\\s*){15,34}",
//             "bic_swift": "^[0-9A-Z]{8}$|^[0-9A-Z]{11}$"
//         },
//         {
//             "payment_type": "priority",
//             "beneficiary_entity_type": "company",
//             "beneficiary_address": "^.{1,255}",
//             "beneficiary_city": "^.{1,255}",
//             "beneficiary_country": "^[A-z]{2}$",
//             "beneficiary_company_name": "^(?!\\d+$).{1,255}$",
//             "iban": "([A-Z0-9]\\s*){15,34}",
//             "bic_swift": "^[0-9A-Z]{8}$|^[0-9A-Z]{11}$"
//         }
//     ]
// }


//  FRENCH INTERNATIONAL REQUIREMENTS DETAILS

// {
//     "details": [
//         {
//             "payment_type": "priority",
//             "beneficiary_entity_type": "individual",
//             "beneficiary_address": "^.{1,255}",
//             "beneficiary_city": "^.{1,255}",
//             "beneficiary_country": "^[A-z]{2}$",
//             "beneficiary_first_name": "^([^0-9]{2,255})$",
//             "beneficiary_last_name": "^([^0-9]{2,255})$",
//             "iban": "([A-Z0-9]\\s*){15,34}",
//             "bic_swift": "^[0-9A-Z]{8}$|^[0-9A-Z]{11}$"
//         },
//         {
//             "payment_type": "priority",
//             "beneficiary_entity_type": "company",
//             "beneficiary_address": "^.{1,255}",
//             "beneficiary_city": "^.{1,255}",
//             "beneficiary_country": "^[A-z]{2}$",
//             "beneficiary_company_name": "^(?!\\d+$).{1,255}$",
//             "iban": "([A-Z0-9]\\s*){15,34}",
//             "bic_swift": "^[0-9A-Z]{8}$|^[0-9A-Z]{11}$"
//         },
//         {
//             "payment_type": "regular",
//             "iban": "([A-Z0-9]\\s*){15,34}",
//             "beneficiary_entity_type": "individual"
//         },
//         {
//             "payment_type": "regular",
//             "iban": "([A-Z0-9]\\s*){15,34}",
//             "beneficiary_entity_type": "company"
//         }
//     ]
// }

//  CREATING A SUB ACCOUNT JSON FORMAT

// {
//     "account_name":"Butrolose Msanii",
//     "legal_entity_type":"company",
//     "street":"123 Main Street",
//     "city":"Denver",
//     "country":"US",
//     "postal_code":"80209",
//     "your_reference":"T12345678",
//     "status":"enabled",
//     "state_or_province":"CO",
//     "identification_type":"incorporation_number",
//     "identification_value":"pvt-23459"
// }

// RESPONSE AFTER CREATING A SUB ACCOUNT SUCCCESS STATUS MODEL OJECT DATA

// {
//     "id": "abb67d2f-ad4d-4428-b0e0-0dd1e91ac294",
//     "account_name": "Butrolose Msanii",
//     "brand": "currencycloud",
//     "your_reference": "T12345678",
//     "status": "enabled",
//     "street": "123 Main Street",
//     "city": "Denver",
//     "state_or_province": "CO",
//     "country": "US",
//     "postal_code": "80209",
//     "spread_table": "flat_0.00",
//     "legal_entity_type": "company",
//     "created_at": "2024-10-06T11:39:33.000Z",
//     "updated_at": "2024-10-06T11:39:33.000Z",
//     "identification_type": "incorporation_number",
//     "identification_value": "pvt-23459",
//     "short_reference": "241006-5310549",
//     "api_trading": true,
//     "online_trading": true,
//     "phone_trading": true,
//     "process_third_party_funds": false,
//     "settlement_type": "net",
//     "agent_or_reliance": false,
//     "terms_and_conditions_accepted": null,
//     "bank_account_verified": "not required"
// }

// POST DATA BODY WHEN CREATING A NEW CONTACT  FROM FLUTTER ON CURRENCY CLOUD API.

// {
//     "account_id":"abb67d2f-ad4d-4428-b0e0-0dd1e91ac294",
//     "first_name":"Jimmy",
//     "last_name":"Mutinda",
//     "email_address":"jimmynutinda@gmail.com",
//     "phone_number":"+254746071879",
//     "your_reference":"pvt1200045",
//     "status":"enabled",
//     "timezone":"America/New York",
//     "date_of_birth":"1993-01-01"
// }


// RESPONCE DATA RECEIVED AFTER POSTING DAATA  SUCCESSFULLY ON THE CLOUD CURRENCY API 

// {
//     "login_id": "jimmynutinda@gmail.com",
//     "id": "64caa935-5b4a-4cdc-a605-cd01be43f01a",
//     "first_name": "Jimmy",
//     "last_name": "Mutinda",
//     "account_id": "abb67d2f-ad4d-4428-b0e0-0dd1e91ac294",
//     "account_name": "Butrolose Msanii",
//     "status": "enabled",
//     "locale": "en",
//     "timezone": "America/New York",
//     "email_address": "jimmynutinda@gmail.com",
//     "mobile_phone_number": null,
//     "phone_number": "+254746071879",
//     "your_reference": "pvt1200045",
//     "date_of_birth": "1993-01-01",
//     "created_at": "2024-10-06T11:50:25.000Z",
//     "updated_at": "2024-10-06T11:50:25.000Z"
// }

// CREATING AN INDIVIDUAL BENEFICIARY JSON

// {
//     "name":"Helina",
//     "bank_account_holder_name":"Atieno Kemunto ",
//     "currency":"USD",
//     "email":"kemunto2@gmail.com",
//     "beneficiary_address":"wallstreet",
//     "beneficiary_country":"FR",
//     "account_number":"111023456782",
//     "routing_code_type_1":"aba",
//     "routing_code_value_1":"rtriw",
//     "routing_code_type_2":"faeefa",
//     "routing_code_value_2":"jhkakjhkjfa",
//     "bic_swift":"434343",
//     "iban":"aba29292929",
//     "default_beneficiary":"jhajshkja",
//     "bank_address":"BankMore",
//     "bank_name":"Equity",
//     "bank_account_type":"checking",
//     "beneficiary_entity_type":"individual",
//     "beneficiary_first_name":"Helina",
//     "beneficiary_last_name":"Kenunto",
//     "beneficiary_city":"Paris",
//     "beneficiary_postcode":"43844",
//     "beneficiary_state_or_province":"France",
//     "beneficiary_date_of_birth":"1999-05-23",
//     "beneficiary_identification_type":"national_id",
//     "beneficiary_identification_value":"36658828",
//     "payment_types":[],
//     "on_behalf_of":"12949321801840814084018041",
//     "beneficiary_external_reference":"hrwqhriqroiq"



// }