import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finitepay/beneficiary/beneficiary_page.dart';
import 'package:finitepay/bridgecards_test/test_customer_card.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/views/conversion_page.dart';
import 'package:finitepay/views/home/balances_page.dart';
import 'package:finitepay/views/home/on_boarding_page.dart';
import 'package:finitepay/views/home/transactions_page.dart';
import 'package:finitepay/views/overviewpage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:simple_icons/simple_icons.dart';
// import 'package:intl/intl.dart';

class Maincontroller extends GetxController {
  final companyOrIndividual = 'individual'.obs;
   PageController pageController = PageController();

  final firstCurrency = ''.obs;

  final secondCurrency = ''.obs;
  final selectedregOpt = ''.obs;
  final selectedSubAct = ''.obs;
  final countryCode = ''.obs;
  final fileLink = ''.obs;
  final filetype = ''.obs;
  final initialcurrencyIndex = 0.obs;
  final merchID = ''.obs;

  final responceCode = 0.obs;

  final currencyIndex = 0.obs;

  final pageviewIndex=0.obs;

  final cardCreatedFromHome = false.obs;

  final shouldCreateCard = false.obs;

  QueryDocumentSnapshot<Map<String, dynamic>>? cardholderDB;

  TextEditingController percentageSharesController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController postalController = TextEditingController();

  TextEditingController nationalIdController = TextEditingController();

  TextEditingController businessName = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController currencyController = TextEditingController();

  TextEditingController beneficiaryNickName = TextEditingController();
  TextEditingController bankcountryController = TextEditingController();

  TextEditingController accountNameHolderController = TextEditingController();
  TextEditingController beneficiaryTypeController = TextEditingController();
  TextEditingController bicSwiftController = TextEditingController();

  TextEditingController accountNumber = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController sourceAccount = TextEditingController();
  TextEditingController destinationAccount = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController amountTransfer = TextEditingController();

  TextEditingController beneficiaryCountry = TextEditingController();

  TextEditingController registrationOpt = TextEditingController();

  TextEditingController subAccountOpt = TextEditingController();

  // final currenttimeZone = ''.obs;
  final currentTabIndex = 0.obs;

  final ispassVisible = true.obs;

  final merchantID = ''.obs;

  final paymentsList = [].obs;

  final selectedDate = DateTime.now().obs;

  // Method to calculate age
  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void onItemClicked(int index) {
    currentTabIndex.value = index;

    // if (index == 4) {
    //   // index = 5;
    //   currentTabIndex.value = 5;
    // }

    currentTabIndex.refresh();
  }

  BuildContext? loadingDialogContext;
  Future<void> showLoading(String message) {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        loadingDialogContext = context;
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircularProgressIndicator(
                backgroundColor: Colors.white,
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

  // Method to show date picker and validate the selected date
  Future<void> selectDate(BuildContext context, bool iskyc) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      // setState(() {
      selectedDate.value = picked;
      // });

      int age = calculateAge(picked);

      if (age < 18 && iskyc) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Age is less than 18 years.'),
            duration: Duration(seconds: 3),
          ),
        );
      } else if (iskyc) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Age is valid.'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        kycController.dobController.value.text =
            DateFormat('yyyy-MM-dd').format(maincontroller.selectedDate.value);
        kycController.dateofIncorporation.value.text =
            DateFormat('yyyy-MM-dd').format(maincontroller.selectedDate.value);
      }
    }
  }

  RxList<Widget> dashIcons = <Widget>[
    Obx(
      () => authenticationController.userDetails.value.onboardingDone == true
          ? Container()
          : ListTile(
              onTap: () {
                maincontroller.currentTabIndex.value = 0;
                if (Get.width <= 500) {
                  Get.back();
                  print('Get back');
                }
              },
              title: const Text(
                "Onboarding",
              ),
              leading: const Icon(
                Icons.work_outline,
              ),
              // tileColor: Colors.purple[50],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
    ),
    ListTile(
      onTap: () {
        maincontroller.currentTabIndex.value = 1;
        if (Get.width <= 500) {
          Get.back();
          print('Get back');
        }
      },
      title: const Text("Overview"),
      leading: const Icon(Icons.dashboard_outlined),
    ),
    ListTile(
      onTap: () {
        maincontroller.currentTabIndex.value = 2;
        if (Get.width <= 500) {
          Get.back();
          print('Get back');
        }
      },
      title: const Text("Balances"),
      leading: const Icon(Icons.account_balance_wallet_outlined),
    ),

    // const SizedBox(height: 20),
    ListTile(
      onTap: () {
        maincontroller.currentTabIndex.value = 3;
        if (Get.width <= 500) {
          Get.back();
          print('Get back');
        }
      },
      title: const Text("Transactions"),
      leading: const Icon(Icons.monetization_on_outlined),
    ),
    ListTile(
      onTap: () {
        maincontroller.currentTabIndex.value = 4;
        if (Get.width <= 500) {
          Get.back();
          print('Get back');
        }
      },
      title: const Text("Beneficiaries"),
      leading: const Icon(
        Icons.people_outline,
      ),
    ),
    ListTile(
      onTap: () {
        maincontroller.currentTabIndex.value = 5;
        if (Get.width <= 500) {
          Get.back();
          print('Get back');
        }
      },
      title: const Text("Conversions"),
      leading: const Icon(Icons.swap_horiz),
    ),

    ListTile(
      onTap: () {
        maincontroller.currentTabIndex.value = 6;
      },
      title: const Text("Cards"),
      leading: const Icon(
        Icons.credit_card,
      ),
    ),
    // ListTile(
    //   onTap: () {
    //     maincontroller.currentTabIndex.value = 7;
    //   },
    //   title: const Text("Pay-Outs"),
    //   leading: const Icon(Icons.money_outlined),
    // ),
    // // const ExpansionTile(
    // //   title: Text("Pay-Ins"),
    // //   leading: Icon(Icons.attach_money_outlined),
    // //   children: [
    // //     ListTile(title: Text("Option 1")),
    // //     ListTile(title: Text("Option 2")),
    // //   ],
    // // ),
    // // const ExpansionTile(
    // //   title: Text("Pay-Outs"),
    // //   leading: Icon(Icons.money_outlined),
    // //   children: [
    // //     ListTile(title: Text("Option 1")),
    // //     ListTile(title: Text("Option 2")),
    // //   ],
    // // ),

    // ListTile(
    //   onTap: () {
    //     maincontroller.currentTabIndex.value = 8;
    //   },
    //   title: const Text("Settlements"),
    //   leading: const Icon(Icons.receipt_long),
    // ),
    // ListTile(
    //   onTap: () {
    //     maincontroller.currentTabIndex.value = 9;
    //   },
    //   title: const Text("Subaccounts"),
    //   leading: const Icon(Icons.book),
    // ),
    // ListTile(
    //   onTap: () {
    //     maincontroller.currentTabIndex.value = 10;
    //   },
    //   title: const Text("Transaction Splits"),
    //   leading: const Icon(Icons.diversity_1),
    // ),
    // ListTile(
    //   onTap: () {
    //     maincontroller.currentTabIndex.value = 11;
    //   },
    //   title: const Text("Terminal"),
    //   leading: const Icon(Icons.terminal),
    // ),
    // ListTile(
    //   onTap: () {
    //     maincontroller.currentTabIndex.value = 12;
    //   },
    //   title: const Text("Users And Roles"),
    //   leading: const Icon(Icons.people_outline),
    // ),
  ].obs;

  // Observable boolean to track checkbox state
  var isShareholder = false.obs;
  var shouldbeLoggedIn = false.obs;

  final isUbo = false.obs;
  //  final percentageShares = 0.obs;

  RxDouble uploadProgress = 0.0.obs;
  RxDouble directorID = 0.0.obs;
  RxDouble directorResidenceProgress = 0.0.obs;
  RxDouble incoyporationcertProgress = 0.0.obs;
  RxDouble associationArt = 0.0.obs;
  RxDouble utibill = 0.0.obs;

  RxList<Widget> mobileScreensList = <Widget>[
    Obx(
      () => authenticationController.userDetails.value.onboardingDone == true
          ? const OverPageScreen()
          : const OnboadingScreen(),
    ),
    const TestCustomerCards(),
    const BalancesPage(),
    const TranscationsPage(),
    Get.width <= 800
        ? const CurrencyConversionPage()
        : BeneficiaryPage(
            ispay: false,
          ),
    const CurrencyConversionPage(),
    const TestCustomerCards(),
  ].obs;

  RxList<Widget> pagesList = <Widget>[
    Obx(
      () => authenticationController.userDetails.value.onboardingDone == true
          ? const OverPageScreen()
          : const OnboadingScreen(),
    ),
    const OverPageScreen(),
    const BalancesPage(),
    const TranscationsPage(),
    Get.width <= 800
        ? const CurrencyConversionPage()
        : BeneficiaryPage(
            ispay: false,
          ),
    const CurrencyConversionPage(),
    const TestCustomerCards(),
  ].obs;

  Future<void> pickAndUploadPdf(String title, RxDouble progress) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile pickedFile = result.files.first;

      UploadTask uploadTask;
      if (kIsWeb) {
        // Web-specific upload logic
        uploadTask = FirebaseStorage.instance
            .ref('uploads/${pickedFile.name}')
            .putData(pickedFile.bytes!);
      } else {
        // Mobile upload logic
        File file = File(pickedFile.path!);
        uploadTask = FirebaseStorage.instance
            .ref('uploads/${pickedFile.name}')
            .putFile(file);
      }

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        // setState(() {
        progress.value = snapshot.bytesTransferred / snapshot.totalBytes * 100;

        print(uploadProgress.value);
        // });
      });

      uploadTask.then((TaskSnapshot snapshot) async {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('Documents').add({
          "doc_title": title,
          'file_name': pickedFile.name,
          'url': downloadUrl,
          'uploaded_at': Timestamp.now(),
          'companyName':
              authenticationController.userDetails.value.businessName,
          'uploadedBy': authenticationController.userDetails.value.fullname,
          'uploaderEmail': authenticationController.userDetails.value.email,
        });

        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
              backgroundColor: const Color.fromARGB(255, 5, 106, 8),
              content: Text('Upload complete: ${pickedFile.name}')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text('Failed to upload: $error')),
        );
      });
    }
  }

  gettime() {
    final currentTime = DateTime.now();
    final currentHour = currentTime.hour;

    String greeting;

    if (currentHour < 12) {
      greeting = 'Good Morning';
      return greeting;
    } else if (currentHour < 17) {
      greeting = 'Good Afternoon';
      return greeting;
    } else {
      greeting = 'Good Evening';
      return greeting;
    }
  }

  String timeAgo(uploadTime) {
    final now = DateTime.now();
    final Duration difference = now.difference(uploadTime);

    if (difference.inDays >= 365) {
      return '${difference.inDays ~/ 365} ${difference.inDays ~/ 365 == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays >= 30) {
      return '${difference.inDays ~/ 30} ${difference.inDays ~/ 30 == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays >= 7) {
      return '${difference.inDays ~/ 7} ${difference.inDays ~/ 7 == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  Future getCardHolder() async {
    FirebaseFirestore.instance
        .collection('CardHolders')
        .where('uid', isEqualTo: fAuth.currentUser?.uid ?? '')
        .get()
        .then((value) {
      for (var docdata in value.docs) {
        cardholderDB = docdata;
      }
      cardsController.getCustomerCards(
        cardholderDB?.data()['cardholder_id'],
      );
    }).then((value) {
      // USED DURING TESTING PURPOSES COMMENTED OUT
      // Get.snackbar('Success', 'Retrived cardholder successfully');
    }).catchError(
      (e) {
        // USED DURING TESTING PURPOSES COMMENTED OUT
        // Get.snackbar('Error', 'Following error occured $e');
      },
    );
  }

  @override
  void onInit() {
    gettime();

    // getTimeZone();
    super.onInit();
  }

  @override
  void onReady() {
    if (fAuth.currentUser != null) {
      getCardHolder();
    }
    super.onReady();
  }
}
