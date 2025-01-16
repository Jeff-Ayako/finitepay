import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finitepay/bridgecards_test/payments_listener_page.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/components/txt_input.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/loadings/indicators.dart';
import 'package:finitepay/mpesapay/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CardPaymentPage extends StatefulWidget {
  const CardPaymentPage({super.key});

  @override
  State<CardPaymentPage> createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  // String mpesaNo = "0746071879"; //phone no propably from text field
  // String RealMpesaNo = "0746071879";
  // double amount = 1;
  BuildContext? loadingDialogContext;

  void _onPay(String mpesaNo, String RealMpesaNo, double amount) async {
    FocusScope.of(context).unfocus();
    if (mpesaNo.length < 9) {
      showUpDis(context, "Invalid Mpesa number",
          "The Mpesa number provided is too short, Confirm and try again.");
    } else if (!mpesaNo.startsWith('254')) {
      if ((mpesaNo.startsWith('0')) && (mpesaNo.length == 10)) {
        setState(() {
          RealMpesaNo = "254${mpesaNo.replaceFirst("0", "")}";
        });
        startMpesaPay(phone: RealMpesaNo, amount: amount);
      } else if ((mpesaNo.startsWith('+254')) && (mpesaNo.length == 13)) {
        setState(() {
          RealMpesaNo = mpesaNo.replaceFirst("+", "");
        });
        startMpesaPay(phone: RealMpesaNo, amount: amount);
      } else if ((mpesaNo.startsWith('7') || mpesaNo.startsWith('1')) &&
          (mpesaNo.length == 9)) {
        setState(() {
          RealMpesaNo = "254$mpesaNo";
        });
        startMpesaPay(phone: RealMpesaNo, amount: amount);
      } else {
        showUpDis(context, "Invalid Mpesa Phone Number",
            "Confirm your Mpesa Number and try again");
      }
    } else {
      if (mpesaNo.length == 12) {
        setState(() {
          RealMpesaNo = mpesaNo;
        });
        startMpesaPay(phone: RealMpesaNo, amount: amount);
      } else {
        showUpDis(context, "Invalid Mpesa number",
            "Confirm your Mpesa Number and try again.");
      }
    }
  }

  Future<dynamic> startMpesaPay(
      {required String phone, required double amount}) async {
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

        Get.snackbar('Success', result.toString());
        print(
            '1111111111111111111111111111111111111111111111111111111111111111111');
        print(transactionInitialisation.toString());

        print(
            '1111111111111111111111111111111111111111111111111111111111111111111');
        print(result);
        print('222222222222222222222222222222222222222222222222222222222222');

        if (result["result"].toString().isNotEmpty) {
          _closeDialog();
          cardsController.mpesaMerchantID.value = result["result"].toString();
          cardsController.mpesaMerchantID.refresh();
          Get.to(() => PaymentStatusScreen(
                    transactionId: result["result"],
                  ))!
              .then((value) {
            // Get.back();
          });
          // showUpDis(context, "Waiting for payment",
          //     "Check Mpesa payment request on your phone");
          // _closeDialog();
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
      appBar: AppBar(
        title: const Text('Check Out Your Virtual USD Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Current Ex-Change Rate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  child: ClipOval(
                    child: CachedNetworkImage(
                      width: Get.width,
                      height: Get.height,
                      fit: BoxFit.cover,
                      imageUrl: flagsmap['USD'],
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error_outline_outlined,
                      ),
                    ),
                  ),
                ),
                const Text('1 USD'),
                const Text('='),
                CircleAvatar(
                  child: ClipOval(
                    child: CachedNetworkImage(
                      width: Get.width,
                      height: Get.height,
                      fit: BoxFit.cover,
                      imageUrl: flagsmap['KES'],
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error_outline_outlined,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    fxController.usdToKesRate.value.toString(),
                  ),
                ),
              ],
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Card Issueing Fee = 1.5 Dollars',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TxtInput(
              inputName: 'Enter a 4 Digit Pin For Your Card',
              controller: cardsController.pin,
              ispin: true,
              keyboardType: TextInputType.number,
              inputFormatters: [
                // for below version 2 use this
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                // for version 2 and greater youcan also use this
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TxtInput(
              inputName: 'Enter Dollars to Top Up Your Card With',
              controller: cardsController.numberOfDollars,
              ispin: false,
              keyboardType: TextInputType.number,
              onchanged: (p0) {
                if (cardsController.numberOfDollars.text.isEmpty) {
                  fxController.amountToPay.value =
                      (1.5 * fxController.usdToKesRate.value);
                } else {
                  cardsController.cardAmountInCents.value =
                      (double.parse(cardsController.numberOfDollars.text)) *
                          100;
                  cardsController.cardAmountInCents.value.toStringAsFixed(0);
                  cardsController.cardAmountInCents.refresh();
                  fxController.amountToPay.value =
                      (double.parse(cardsController.numberOfDollars.text) *
                              fxController.usdToKesRate.value) +
                          (1.5 * fxController.usdToKesRate.value);
                }
              },
              inputFormatters: [
                // for below version 2 use this
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                // for version 2 and greater youcan also use this
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Would you Like to pay via this Number?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TxtInput(
              inputName: 'Phone Number',
              controller: cardsController.phone,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Obx(
                () => Text(
                  'Total Amount = Card Fee + Top Up Amount = ${fxController.amountToPay.value.toStringAsFixed(0)} /=',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Btn(
              txtColor: Colors.white,
              ontap: () {
                if (cardsController.pin.text.toString().length != 4) {
                  ScaffoldMessenger.of(Get.context!).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        'Card Pin should be 4 Characters Long',
                      ),
                    ),
                  );
                } else if (cardsController.numberOfDollars.text.isEmpty) {
                  ScaffoldMessenger.of(Get.context!).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        'Enter Number of dollars to fund Your Card With',
                      ),
                    ),
                  );
                } else if (cardsController.phone.text.length != 10) {
                  ScaffoldMessenger.of(Get.context!).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        'Mpesa Number should Be 10 Characters Long',
                      ),
                    ),
                  );
                } else if (double.parse(cardsController.numberOfDollars.text) <
                    3) {
                  ScaffoldMessenger.of(Get.context!).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        'Number of Dollars to Fund Your Card Has To Be Atleast 3 Dollars',
                      ),
                    ),
                  );
                } else {
                  print(cardsController.phone.text.toString().trim());
                  print(cardsController.phone.text.toString().trim());
                  print(double.parse(
                      fxController.amountToPay.value.toStringAsFixed(0)));

                  _onPay(
                    cardsController.phone.text.toString().trim(),
                    cardsController.phone.text.toString().trim(),
                    double.parse(
                      fxController.amountToPay.value.toStringAsFixed(0),
                    ),
                  );
                }
              },
              btnName: 'Pay With Mpesa',
              color: const Color.fromARGB(255, 10, 109, 13),
            )
          ],
        ),
      ),
    );
  }
}
