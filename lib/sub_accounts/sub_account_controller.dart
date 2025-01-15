import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/main.dart';
import 'package:finitepay/models/create_contact.dart';
import 'package:finitepay/models/sub_accoun_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;

class SubAccountController extends GetxController {
  final subAccount = Rxn<SubAccountDetails>();

  final createdContactInfo = Rxn<CreateContact>();

  Future createSubaccount(
    String accountName,
    String legalEntitytype,
    String street,
    String city,
    String country,
    String postalcode,
    String yourref,
    String status,
    String stateprovince,
    String idtype,
    String idvalue,
  ) async {
    var localpassword = await Hive.openBox(darkModeBox);
    // localpassword.put('NationalID', usernationsID);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');

    // Currencycloud API endpoint for authentication
    var url = Uri.parse('https://devapi.currencycloud.com/v2/accounts/create');

    // Send POST request
    var response = await http.post(
      url,
      headers: {'X-Auth-Token': token},
      body: {
        'account_name': accountName,
        'legal_entity_type': legalEntitytype,
        'street': street,
        'city': city,
        'country': country,
        'postal_code': postalcode,
        'your_reference': yourref,
        'status': status,
        'state_or_province': stateprovince,
        'identification_type': idtype,
        'identification_value': idvalue
      },
    );
    // Check if the request was successful
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      createContact(
        data['id'],
        'John',
        'Evans',
        'johnevans@gmail.com',
        '+254746071879',
        '45tyrm',
        'enabled',
        '',
        '',
      );

      // subAccount.value = subAccountDetailsFromJson(data);

      // FirebaseFirestore.instance
      //     .collection('SubAccounts')
      //     .doc(fAuth.currentUser?.uid ?? '')
      //     .set(sub().);

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

  Future createContact(
    String accountid,
    String firstName,
    String lastName,
    String emailAddress,
    String phoneNumber,
    String yourReference,
    String status,
    String timezone,
    String dob,
  ) async {
    var localpassword = await Hive.openBox(darkModeBox);
    // localpassword.put('NationalID', usernationsID);
    print('Your Token is: ${localpassword.get('Token')}');

    var token = localpassword.get('Token');

    // Currencycloud API endpoint for authentication
    var url = Uri.parse('https://devapi.currencycloud.com/v2/contacts/create');

    // Send POST request
    var response = await http.post(
      url,
      headers: {'X-Auth-Token': token},
      body: {
        'account_id': accountid,
        'first_name': firstName,
        'last_name': lastName,
        'email_address': emailAddress,
        'phone_number': phoneNumber,
        'your_reference': yourReference,
        'status': status,
        'timezone': timezone,
        'date_of_birth': dob,
      },
    );
    // Check if the request was successful
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      createdContactInfo.value = createContactFromJson(data);

      FirebaseFirestore.instance
          .collection('CreatedContacts')
          .doc(fAuth.currentUser?.uid ?? '')
          .set(data);

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
}
