import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/components/progressdialog.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/models/users_model.dart';
import 'package:finitepay/views/authenication/create_account_page.dart';
import 'package:finitepay/views/authenication/reset_password.dart';
import 'package:finitepay/views/home/dashboard_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:email_validator/email_validator.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obsecure = true;
  final auth = FirebaseAuth.instance;
  BuildContext? loadingDialogContext;
  // UserDetails userDetails = UserDetails();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();
  final formcontrollers = GlobalKey<FormState>();

  _onPressed() async {
    if (formcontrollers.currentState!.validate()) {
      login();
    }
  }

  void login() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      _showLoading("Loading...");
      try {
        await auth
            .signInWithEmailAndPassword(
                email: emailController.text.trim().toLowerCase(),
                password: passwordController.text.trim())
            .then((_) {
          loadUserDetails();
          print('11111111111111111111111111111111111111111111111111111');
        }).catchError((err) {
          _closeDialog();
          if (err.message ==
              'The password is invalid or the user does not have a password.') {
            showUpDismissible(context, "Incorrect Email or Password",
                "The password is incorrect and does not match with the email provided");
          } else if (err.message ==
              'There is no user record corresponding to this identifier. The user may have been deleted.') {
            showUpDismissible(context, "No Account With This Email",
                "No user with the Email Address provided, Create a new account if you don't have one");
          } else if (err.message ==
              'We have blocked all requests from this device due to unusual activity. Try again later.') {
            showUpDismissible(context, "Too Many Wrong Attempts", err.message);
          } else if (err.message ==
              'The user account has been disabled by an administrator.') {
            showUpDismissible(context, "Disabled Account", err.message);
          } else {
            showUpDismissible(context, "Could not Login",
                "The issue might be your internet connection. If not please try again later.");
            print(err.message);
          }

          print('2222222222222222222222222222222222222222222222222222222222');
        });
      } catch (e) {
        _closeDialog();
        print('333333333333333333333333333333333333333333333333333333');
        showUpDismissible(context, "Could not Log In", "Please try again");

        print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      }
    } else {
      showUpDismissible(context, "No Internet Connection",
          "Connect to internet and try again");

      print('4444444444444444444444444444444444444444444444444444444444');
    }
  }

  void _logoutUser() async {
    if (auth.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  loadUserDetails() async {
    User user = auth.currentUser!;
    if (user.emailVerified) {
      try {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .collection("information")
            .doc(user.uid)
            .get()
            .then((value) {
          setState(() {
            authenticationController.userDetails.value =
                UserDetails.fromMap(value.data());
            authenticationController.userDetails.value =
                authenticationController.userDetails.value;
            authenticationController.userDetails.refresh();
            authenticationController.update();
          });
          _closeDialog();

          print('llllllllllllllllllllllllllllllllllllllllllllllllllllllllll');

          if (auth.currentUser == null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginPage(
                    // onChanged: (num) {},
                    ),
              ),
            );
            // (route) => false);
          } else {
            maincontroller.getCardHolder();
            Navigator.of(context)
                .pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const DashBoardHomePage()),
            )
                .then((value) {
              authenticationController.getuserdetails();
              // authenticationController.getProfileImgs(fAuth.currentUser?.uid ?? '');
            });
            // (route) => false);
          }

          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(
          //       builder: (context) => const MySplashScreen(),
          //     ),
          //     (route) => false);
        })

            // .then((value) {

            // })

            .catchError((err) {
          _logoutUser();
          _closeDialog();
          showUpDismissible(context, "Could not Log In", "Please try again");
        });
      } catch (e) {
        _logoutUser();
        _closeDialog();
        showUpDismissible(context, "Could not Log In", "Please try again");
      }
    } else {
      _logoutUser();
      _closeDialog();
      showVerify("Email Not Verified",
          "Your account's email address is not verified, click on the button below to send a verification request");
    }
  }

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return responceWidgetLogin();
        } else //if (constraints.maxWidth >= 1000)
        {
          return Row(
            children: [
              Expanded(child: responceWidgetLogin()),
              Expanded(
                child: Stack(
                  children: [
                    // Custom background painter
                    Positioned.fill(
                      child: CustomPaint(
                        painter: BackgroundPainter(),
                      ),
                    ),
                    // Centered login form
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          children: [
                            Expanded(
                              child: PageView(
                                controller: _pageController,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Smart Multi-Currencies banking for you and your business.",
                                        style: GoogleFonts.poppins(
                                          // color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: Image.asset(
                                          'assets/dash2.png',
                                          width: width / 1.2,
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Pay and Receive in any Currency",
                                        style: GoogleFonts.poppins(
                                          // color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: Image.asset(
                                          'assets/dash.png',
                                          width: width / 1.2,
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Pay and Receive Funds via our Virtual Cards.",
                                        style: GoogleFonts.poppins(
                                          // color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: Image.asset(
                                          'assets/card screen.png',
                                          width: width / 1.2,
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Track and Generate reports swiftly.",
                                        style: GoogleFonts.poppins(
                                          // color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: Image.asset(
                                          'assets/balances.png',
                                          width: width / 1.2,
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Simple way to get started...",
                                        style: GoogleFonts.poppins(
                                          // color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: Image.asset(
                                          'assets/auth page.png',
                                          width: width / 1.2,
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  backgroundColor: Colors.amber,
                                  onPressed: () {
                                    if (maincontroller.pageviewIndex.value <
                                        0) {
                                      maincontroller.pageviewIndex.value = 0;
                                    }
                                    maincontroller.pageviewIndex.value =
                                        maincontroller.pageviewIndex.value - 1;
                                    maincontroller.pageviewIndex.refresh();
                                    //  _pageController.initialPage= _pageController.initialPage--
                                    _pageController.jumpToPage(
                                        maincontroller.pageviewIndex.value);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmoothPageIndicator(
                                      effect: const SwapEffect(
                                        activeDotColor: Colors.green,
                                        dotColor: Colors.amber,
                                      ),
                                      controller: _pageController,
                                      count: 5),
                                ),
                                FloatingActionButton(
                                  backgroundColor: Colors.amber,
                                  onPressed: () {
                                    if (maincontroller.pageviewIndex.value >
                                        4) {
                                      maincontroller.pageviewIndex.value = 4;
                                    }
                                    maincontroller.pageviewIndex.value =
                                        maincontroller.pageviewIndex.value + 1;
                                    maincontroller.pageviewIndex.refresh();
                                    print(maincontroller.pageviewIndex.value);
                                    //  _pageController.initialPage= _pageController.initialPage--
                                    _pageController.jumpToPage(
                                        maincontroller.pageviewIndex.value);
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/fwhitelogo.png',
                          color: const Color(0xFF5A31F4),
                          height: 100,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }
      },
    ));
  }

  Widget responceWidgetLogin() {
    return Stack(
      children: [
        // Custom background painter
        Positioned.fill(
          child: CustomPaint(
            painter: BackgroundPainter(),
          ),
        ),
        // Centered login form
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                      key: formcontrollers,
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
                            'Login',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          TextFormField(
                            controller: emailController,
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
                          Obx(
                            () => TextFormField(
                              textInputAction: TextInputAction.done,

                              controller: passwordController,
                              validator: (value) => value!.trim().isNotEmpty &&
                                      value.trim().length > 7
                                  ? null
                                  : "Password must be at least 8 characters",
                              obscureText: maincontroller.ispassVisible.value,

                              onFieldSubmitted: (value) {
                                _onPressed();
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
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
                                suffixIcon: Obx(
                                  () => IconButton(
                                    onPressed: () {
                                      maincontroller.ispassVisible.toggle();
                                    },
                                    icon: Icon(
                                      maincontroller.ispassVisible.value ==
                                              false
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: const Color(0xFF5A31F4),
                                    ),
                                  ),
                                ),
                              ),
                              // initialValue: 'hhhhhhhhhhhhhhhhh',
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () => Checkbox(
                                      value:
                                          maincontroller.shouldbeLoggedIn.value,
                                      onChanged: (value) {
                                        maincontroller.shouldbeLoggedIn.value =
                                            !maincontroller
                                                .shouldbeLoggedIn.value;
                                      },
                                      activeColor: const Color(0xFF5A31F4),
                                    ),
                                  ),
                                  const Text('Keep me signed in'),
                                ],
                              ),
                              TextButton(
                                onPressed: () => Get.to(
                                  () => const ResetPass(),
                                ),
                                child: const Text(
                                  'Forgot login details?',
                                  style: TextStyle(color: Color(0xFF5A31F4)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _onPressed();
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                backgroundColor: const Color(0xFF5A31F4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  Get.to(
                                    () => const CreateAccountPage(),
                                  );
                                },
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(color: Color(0xFF5A31F4)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

        // Align(
        //   alignment: Alignment.bottomRight,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Image.asset(
        //       'assets/fwhitelogo.png',
        //       color: const Color(0xFF5A31F4),
        //       height: 100,
        //     ),
        //   ),
        // )
      ],
    );
  }

  void _closeDialog() {
    if (loadingDialogContext != null) {
      Navigator.of(loadingDialogContext!).pop();
      loadingDialogContext = null;
    }
  }

  void sendVerify() async {
    _showLoading("Loading...");
    try {
      await auth.currentUser!.sendEmailVerification().then((_) {
        _closeDialog();
        checkEmail(context, "Check Your Email",
            "Verify your email by clicking on the email that has been sent to ${emailController.text.trim().toLowerCase()}");
      }).catchError((err) {
        _closeDialog();
        showVerify("Could Not send Verification Email", "Please try again");
      });
    } catch (e) {
      _closeDialog();
      showVerify("Could Not send Verification Email", "Please try again");
    }
  }

  Future<void> showVerify(String message, String message1) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          content: Text(message1),
          actions: [
            TextButton(
              child: Text('cancel'.toUpperCase()),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('send request'.toUpperCase()),
              onPressed: () {
                Navigator.pop(context);
                sendVerify();
              },
            ),
          ],
        );
      },
    );
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
