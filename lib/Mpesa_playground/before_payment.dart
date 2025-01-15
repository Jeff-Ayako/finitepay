// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

// import 'package:connectivity/connectivity.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:finitepay/Mpesa_playground/mpesa_stk_function.dart';
import 'package:finitepay/loadings/indicators.dart';
import 'package:finitepay/mpesapay/initializer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeforePay extends StatefulWidget {
  const BeforePay({super.key});

  @override
  State<BeforePay> createState() => _BeforePayState();
}

class _BeforePayState extends State<BeforePay> {
  String mpesaNo = "0746071879"; //phone no propably from text field
  String RealMpesaNo = "0746071879";
  double amount = 1;
  BuildContext? loadingDialogContext;

  void _onPay() async {
    FocusScope.of(context).unfocus();
    if (mpesaNo.length < 9) {
      showUpDis(context, "Invalid Mpesa number",
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
        showUpDis(context, "Invalid Mpesa Phone Number",
            "Confirm your Mpesa Number and try again");
      }
    } else {
      if (mpesaNo.length == 12) {
        setState(() {
          RealMpesaNo = mpesaNo;
        });
        startMpesaPay(phone: RealMpesaNo);
      } else {
        showUpDis(context, "Invalid Mpesa number",
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
        _showLoading("Loading...");
        transactionInitialisation = await MpesaPlugin.initializeMpesaSTKPush(
          amount: amount,
          phone: phone,
        );
        var result = transactionInitialisation as Map<String, dynamic>;
        if (result["result"] == 'successful') {
          _closeDialog();
          showUpDis(context, "Waiting for payment",
              "Check Mpesa payment request on your phone");
          //here is where you can keep checking is status is complete to take the user to the after succesful page.
        } else {
          _closeDialog();
          showUpDis(context, 'Failed transaction', "Please try again later.");
        }
      } catch (e) {
        _closeDialog();
        showUpDis(context, "Failed transaction", "Please try again later.");
      }
    } else {
      showUpDis(context, "No internet connection",
          "Check your connection and try again.");
    }
  }

  void _closeDialog() {
    if (loadingDialogContext != null) {
      Navigator.of(loadingDialogContext!).pop();
      loadingDialogContext = null;
    }
  }

  Future<void> _showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        loadingDialogContext = context;
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircularProgressIndicator(
                backgroundColor: Colors.greenAccent,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _onPay();
            // sendStkPush('254746071879', 1);
          },
          child: const Text('Pay Now'),
        ),
      ),
    );
  }
}

Future<void> sendStkPush(String phoneNumber, double amount) async {
  try {
    final callable = FirebaseFunctions.instance.httpsCallable('stkPush');
    final response = await callable({
      'phoneNumber': phoneNumber,
      'amount': amount,
    });

    Get.snackbar(backgroundColor: Colors.red, 'Error', response.data);

    // print('STK Push Response: ${response.data}');
  } catch (error) {
    Get.snackbar(
      backgroundColor: Colors.amber,
      'Error',
      'Error during STK Push: $error',
    );
    print(
      'Error during STK Push: $error',
    );
  }
}
