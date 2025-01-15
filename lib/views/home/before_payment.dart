// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:finitepay/Mpesa_playground/mpesa_stk_function.dart';
import 'package:finitepay/loadings/indicators.dart';
import 'package:finitepay/mpesapay/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:mpesa_integration/loadings/indicators.dart';
// import 'package:mpesa_integration/mpesapay/initializer.dart';

class BeforePay extends StatefulWidget {
  const BeforePay({super.key});

  @override
  State<BeforePay> createState() => _BeforePayState();
}

class _BeforePayState extends State<BeforePay> {
  String mpesaNo = "0746071879"; //phone no propably from text field
  String RealMpesaNo = "0746071879";
  double amount = 100;
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
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
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
        print(result);
        if (result["result"] == 'successful') {
          _closeDialog();
          showUpDis(context, "Waiting for payment",
              "Check Mpesa payment request on your phone");
          //here is where you can keep checking is status is complete to take the user to the after succesful page.
        } else {
          Get.snackbar(
            'Error',
            result.toString(),
          );
          _closeDialog();
          showUpDis(context, 'Failed transaction', "Please try again later.");
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
        );
        _closeDialog();
        Get.snackbar(
          'Error',
          e.toString(),
        );
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
      body: Expanded(
        child: Center(
          child: SizedBox(
            // width: Get.width / 2
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Form(
                        // key: formcontrollers,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/finitelw.png',
                                color: const Color(0xFF5A31F4),
                                height: 100,
                              ),
                            ),
                            const Center(
                              child: Text(
                                'FinitePay',
                                style: TextStyle(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5A31F4),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            const Text(
                              'Test Payment',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            TextFormField(
                              // controller: emailController,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email.trim())
                                  ? 'Enter a Valid email'
                                  : null,
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF5A31F4),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF5A31F4),
                                  ),
                                ),
                              ),
                              // initialValue: 'jeffayako1@gmail.com',
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              // controller: amountController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"))
                              ],
                              // validator: (value) => value!.trim().isNotEmpty &&
                              //         value.trim().length > 7
                              //     ? null
                              //     : "Password must be at least 8 characters",
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Amount',
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF5A31F4),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF5A31F4),
                                  ),
                                ),
                                suffixIcon: const Icon(
                                  Icons.visibility,
                                  color: Color(0xFF5A31F4),
                                ),
                              ),
                              // initialValue: 'hhhhhhhhhhhhhhhhh',
                            ),
                            const SizedBox(height: 16.0),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Checkbox(
                            //           value: true,
                            //           onChanged: (value) {},
                            //           activeColor: const Color(0xFF5A31F4),
                            //         ),
                            //         const Text('Keep me signed in'),
                            //       ],
                            //     ),
                            //     TextButton(
                            //       onPressed: () {},
                            //       child: const Text(
                            //         'Forgot login details?',
                            //         style: TextStyle(color: Color(0xFF5A31F4)),
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            const SizedBox(height: 24.0),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  _onPay();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  backgroundColor: const Color(0xFF5A31F4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  'Pay Now',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            ),
                            // Center(
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: TextButton(
                            //       onPressed: () {
                            //         Get.to(
                            //           () => const CreateAccountPage(),
                            //         );
                            //       },
                            //       child: const Text(
                            //         'Create Account',
                            //         style: TextStyle(color: Color(0xFF5A31F4)),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Need Support?',
                        style: TextStyle(
                            // color: Colors.black54,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      //  Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       _onPay();
      //     },
      //     child: const Text('Pay Now'),
      //   ),
      // ),
    );
  }
}
