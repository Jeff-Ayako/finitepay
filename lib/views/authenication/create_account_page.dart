import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:finitepay/components/overrall_btn.dart';
// import 'package:finitepay/components/drop_down_btn.dart';
import 'package:finitepay/components/progressdialog.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/main.dart';
import 'package:finitepay/models/users_model.dart';
import 'package:finitepay/views/authenication/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:uuid/uuid.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool agree = false;
  String image64base = "";

  BuildContext? loadingDialogContext;
  final auth = FirebaseAuth.instance;

  bool obsecure = true;
  bool obsecure2 = true;
  bool match = true;
  bool obscure1 = true;
  bool obscure2 = true;
  bool isZero = false;
  bool isZero1 = false;
  bool isZerod = false;
  bool isZerom = false;

  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var box = Hive.box(darkModeBox);

  void registerUser() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      authenticationController.showLoading("Loading...");
      try {
        await auth
            .createUserWithEmailAndPassword(
                email: maincontroller.emailController.text.trim().toLowerCase(),
                password: maincontroller.passwordController.text.trim())
            .then((_) {
          _recordUserDetails();
          // subAccountController.createSubaccount();
        }).catchError((err) {
          authenticationController.closeDialog();
          if (err.message ==
              "The email address is already in use by another account.") {
            showUpDismissible(context, "User Already Exists", err.message);
          } else {
            showUpDismissible(
                context,
                "Could Not Create an Account ${err.message}",
                "Please try again later ");
          }
        });
      } catch (e) {
        authenticationController.closeDialog();
        showUpDismissible(
            context, "Could Not Create an Account", "Please try again later");
      }
    } else {
      showUpDismissible(context, 'No Internet Connection',
          'Please connect to internet and try again');
    }
  }

  void _recordUserDetails() async {
    try {
      var random = Random.secure();
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User user = auth.currentUser!;
      String username = "user@${random.nextInt(1000000000)}";

      // late Algolia _algoria;

      // UserDetails userDetails = UserDetails();
      authenticationController.userDetails.value.uid = user.uid;
      authenticationController.userDetails.value.email = user.email;
      authenticationController.userDetails.value.fullname =
          maincontroller.fullNameController.text.trim();
      // authenticationController  .userDetails.value.username = username;
      authenticationController.userDetails.value.phone =
          maincontroller.phoneNoController.text.trim();
      authenticationController.userDetails.value.age = 18;
      authenticationController.userDetails.value.businessName =
          maincontroller.businessName.text.toString();

      authenticationController.userDetails.value.onboardingDone = false;

      authenticationController.userDetails.refresh();

      authenticationController.userDetails.value.city =
          signUpController.cityValue.value;
      authenticationController.userDetails.value.country =
          signUpController.countryValue.value;
      authenticationController.userDetails.value.state =
          signUpController.stateValue.value;

      authenticationController.userDetails.value.dob =
          DateFormat('yyyy-MM-dd').format(maincontroller.selectedDate.value);
      authenticationController.userDetails.value.postalCode =
          maincontroller.postalController.text.toString() ?? '';

      authenticationController.userDetails.value.nationalID =
          maincontroller.nationalIdController.text.toString() ?? '';
      authenticationController.userDetails.value.currencyKey = '';
      authenticationController.userDetails.value.firstName =
          maincontroller.firstNameController.text.toString() ?? '';

      authenticationController.userDetails.value.lastName =
          maincontroller.lastNameController.text.toString() ?? '';

      authenticationController.userDetails.value.registrationType =
          maincontroller.companyOrIndividual.value;

      await firebaseFirestore
          .collection('users')
          .doc(user.email)
          .collection("information")
          .doc(user.uid)
          .set(
            authenticationController.userDetails.value.toMap(),
          )
          .then((_) {
        check("success");
        firebaseFirestore
            .collection('Businesses')
            .doc(fAuth.currentUser?.uid ?? '')
            .set(
              authenticationController.userDetails.value.toMap(),
            );
      }).then((value) {
        currencyCloudController
            .loginToCurrencyCloud('jeff@finitepay.org',
                '41a86cf60bcff796a98dcbf1a2cc9739f632eb6a685b46201098747c9103d552')
            .then((value) {
          subAccountController.createSubaccount(
            maincontroller.fullNameController.text.toString().trim(),
            maincontroller.companyOrIndividual.value.trim(),
            '${signUpController.cityValue.value},${signUpController.stateValue.value}',
            signUpController.cityValue.value, 'KE',
            // countryCodes[signUpController.countryValue.value.capitalizeFirst] ??
            //     'KE',
            maincontroller.postalController.text.trim(),
            maincontroller.emailController.text.toString(),
            // const Uuid().v4().toString().trim(),
            'enabled',
            signUpController.stateValue.value,
            'national_id',
            maincontroller.nationalIdController.text.trim(),
          );
        });
      }).catchError((err) {
        check("error");
      });
    } catch (e) {
      check("error");
    }
  }

  check(result) async {
    if ('success' == result) {
      // await incrementNumberField();

      // int updatedNumber = await fetchNumber();

      // await updateUserWithNumber(updatedNumber);
      verifyEmail();
    } else {
      deleteUser(maincontroller.emailController.text.trim().toLowerCase(),
          maincontroller.passwordController.text.trim());
      authenticationController.closeDialog();
      showUpDismissible(
          context, "Could Not Create an Account", "Please try again later");
    }
  }

  Future<void> incrementNumberField() async {
    final firestore = FirebaseFirestore.instance;
    final CollectionReference numbersCollection =
        firestore.collection('usernumbers');
    await numbersCollection.doc("usernumbers").update({
      'totalusernumbers': FieldValue.increment(1),
    });
  }

  Future<int> fetchNumber() async {
    final DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('usernumbers')
        .doc("usernumbers")
        .get();
    if (document.exists) {
      final data = document.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('totalusernumbers')) {
        return data['totalusernumbers'] as int;
      }
    }

    return 0;
  }

  Future<void> updateUserWithNumber(int updatedNumber) async {
    final firestore = FirebaseFirestore.instance;
    final CollectionReference usersCollection = firestore
        .collection('users')
        .doc(user!.email)
        .collection("information");

    await usersCollection.doc(user!.uid).update({
      'usernumber': updatedNumber,
    });
  }

  // googleSignFunc(value) async {
  //   try {
  //     var random = Random.secure();
  //     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //     User user = auth.currentUser!;
  //     String username = "user@${random.nextInt(1000000000)}";

  //     // UserDetails userDetails = UserDetails();
  //     authenticationController  .userDetails.value.uid = value.user?.uid ?? 'uid';

  //     // authenticationController  .userDetails.value.price = 0.0;

  //     authenticationController  .userDetails.value.email = value.user?.email ?? 'Email';
  //     // authenticationController  .userDetails.value.profileImage = value.user?.photoURL ??
  //         'https://avatars.mds.yandex.net/i?id=20978d9bcf9074e6f2f9f08b54cc45f4482cda5f-9461935-images-thumbs&n=13';
  //     authenticationController  .userDetails.value.fullname =
  //         value.user?.displayName ?? "user@${random.nextInt(1000000000)}";
  //     // authenticationController  .userDetails.value.username = username;
  //     authenticationController  .userDetails.value.phone =
  //         value.user?.phoneNumber ?? 'Phone Number';
  //     // authenticationController  .   userDetails.value.subscriberCount = 0;
  //     // authenticationController  .   userDetails.value.watchTimeHours = 0.00;
  //     await firebaseFirestore
  //         .collection('users')
  //         .doc(user.email)
  //         .collection("information")
  //         .doc(user.uid)
  //         .set(
  //           authenticationController  .userDetails.value.toMap(),
  //         )
  //         .then((_) {
  //       saveNotif();
  //       _showBigPictureNotificationFURL();
  //       // check("success");
  //       Get.to(
  //         const MySplashScreen(),
  //         transition: Transition.circularReveal,
  //         duration: const Duration(
  //           milliseconds: 700,
  //         ),
  //       );
  //     }).catchError((err) {
  //       check("error");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           backgroundColor: Colors.red,
  //           content: Text(
  //             'Error occurred please try again or Sign up with Your Email and Password',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(fontSize: 15),
  //           ),
  //         ),
  //       );
  //     });
  //   } catch (e) {
  //     check("error");
  //   }
  // }

  // googleSignUp() {
  //   bool isdialogue = false;
  //   isdialogue == false
  //       ? Get.dialog(
  //           SizedBox(
  //             height: 200,
  //             child: AlertDialog(
  //               title: const Center(child: Text('Please Wait')),
  //               content: SizedBox(
  //                 height: 200,
  //                 child: Center(
  //                   child: LottieBuilder.asset(
  //                     'assets/load7.json',
  //                     height: Get.height / 3.5,
  //                     width: Get.width / 3.5,
  //                     fit: BoxFit.contain,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         )
  //       : null;
  //   kIsWeb
  //       ? signInWithGoogleWeb().then((value) async {
  //           googleSignFunc(value);
  //         })
  //       : signInWithGoogle().then((value) async {
  //           googleSignFunc(value);
  //         });
  // }

  void verifyEmail() async {
    try {
      await auth.currentUser!.sendEmailVerification().then((_) {
        _logoutUser();
        // _saveNumber(emailController.text.trim().toLowerCase(), uid);
        saveNotif();
        _showBigPictureNotificationFURL();
        authenticationController.closeDialog();
        Get.offAll(
          () => LoginPage(),
        );
        // Navigator.of(context).pop();
        checkEmail(context, "Check Your Email",
            "Verify your account by clicking on the email that has been sent to ${maincontroller.emailController.text.trim().toLowerCase()}");
      }).catchError((err) {
        _logoutUser();
        // _saveNumber(emailController.text.trim().toLowerCase(), uid);
        saveNotif();
        _showBigPictureNotificationFURL();
        authenticationController.closeDialog();
        // Navigator.of(context).pop();
        Get.offAll(
          () => LoginPage(),
        );
        showUpDismissible(context, "Account Created Successfully",
            "You can login to verify your account");
      });
    } catch (e) {
      _logoutUser();
      // _saveNumber(emailController.text.trim().toLowerCase(), uid);
      saveNotif();
      _showBigPictureNotificationFURL();
      authenticationController.closeDialog();
      // Navigator.of(context).pop();
      Get.offAll(
        () => LoginPage(),
      );
      showUpDismissible(context, "Account Created Successfully",
          "You can login to verify your account");
    }
  }

  void saveNotif() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = auth.currentUser!;
    DateTime now = DateTime.now();
    var random = Random.secure();
    var uniqdoc = "Not${user.uid}${random.nextInt(1000000000)}";
    if (now.hour < 10) {
      setState(() {
        isZero1 = true;
      });
    } else {
      setState(() {
        isZero1 = false;
      });
    }
    if (now.minute < 10) {
      setState(() {
        isZero = true;
      });
    } else {
      setState(() {
        isZero = false;
      });
    }

    if (now.month < 10) {
      setState(() {
        isZerom = true;
      });
    } else {
      setState(() {
        isZerom = false;
      });
    }
    if (now.day < 10) {
      setState(() {
        isZerod = true;
      });
    } else {
      setState(() {
        isZerod = false;
      });
    }

    String gDate = isZerom
        ? isZerod
            ? isZero1
                ? isZero
                    ? "${now.year}0${now.month}0${now.day}0${now.hour}0${now.minute}"
                    : "${now.year}0${now.month}0${now.day}0${now.hour}${now.minute}"
                : isZero
                    ? "${now.year}0${now.month}0${now.day}${now.hour}0${now.minute}"
                    : "${now.year}0${now.month}0${now.day}${now.hour}${now.minute}"
            : isZero1
                ? isZero
                    ? "${now.year}0${now.month}${now.day}0${now.hour}0${now.minute}"
                    : "${now.year}0${now.month}${now.day}0${now.hour}${now.minute}"
                : isZero
                    ? "${now.year}0${now.month}${now.day}${now.hour}0${now.minute}"
                    : "${now.year}0${now.month}${now.day}${now.hour}${now.minute}"
        : isZerod
            ? isZero1
                ? isZero
                    ? "${now.year}${now.month}0${now.day}0${now.hour}0${now.minute}"
                    : "${now.year}${now.month}0${now.day}0${now.hour}${now.minute}"
                : isZero
                    ? "${now.year}${now.month}0${now.day}${now.hour}0${now.minute}"
                    : "${now.year}${now.month}0${now.day}${now.hour}${now.minute}"
            : isZero1
                ? isZero
                    ? "${now.year}${now.month}${now.day}0${now.hour}0${now.minute}"
                    : "${now.year}${now.month}${now.day}0${now.hour}${now.minute}"
                : isZero
                    ? "${now.year}${now.month}${now.day}${now.hour}0${now.minute}"
                    : "${now.year}${now.month}${now.day}${now.hour}${now.minute}";

    Notifs notifications = Notifs();
    notifications.type = "Notification";
    notifications.title = 'Welcome to FinitePay';
    notifications.body =
        "Congratulations ${maincontroller.fullNameController.text.trim()} for joining FinitePay. We hope you will have a great experience using our services. FinitePay, Lets do more";
    notifications.serverdate = gDate;
    notifications.datenow = now;
    notifications.checked = "1";

    return firebaseFirestore
        .collection("users")
        .doc(user.email)
        .collection("notifications")
        .doc(uniqdoc)
        .set(notifications.toMap())
        .then((value) async {});
  }

  Future<void> _showBigPictureNotificationFURL() async {
    final ByteArrayAndroidBitmap largeIcon =
        ByteArrayAndroidBitmap(base64Decode(image64base));
    final ByteArrayAndroidBitmap bigPicture =
        ByteArrayAndroidBitmap(base64Decode(image64base));

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(bigPicture,
            largeIcon: largeIcon,
            contentTitle: 'Welcome to FinitePay',
            htmlFormatContentTitle: true,
            summaryText:
                "Congratulations ${maincontroller.fullNameController.text.trim()} for joining FinitePay. We hope you will have a great experience using our services. FinitePay, lets do more",
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", "chname",
            channelDescription: "chdesc",
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        1,
        'Welcome to FinitePay',
        "Congratulations ${maincontroller.fullNameController.text.trim()} for joining FinitePay. We hope you will have a great experience using our services. FinitePay, lets do more",
        notificationDetails);
  }

  void _logoutUser() async {
    if (auth.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  void deleteUser(String email, String pass) async {
    User user = auth.currentUser!;
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pass);
    await user.reauthenticateWithCredential(credential).then((value) {
      value.user!.delete();
    }).catchError((onError) => null);
  }

  getThumbnail() async {
    ByteData bytes = await rootBundle.load("assets/finitepay.png");
    setState(() {
      image64base = base64Encode(bytes.buffer.asUint8List());
    });
  }

  @override
  void initState() {
    getThumbnail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return createAccountWidget();
        } else {
          return Row(
            children: [
              Expanded(
                child: createAccountWidget(),
              ),
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

  Widget createAccountWidget() {
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
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 90.0),
                    child: Padding(
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
                              'Create Account',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            // TextFormField(
                            //   decoration: InputDecoration(
                            //     labelText: 'Email Address',
                            //     labelStyle: const TextStyle(color: Colors.black54),
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(8.0),
                            //       borderSide: const BorderSide(
                            //         color: Color(0xFF5A31F4),
                            //       ),
                            //     ),
                            //     focusedBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(8.0),
                            //       borderSide: const BorderSide(
                            //         color: Color(0xFF5A31F4),
                            //       ),
                            //     ),
                            //   ),
                            //   // initialValue: 'jeffayako1@gmail.com',
                            // ),
                            // const SizedBox(height: 16.0),
                            txtForm(
                              'First Name',
                              maincontroller.firstNameController,
                              (value) => (value!.trim().isEmpty)
                                  ? "First Name is required"
                                  : (value.trim().length < 2)
                                      ? "Enter a valid First Name"
                                      : null,
                            ),
                            txtForm(
                              'Last Name',
                              maincontroller.lastNameController,
                              (value) => (value!.trim().isEmpty)
                                  ? "Last Name is required"
                                  : (value.trim().length < 2)
                                      ? "Enter a valid Last Name"
                                      : null,
                            ),
                            txtForm(
                              'Phone Number',
                              maincontroller.phoneNoController,
                              (value) => (value!.trim().isEmpty)
                                  ? "Phone Number is required"
                                  : (value.trim().length < 9)
                                      ? "Enter a valid phone number"
                                      : null,
                            ),
                            txtForm(
                              'Business Name',
                              maincontroller.businessName,
                              (value) => (value!.trim().isEmpty)
                                  ? "Full Name is required"
                                  : (value.trim().length < 2)
                                      ? "Enter a valid Full Name"
                                      : null,
                            ),
                            txtForm(
                              'Enter Your Email',
                              maincontroller.emailController,
                              (email) => email != null &&
                                      !EmailValidator.validate(email.trim())
                                  ? 'Enter a Valid email'
                                  : null,
                            ),

                            // const SizedBox(height: 16.0),
                            // // CSCPicker(
                            // //   dropdownDecoration: BoxDecoration(
                            // //       borderRadius: BorderRadius.circular(5),
                            // //       color: Theme.of(context).cardColor),
                            // //   selectedItemStyle:
                            // //       const TextStyle(color: Colors.black),
                            // //   dropdownHeadingStyle:
                            // //       const TextStyle(color: Colors.black),
                            // //   dropdownItemStyle:
                            // //       const TextStyle(color: Colors.black),
                            // //   flagState: CountryFlag.DISABLE,
                            // //   onCountryChanged: (value) {
                            // //     signUpController.countryValue.value = value;
                            // //   },
                            // //   onStateChanged: (value) {
                            // //     signUpController.stateValue.value =
                            // //         value.toString();
                            // //   },
                            // //   onCityChanged: (value) {
                            // //     signUpController.cityValue.value =
                            // //         value.toString();
                            // //     print(signUpController.cityValue.value);
                            // //   },
                            // // ),

                            // const SizedBox(height: 16.0),
                            txtForm(
                              'Postal Code',
                              maincontroller.postalController,
                              (value) => (value!.trim().isEmpty)
                                  ? "Postal Code is required"
                                  : (value.trim().length < 2)
                                      ? "Enter a valid Postal Code"
                                      : null,
                            ),
                            txtForm(
                              'National ID Number',
                              maincontroller.nationalIdController,
                              (value) => (value!.trim().isEmpty)
                                  ? "National ID Number is required"
                                  : (value.trim().length < 8)
                                      ? "Enter a valid National ID Number"
                                      : null,
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Obx(
                                    () => Text(
                                      maincontroller.selectedDate.value != null
                                          ? 'Selected Date: ${DateFormat('yyyy-MM-dd').format(maincontroller.selectedDate.value)}'
                                          : 'No date selected',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Btn(
                                    txtColor: Colors.black,
                                    ontap: () => maincontroller.selectDate(
                                        context, true),
                                    btnName: 'Select Date of Birth',
                                    color: Colors.transparent,
                                  ),
                                  // ElevatedButton(
                                  //   onPressed: () =>
                                  //       maincontroller.selectDate(context),
                                  //   child: const Text('Select Date of Birth'),
                                  // ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => ListTile(
                                      title: const Text('Individual'),
                                      leading: Radio<String>(
                                        value: 'individual',
                                        groupValue: maincontroller
                                            .companyOrIndividual.value,
                                        onChanged: (String? value) {
                                          // setState(() {
                                          maincontroller.companyOrIndividual
                                              .value = value!;
                                          // });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Obx(
                                    () => ListTile(
                                      title: const Text('Company'),
                                      leading: Radio<String>(
                                        value: 'company',
                                        groupValue: maincontroller
                                            .companyOrIndividual.value,
                                        onChanged: (String? value) {
                                          // setState(() {
                                          maincontroller.companyOrIndividual
                                              .value = value!;
                                          // });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // updatedDropDown(
                            //     controller: maincontroller.registrationOpt,
                            //     items: registrationOptions,
                            //     hintTxt: 'Indentification Type'),
                            // updatedDropDown(
                            //     controller: maincontroller.subAccountOpt,
                            //     items: subaccountIdentificationOptions,
                            //     hintTxt: 'Registration with'),
                            const SizedBox(height: 16.0),
                            Obx(
                              () => TextFormField(
                                controller: maincontroller.passwordController,
                                obscureText: maincontroller.ispassVisible.value,
                                validator: (value) => value!
                                            .trim()
                                            .isNotEmpty &&
                                        value.trim().length > 7
                                    ? null
                                    : "Password must be at least 8 characters",
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

                            Obx(
                              () => TextFormField(
                                controller: confirmPasswordController,
                                obscureText: maincontroller.ispassVisible.value,
                                validator: (value) => value!
                                            .trim()
                                            .isNotEmpty &&
                                        value.trim().length > 7
                                    ? null
                                    : "Password must be at least 8 characters",
                                onFieldSubmitted: (value) {
                                  _onPressed();
                                },
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: true,
                                      onChanged: (value) {},
                                      activeColor: const Color(0xFF5A31F4),
                                    ),
                                    const Text('Keep me signed in'),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {},
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  backgroundColor: const Color(0xFF5A31F4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  'Create My Account',
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
                                      () => const LoginPage(),
                                    );
                                  },
                                  child: const Text(
                                    ' Have an Account? Login',
                                    style: TextStyle(color: Color(0xFF5A31F4)),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(),
                            const Text(
                                '''By clicking the “Create your account” button, you agree to FinitePay’s terms of acceptable use and Data Processing Agreement.'''),

                            const Divider(),
                            const Text(
                                '''To learn more about how Paystack collects, uses and discloses your personal data, please read our Privacy Policy.''')
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
    );
  }

  _onPressed() async {
    maincontroller.fullNameController.text =
        '${maincontroller.firstNameController.text.toString()} ${maincontroller.lastNameController.text.toString()}';
    if (formKey.currentState!.validate()) {
      if (maincontroller.passwordController.text.trim() ==
          confirmPasswordController.text.trim()) {
        registerUser();
      } else {
        setState(() {
          match = false;
        });
        showUpDismissible(context, "Passwords Do Not Match!!", "");
      }
    }
  }
}

Widget txtForm(
    String formLable, TextEditingController controller, validatiorFunc) {
  return Column(
    children: [
      TextFormField(
        controller: controller,
        validator: validatiorFunc,
        decoration: InputDecoration(
          labelText: formLable,
          labelStyle: const TextStyle(color: Colors.black54),
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
    ],
  );
}

@override
bool shouldRepaint(CustomPainter oldDelegate) {
  return false;
}

// class IdentificationOptions extends StatelessWidget {
//   const IdentificationOptions({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//         children: <Widget>[
//           ListTile(
//             title: const Text('Option 1'),
//             leading: Radio<String>(
//               value: 'Option 1',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   _selectedOption = value!;
//                 });
//               },
//             ),
//           ),
//           ListTile(
//             title: const Text('Option 2'),
//             leading: Radio<String>(
//               value: 'Option 2',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value!;
//                 });
//               },
//             ),
//           ),
//           ListTile(
//             title: const Text('Option 3'),
//             leading: Radio<String>(
//               value: 'Option 3',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   _selectedOption = value!;
//                 });
//               },
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'Selected Option: $selectedOption',
//             style: TextStyle(fontSize: 18),
//           ),
//         ],
//       );
//   }
// }
