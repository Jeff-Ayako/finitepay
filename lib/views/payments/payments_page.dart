// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finitepay/components/progressdialog.dart';
import 'package:finitepay/mpesapay/initializer.dart';
// import 'package:finitepay/views/payments/MpesaSTKfun.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class MypaymentDevPage extends StatefulWidget {
  MypaymentDevPage({super.key});
  static const String id = 'payd';

  @override
  State<MypaymentDevPage> createState() => _MypaymentDevPageState();
}

class _MypaymentDevPageState extends State<MypaymentDevPage> {
  String mpesaNo = "0746071879"; //phone no propably from text field
  String RealMpesaNo = "0746071879";
  double amount = 1;
  BuildContext? loadingDialogContext;

  void _onPay() async {
    FocusScope.of(context).unfocus();
    if (mpesaNo.length < 9) {
      showUpDismissible(context, "Invalid Mpesa number",
          "The Mpesa number provided is too short, Confirm and try again.");
    } else if (!mpesaNo.startsWith('254')) {
      if ((mpesaNo.startsWith('0')) && (mpesaNo.length == 10)) {
        setState(() {
          RealMpesaNo = "254${mpesaNo.replaceFirst("0", "")}";
        });
        startMpesaPay(phone: RealMpesaNo);
      } else if ((mpesaNo.startsWith('+254')) && (mpesaNo.length == 13)) {
        setState(() {
          RealMpesaNo = mpesaNo.replaceFirst("+", "");
        });
        startMpesaPay(phone: RealMpesaNo);
      } else if ((mpesaNo.startsWith('7') || mpesaNo.startsWith('1')) &&
          (mpesaNo.length == 9)) {
        setState(() {
          RealMpesaNo = "254$mpesaNo";
        });
        startMpesaPay(phone: RealMpesaNo);
      } else {
        showUpDismissible(context, "Invalid Mpesa Phone Number",
            "Confirm your Mpesa Number and try again");
      }
    } else {
      if (mpesaNo.length == 12) {
        setState(() {
          RealMpesaNo = mpesaNo;
        });
        startMpesaPay(phone: RealMpesaNo);
      } else {
        showUpDismissible(context, "Invalid Mpesa number",
            "Confirm your Mpesa Number and try again.");
      }
    }
  }

  Future<dynamic> startMpesaPay({required String phone}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      dynamic transactionInitialisation;
      try {
        // _showLoading("Loading...");
        transactionInitialisation = await MpesaPlugin.initializeMpesaSTKPush(
          amount: amount,
          phone: phone,
        );
        var result = transactionInitialisation as Map<String, dynamic>;
        print(result);
        if (result["result"] == 'successful') {
          _closeDialog();
          showUpDismissible(context, "Waiting for payment",
              "Check Mpesa payment request on your phone");
          //here is where you can keep checking is status is complete to take the user to the after succesful page.
        } else {
          _closeDialog();
          showUpDismissible(
              context, 'Failed transaction1', "Please try again later1.");
        }
      } catch (e) {
        _closeDialog();
        showUpDismissible(
            context, "Failed transaction2", "Please try again later2.$e");
      }
    } else {
      showUpDismissible(context, "No internet connection",
          "Check your connection and try again.");
    }
  }

  void _closeDialog() {
    if (loadingDialogContext != null) {
      Navigator.of(loadingDialogContext!).pop();
      loadingDialogContext = null;
    }
  }

  // Future<void> _showLoading(String message) {
  //   return showUpDismissible(
  //      context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       loadingDialogContext = context;
  //       return AlertDialog(
  //         content: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             const CircularProgressIndicator(
  //               backgroundColor: Colors.greenAccent,
  //             ),
  //             Text(
  //               message,
  //               textAlign: TextAlign.center,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    // getBasicAuthdetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => _onPay(),
          //     startCheckout(userPhone: '746071879'.trim(), amount: 1)
          //         .then((value) {
          //   // Get.to(
          //   //   () => const SuccessfullPaydPage(),
          //   // );
          // }),
          child: const Text(
            'Payment Trigger BTN',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
