// ignore_for_file: avoid_print, equal_keys_in_map

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/controllers/init_controllers.dart';
// import 'package:fixplum/controls/controllerinit.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

Future startCheckout({
  required String userPhone,
  required double amount,
  // required String tillNumber
}) async {
  //Preferably expect 'dynamic', response type varies a lot!
  dynamic transactionInitialisation;
  //Better wrap in a try-catch for lots of reasons.
  try {
    //Run it
    transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
      // using this as a sunbox
      businessShortCode: "4149705",
      // businessShortCode: tillNumber,
      transactionType: TransactionType.CustomerPayBillOnline,
      amount: 10,
      partyA: userPhone,
      partyB: "4149705",
      // uncomment this section if you want to parse in your own till number to the function
      // partyB: tillNumber,

      callBackURL: Uri.parse(
          'https://us-central1-mpesa-flutter.cloudfunctions.net/safaricomWebhook'),
      accountReference: "FINITE PAY INTERNATIONAL LIMITED",
      phoneNumber: '254$userPhone',
      baseUri: Uri(
        scheme: "https",
        host: "api.safaricom.co.ke",
      ),
      transactionDesc: "Card payment",
      passKey:
          '236826a332eeabc40589d933632af7e49e0704404f8937638d18b40c9a6fac74',
    );

    print("TRANSACTION RESULT: $transactionInitialisation");

    //  CollectionReference<Map<String, dynamic>> users = FirebaseFirestore.instance.collection('users');
    DocumentReference<Map<String, dynamic>> MpesaData = FirebaseFirestore
        .instance
        .collection('mpesaData')
        .doc(transactionInitialisation['CheckoutRequestID']);

    maincontroller.merchID.value =
        transactionInitialisation['CheckoutRequestID'];

    await MpesaData.set({
      // 'Body': {
      //   {
      //     "stkCallback": {
      //       "MerchantRequestID": transactionInitialisation['MerchantRequestID'],
      //       "CheckoutRequestID": "ws_CO_DMZ_370754209_06062019172849964",
      //       "ResultCode": 0,
      //       "ResultDesc": "",
      //       "CallbackMetadata": {
      //         "Item": [
      //           {"Name": "Amount", "Value": 0.00},
      //           {"Name": "MpesaReceiptNumber", "Value": "NF68F38A1G"},
      //           {"Name": "Balance"},
      //           {"Name": "TransactionDate", "Value": DateTime.now()}
      //         ]
      //       }
      //     }
      //   }
      // },
      'ResultDesc': 'Please wait....',
      'ResponceCode': transactionInitialisation['ResponseCode'],
      'code': transactionInitialisation['MerchantRequestID'],
      'CheckoutRequestID': transactionInitialisation['CheckoutRequestID'],
      'ResponseDescription': transactionInitialisation['ResponseDescription'],
      'CustomerMessage': transactionInitialisation['CustomerMessage'],
      'isPayProcessed': 1,
      'ResponseDescription': 'Pending',
    }).then((value) async {
      print("Payment processing Added");

      // mainControls.mpesadataStream = await FirebaseFirestore.instance
      //     .collection('mpesaData')
      //     .doc(transactionInitialisation['MerchantRequestID'])
      //     .snapshots();
    }).catchError((error) => print("Failed to add Payment processing: $error"));

    maincontroller.merchID.value = transactionInitialisation;
    maincontroller.responceCode.value =
        transactionInitialisation['ResponseCode'];

    return transactionInitialisation;
  } catch (e) {
    //For now, console might be useful
    print("CAUGHT EXCEPTION: $e");

    /*
      Other 'throws':
      1. Amount being less than 1.0
      2. Consumer Secret/Key not set
      3. Phone number is less than 9 characters
      4. Phone number not in international format(should start with 254 for KE)
       */
  }
}
