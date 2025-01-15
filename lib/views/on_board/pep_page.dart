import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/views/authenication/create_account_page.dart';
import 'package:finitepay/views/on_board/upload_doc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PEPDeclarationPage extends StatelessWidget {
  const PEPDeclarationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PEP Declaration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Form(
              key: kycController.pepStatusGlobal.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Politically Exposed Persons or VIPs Declaration (Optional)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                      'Confirm if you or your business has a financially or politically exposed person'),
                  const SizedBox(height: 16),

                  // Row: Name, Position, PEP Status Description
                  Row(
                    children: [
                      Expanded(
                          child: txtForm(
                        'Full Name',
                        maincontroller.fullNameController,
                        (value) => (value!.trim().isEmpty)
                            ? "Full Name required"
                            : (value.trim().length < 2)
                                ? "Enter a valid Full Name"
                                : null,
                      ) //_buildTextField(label: 'Name'),
                          ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: txtForm(
                        'Position',
                        kycController.positionController.value,
                        (value) => (value!.trim().isEmpty)
                            ? "Position required"
                            : (value.trim().length < 2)
                                ? "Enter a valid Position"
                                : null,
                      ) //_buildTextField(label: 'Position'),
                          ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: txtForm(
                        'PEP Status Description',
                        kycController.pepstatus.value,
                        (value) => (value!.trim().isEmpty)
                            ? "PEP Status Description required"
                            : (value.trim().length < 2)
                                ? "Enter a valid PEP Status Description"
                                : null,
                      ) //_buildTextField(label: 'PEP Status Description'),
                          ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Btn(
                    txtColor: Colors.black,
                    ontap: () {
                      if (kycController.pepStatusGlobal.value.currentState!
                          .validate()) {
                        maincontroller.showLoading('Please wait');
                        final Map<String, dynamic> newItem = {
                          'FullName':
                              kycController.fullnameController.value.text,
                          'Position':
                              kycController.positionController.value.text,
                          'Pepstatus': kycController.pepstatus.value.text,
                        };
                        FirebaseFirestore.instance
                            .collection('KycData')
                            .doc(fAuth.currentUser?.uid ?? '')
                            .update({
                          "Peppersons": FieldValue.arrayUnion([newItem])
                        }).then((value) {
                          Get.snackbar(
                              backgroundColor: Colors.green,
                              'Success',
                              '${kycController.firstName.value.text} was added successfully');

                          kycController.pepposition.value.clear();
                          kycController.pepname.value.clear();
                          kycController.pepstatus.value.clear();
                          kycController.fullnameController.value.clear();
                        }).catchError((e) {
                          Get.snackbar(backgroundColor: Colors.red, 'Error', e);
                        });
                      }
                    },
                    btnName: "Save and Add Another PEP",
                    color: Colors.transparent,
                  ),
                  Btn(
                    txtColor: Colors.white,
                    ontap: () {
                      Get.to(
                        () => const UploadDocsPage(),
                      );
                    },
                    btnName: "I'm Done Adding PEP",
                    color: const Color(0xFF5A31F4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
