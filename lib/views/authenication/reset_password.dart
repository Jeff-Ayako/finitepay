// ignore_for_file: use_build_context_synchronously

// Flutter imports:
import 'package:finitepay/components/Button.dart';
import 'package:finitepay/components/logo_state_change.dart';
import 'package:finitepay/components/progressdialog.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  BuildContext? loadingDialogContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //  BackGroundColor(
          // child:
          Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
          Center(child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 700) {
              return SizedBox(
                width: Get.width * .75,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height * .6,
                              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Center(
                                child: Card(
                                  // color: Color(0xffFFD105),
                                  child: Form(
                                    key: formKey,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 15.0, top: 50),
                                            child: Image(
                                              alignment: Alignment.center,
                                              height: 70.0,
                                              color: Color(0xFF5A31F4),
                                              image: AssetImage(
                                                "assets/fwhitelogo.png",
                                              ),
                                            ),
                                          ),
                                          const Text(
                                              "Please enter your email address",
                                              style: TextStyle(fontSize: 20)),
                                          Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, top: 5),
                                              child: TextFormField(
                                                onFieldSubmitted: (value) {
                                                  _onPressed();
                                                },
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: emailController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0xff010130),
                                                    ),
                                                  ),
                                                  labelText: "Enter Your Email",
                                                  prefixIcon:
                                                      const Icon(Icons.email),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                autofillHints: const [
                                                  AutofillHints.email
                                                ],
                                                validator: (email) => email !=
                                                            null &&
                                                        !EmailValidator
                                                            .validate(
                                                                email.trim())
                                                    ? 'Enter a Valid email'
                                                    : null,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 60),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: SizedBox(
                                                width: Get.width / 2,
                                                child: Button(
                                                  title: "Reset Password",
                                                  color:
                                                      const Color(0xff010130),
                                                  onPressed: _onPressed,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                    "Remember Password?"),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    " Login",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff010130),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: LogoStateChange(
                        height: Get.height,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Please enter your email address",
                          style: TextStyle(fontSize: 20)),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: "Enter Your Email",
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            autofillHints: const [AutofillHints.email],
                            validator: (email) => email != null &&
                                    !EmailValidator.validate(email.trim())
                                ? 'Enter a Valid email'
                                : null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width / 2,
                              child: Button(
                                title: "Reset Password",
                                color: const Color(0xff010130),
                                onPressed: _onPressed,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Remember Password?"),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          })
              //

              ),
        ],
      ),
      // ),
    );
  }

  _onPressed() async {
    if (formKey.currentState!.validate()) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        _showLoading("Loading...");
        try {
          await auth
              .sendPasswordResetEmail(
                  email: emailController.text.trim().toLowerCase())
              .then((_) {
            _closeDialog();
            Navigator.of(context).pop();
            checkEmail(context, "Check Your Email",
                "Check the email which has been sent to ${emailController.text.trim().toLowerCase()} to reset your password");
          }).catchError((err) {
            _closeDialog();
            if (err.message ==
                "There is no user record corresponding to this identifier. The user may have been deleted.") {
              showUpDismissible(context, "No such user with this email",
                  "Confirm your email address and try again");
            } else {
              showUpDismissible(
                  context, "Could not reset password", "Please try again");
            }
          });
        } catch (e) {
          _closeDialog();
          showUpDismissible(
              context, "Could not reset password", "Please try again");
        }
      } else {
        showUpDismissible(context, "No Internet Connection",
            "Please connect to internet and try again");
      }
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
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint the purple background
    Paint paint = Paint()..color = const Color(0xFF5A31F4);
    Path purplePath = Path();
    purplePath.moveTo(0, 0); // Top-left corner
    purplePath.lineTo(size.width, 0); // Top-right corner
    purplePath.lineTo(size.width, size.height); // Bottom-right corner
    purplePath.lineTo(0, size.height); // Bottom-left corner
    purplePath.close();
    canvas.drawPath(purplePath, paint);

    // Paint the yellow diagonal strip
    Paint yellowPaint = Paint()..color = const Color(0xFFF4C144);
    Path yellowPath = Path();
    yellowPath.moveTo(100, 100); // Start at top-left corner
    yellowPath.lineTo(size.width, 0); // Move to top-right corner
    yellowPath.lineTo(0, size.height); // Move to bottom-left corner
    yellowPath.close();
    canvas.drawPath(yellowPath, yellowPaint);

    // Paint the white diagonal at the bottom right
    Paint whitePaint = Paint()..color = Colors.white;
    Path whitePath = Path();
    whitePath.moveTo(size.width * 0.5, size.height);
    whitePath.lineTo(size.width, size.height * 0.5);
    whitePath.lineTo(size.width, size.height);
    whitePath.close();
    canvas.drawPath(whitePath, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
