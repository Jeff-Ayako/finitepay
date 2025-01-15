// // import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

// // Future<void> startCheckout({
// //   required String userPhone,
// //   required double amount,
// //   // required String tillNumber
// // }) async {
// //   //Preferably expect 'dynamic', response type varies a lot!
// //   dynamic transactionInitialisation;
// //   //Better wrap in a try-catch for lots of reasons.
// //   try {
// //     //Run it
// //     transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
// //         // using this as a sandbox
// //         businessShortCode: "174379",
// //         // businessShortCode: tillNumber,
// //         transactionType: TransactionType.CustomerPayBillOnline,
// //         amount: amount,
// //         partyA: userPhone,
// //         partyB: "174379",
// //         // uncomment this section if you want to parse in your own till number to the function
// //         // partyB: tillNumber,
// //         callBackURL:
// //             Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
// //         accountReference: "Fixplum",
// //         phoneNumber: '$userPhone',
// //         baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
// //         transactionDesc: "purchase",
// //         passKey:
// //             'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

// //     print("TRANSACTION RESULT: $transactionInitialisation");

// //     //You can check sample parsing here -> https://github.com/keronei/Mobile-Demos/blob/mpesa-flutter-client-app/lib/main.dart

// //     /*Update your db with the init data received from initialization response,
// //       * Remaining bit will be sent via callback url*/
// //     return transactionInitialisation;
// //   } catch (e) {
// //     //For now, console might be useful
// //     print("CAUGHT EXCEPTION: $e");

// //     /*
// //       Other 'throws':
// //       1. Amount being less than 1.0
// //       2. Consumer Secret/Key not set
// //       3. Phone number is less than 9 characters
// //       4. Phone number not in international format(should start with 254 for KE)
// //        */
// //   }
// // }

// // ignore_for_file: avoid_print, equal_keys_in_map

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:finitepay/controllers/init_controllers.dart';
// import 'package:get/get.dart';
// // import 'package:fixplum/controls/controllerinit.dart';
// import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

// Future startCheckout({
//   required String userPhone,
//   required double amount,
//   // required String tillNumber
// }) async {
//   //Preferably expect 'dynamic', response type varies a lot!
//   dynamic transactionInitialisation;
//   //Better wrap in a try-catch for lots of reasons.
//   try {
//     //Run it
//     transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
//         // using this as a sunbox
//         businessShortCode: "174379",
//         // businessShortCode: tillNumber,
//         transactionType: TransactionType.CustomerPayBillOnline,
//         amount: amount,
//         partyA: userPhone,
//         partyB: "174379",
//         // uncomment this section if you want to parse in your own till number to the function
//         // partyB: tillNumber,

//         callBackURL: Uri.parse(
//             'https://us-central1-mpesa-flutter.cloudfunctions.net/safaricomWebhook'),
//         accountReference: "FinitePay",
//         phoneNumber: '254$userPhone',
//         baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
//         transactionDesc: "purchase",
//         passKey:
//             'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

//     print("TRANSACTION RESULT: $transactionInitialisation");

//     //  CollectionReference<Map<String, dynamic>> users = FirebaseFirestore.instance.collection('users');
//     DocumentReference<Map<String, dynamic>> MpesaData = FirebaseFirestore
//         .instance
//         .collection('mpesaData')
//         .doc(transactionInitialisation['CheckoutRequestID']);

//     maincontroller.merchantID.value =
//         transactionInitialisation['CheckoutRequestID'];

//     // mainControls.merchID.value = transactionInitialisation['CheckoutRequestID'];

//     await MpesaData.set({
//       // 'Body': {
//       //   {
//       //     "stkCallback": {
//       //       "MerchantRequestID": transactionInitialisation['MerchantRequestID'],
//       //       "CheckoutRequestID": "ws_CO_DMZ_370754209_06062019172849964",
//       //       "ResultCode": 0,
//       //       "ResultDesc": "",
//       //       "CallbackMetadata": {
//       //         "Item": [
//       //           {"Name": "Amount", "Value": 0.00},
//       //           {"Name": "MpesaReceiptNumber", "Value": "NF68F38A1G"},
//       //           {"Name": "Balance"},
//       //           {"Name": "TransactionDate", "Value": DateTime.now()}
//       //         ]
//       //       }
//       //     }
//       //   }
//       // },
//       'ResultDesc': 'Please wait....',
//       'ResponceCode': transactionInitialisation['ResponseCode'],
//       'code': transactionInitialisation['MerchantRequestID'],
//       'CheckoutRequestID': transactionInitialisation['CheckoutRequestID'],
//       'ResponseDescription': transactionInitialisation['ResponseDescription'],
//       'CustomerMessage': transactionInitialisation['CustomerMessage'],
//       'isPayProcessed': 1,
//       'ResponseDescription': 'Pending',
//     }).then((value) async {
//       Get.back();
//       Get.back();
//       // Get.to(
//       //   () => FirestoreRealtimeExample(),
//       // );
//       print("Payment processing Added");

//       // mainControls.mpesadataStream = await FirebaseFirestore.instance
//       //     .collection('mpesaData')
//       //     .doc(transactionInitialisation['MerchantRequestID'])
//       //     .snapshots();
//     }).catchError((error) => print("Failed to add Payment processing: $error"));

//     // mainControls.merchantId = transactionInitialisation;
//     // mainControls.responceCode.value = transactionInitialisation['ResponseCode'];

//     return transactionInitialisation;
//   } catch (e) {
//     //For now, console might be useful
//     print("CAUGHT EXCEPTION: $e");

//     /*
//       Other 'throws':
//       1. Amount being less than 1.0
//       2. Consumer Secret/Key not set
//       3. Phone number is less than 9 characters
//       4. Phone number not in international format(should start with 254 for KE)
//        */
//   }
// }
