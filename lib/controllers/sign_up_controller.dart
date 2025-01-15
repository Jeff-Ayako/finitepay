import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class SignUpController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final obscure = true.obs;
  final countryValue = 'Kenya'.obs;
  final stateValue = 'Nairobi'.obs;
  final cityValue = 'Nairobi'.obs;
  final fullnameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;
  final repeatPasswordController = TextEditingController().obs;
  late AnimationController anicontroller;

  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  @override
  void onInit() {
    anicontroller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    super.onInit();
  }

  @override
  void onClose() {
    anicontroller.dispose();
    super.onClose();
  }
}
