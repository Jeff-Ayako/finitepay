import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/views/on_board/directors_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter/widgets.dart';

class SocialsDetailsPage extends StatelessWidget {
  const SocialsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth <= 500) {
                return socialsWidget(size: 500);
              } else {
                return socialsWidget(size: 1000);
              }
            },
          )),
      // ),
    );
  }

  Widget socialsWidget({required double size}) {
    return Form(
      key: kycController.socialsControllerKey.value,
      child: size <= 500
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Additional Information',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(Optional)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const Divider(thickness: 1, height: 32),
                  _buildStyledTextField(
                      validator: (value) => (value!.trim().isEmpty &&
                              value.contains('https') == false)
                          ? "Company LinkedIn"
                          : (value.trim().length < 5)
                              ? "Enter a valid LinkedIn"
                              : null,
                      labelText: 'LinkedIn',
                      hintText: 'https://www.abc.com',
                      controller: kycController.linkedinController.value),
                  _buildStyledTextField(
                      validator: (value) => (value!.trim().isEmpty &&
                              value.contains('https') == false)
                          ? "Facebook Account required"
                          : (value.trim().length < 5)
                              ? "Enter a valid Facebook Account"
                              : null,
                      labelText: 'Facebook',
                      hintText: 'https://www.abc.com',
                      controller: kycController.facebookcontroller.value),
                  _buildStyledTextField(
                    labelText: 'Instagram',
                    hintText: 'https://www.abc.com',
                    controller: kycController.instagramcontroller.value,
                    validator: (value) => (value!.trim().isEmpty &&
                            value.contains('https') == false)
                        ? "Instagram Account required"
                        : (value.trim().length < 5)
                            ? "Enter a valid Instagram Account"
                            : null,
                  ),
                  _buildStyledTextField(
                      validator: (value) => (value!.trim().isEmpty &&
                              value.contains('https') == false)
                          ? " X Account required"
                          : (value.trim().length < 5)
                              ? "Enter a valid X Account"
                              : null,
                      labelText: 'X',
                      hintText: 'https://www.abc.com',
                      controller: kycController.xcontroller.value),
                  Btn(
                    txtColor: Colors.white,
                    ontap: () {
                      if (kycController
                              .instagramcontroller.value.text.isNotEmpty ||
                          kycController.xcontroller.value.text.isNotEmpty ||
                          kycController
                              .facebookcontroller.value.text.isNotEmpty ||
                          kycController
                              .linkedinController.value.text.isNotEmpty) {
                        FirebaseFirestore.instance
                            .collection('KycData')
                            .doc(fAuth.currentUser?.uid ?? '')
                            .update({
                          "InstagramLink":
                              kycController.instagramcontroller.value.text ??
                                  '',
                          "Xlink": kycController.xcontroller.value.text ?? '',
                          "FacebookLink":
                              kycController.facebookcontroller.value.text ?? '',
                          "LinkedinLink":
                              kycController.linkedinController.value.text ?? '',
                        });
                      }
                      Get.to(
                        () => const DirectorsPage(),
                      );
                    },
                    btnName: 'Next',
                    color: const Color(0xFF5A31F4),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Additional Information',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(Optional)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 1, height: 32),
                Row(
                  children: [
                    Expanded(
                      child: _buildStyledTextField(
                          validator: (value) => (value!.trim().isEmpty &&
                                  value.contains('https') == false)
                              ? "Company LinkedIn"
                              : (value.trim().length < 5)
                                  ? "Enter a valid LinkedIn"
                                  : null,
                          labelText: 'LinkedIn',
                          hintText: 'https://www.abc.com',
                          controller: kycController.linkedinController.value),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStyledTextField(
                          validator: (value) => (value!.trim().isEmpty &&
                                  value.contains('https') == false)
                              ? "Facebook Account required"
                              : (value.trim().length < 5)
                                  ? "Enter a valid Facebook Account"
                                  : null,
                          labelText: 'Facebook',
                          hintText: 'https://www.abc.com',
                          controller: kycController.facebookcontroller.value),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStyledTextField(
                          validator: (value) => (value!.trim().isEmpty &&
                                  value.contains('https') == false)
                              ? " X Account required"
                              : (value.trim().length < 5)
                                  ? "Enter a valid X Account"
                                  : null,
                          labelText: 'X',
                          hintText: 'https://www.abc.com',
                          controller: kycController.xcontroller.value),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStyledTextField(
                        labelText: 'Instagram',
                        hintText: 'https://www.abc.com',
                        controller: kycController.instagramcontroller.value,
                        validator: (value) => (value!.trim().isEmpty &&
                                value.contains('https') == false)
                            ? "Instagram Account required"
                            : (value.trim().length < 5)
                                ? "Enter a valid Instagram Account"
                                : null,
                      ),
                    ),
                  ],
                ),
                Btn(
                  txtColor: Colors.white,
                  ontap: () {
                    if (kycController
                            .instagramcontroller.value.text.isNotEmpty ||
                        kycController.xcontroller.value.text.isNotEmpty ||
                        kycController
                            .facebookcontroller.value.text.isNotEmpty ||
                        kycController
                            .linkedinController.value.text.isNotEmpty) {
                               maincontroller.showLoading('Please wait');
                      FirebaseFirestore.instance
                          .collection('KycData')
                          .doc(fAuth.currentUser?.uid ?? '')
                          .update({
                        "InstagramLink":
                            kycController.instagramcontroller.value.text ?? '',
                        "Xlink": kycController.xcontroller.value.text ?? '',
                        "FacebookLink":
                            kycController.facebookcontroller.value.text ?? '',
                        "LinkedinLink":
                            kycController.linkedinController.value.text ?? '',
                      });
                    }
                    Get.to(
                      () => const DirectorsPage(),
                    );
                  },
                  btnName: 'Next',
                  color: const Color(0xFF5A31F4),
                ),
              ],
            ),
    );
  }

  Widget _buildStyledTextField(
      {required String labelText,
      required String hintText,
      required TextEditingController controller,
      required validator}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            // borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        ),
      ),
    );
  }
}
