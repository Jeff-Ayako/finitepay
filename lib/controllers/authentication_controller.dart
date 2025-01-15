import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pre_eclampsia_app/global_variables.dart';
// import 'package:pre_eclampsia_app/main.dart';

import '../models/users_model.dart';

import 'package:hive/hive.dart';

class AuthenticationController extends GetxController {
  final userDetails = UserDetails().obs;
  
  BuildContext? loadingDialogContext;

  final userDetailsRef = UserDetails().obs;

  getmode() async {
    var box = await Hive.openBox(darkModeBox);
    return box.get(darkModeBox, defaultValue: false);
  }

  
  void closeDialog() {
    if (loadingDialogContext != null) {
      Navigator.of(loadingDialogContext!).pop();
      loadingDialogContext = null;
    }
  }

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

  Future getuserdetails() async {
    fAuth.currentUser != null
        ? FirebaseFirestore.instance
            .collection('users')
            .doc(fAuth.currentUser!.email)
            .collection("information")
            .doc(fAuth.currentUser?.uid ?? '')
            .get()
            .then((value) {
            // setState(() {
            userDetails.value = UserDetails.fromMap(
              value.data(),
            );
            userDetailsRef.value = userDetails.value;
            userDetails.refresh();
          })
        : null;

    return userDetails;
  }
}
