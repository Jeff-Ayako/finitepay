// import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/views/authenication/login_page.dart';
import 'package:finitepay/views/home/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadDocsPage extends StatelessWidget {
  const UploadDocsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // MaterialApp(
        //   home:
        Scaffold(
            appBar: AppBar(
              title: const Text('Document Upload'),
              centerTitle: true,
            ),
            body: Scaffold(
                body: Stack(
              children: [
                // Custom background painter
                Positioned.fill(
                  child: CustomPaint(
                    painter: BackgroundPainter(),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double width = MediaQuery.of(context).size.width;
                    if (constraints.maxWidth <= 500) {
                      return const UploadWidget();
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 3.5),
                        child: const UploadWidget(),
                      );
                    }
                  },
                ),
              ],
            ))

            // ),
            );
  }
}

class UploadWidget extends StatelessWidget {
  const UploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: LinearProgressIndicator(
                    minHeight: 10,
                    backgroundColor: const Color(0xFF5A31F4),
                    value: maincontroller.uploadProgress.value,
                  ),
                ),
              ),
              const Text(
                'Additional documentation needed to speed up your KYC process.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              DocumentUploadField(
                title: 'Business Registration/Incorporation Certificate',
                isRequired: true,
                progress: maincontroller.incoyporationcertProgress,
              ),
              const SizedBox(height: 20),
              DocumentUploadField(
                title: 'Article of Association',
                isRequired: true,
                progress: maincontroller.associationArt,
              ),
              const SizedBox(height: 20),
              DocumentUploadField(
                title: 'Operating Business Utility Bill',
                isRequired: true,
                progress: maincontroller.utibill,
              ),
              const SizedBox(height: 30),
              const Text(
                'File should be in .png, .jpg, or .pdf format\nMax file size is 50mb',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Center(
                child: Btn(
                  txtColor: Colors.white,
                  ontap: () {
                    if (maincontroller.incoyporationcertProgress.value < 100) {
                      Get.snackbar(
                          backgroundColor: Colors.red,
                          'Incorportion Certificate Required',
                          'Tap to upload Incorportion Certificate');
                    } else if (maincontroller.associationArt.value < 100) {
                      Get.snackbar(
                          backgroundColor: Colors.red,
                          'Association Art Required',
                          'Tap to upload Association Art ');
                    } else if (maincontroller.utibill.value < 100) {
                      Get.snackbar(
                          backgroundColor: Colors.red,
                          'Utility Bill Required',
                          'Tap to upload Utility Bill ');
                    } else {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(fAuth.currentUser?.email ?? '')
                          .collection('information')
                          .doc(fAuth.currentUser?.uid ?? '')
                          .update({'onboardingDone': true});
                      Get.offAll(
                        () => const DashBoardHomePage(),
                      );
                    }
                  },
                  btnName: "Tap to Finish KYC Process",
                  color: const Color(0xFF5A31F4),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentUploadField extends StatelessWidget {
  final String title;
  final bool isRequired;
  final RxDouble progress;

  const DocumentUploadField(
      {super.key,
      required this.title,
      this.isRequired = false,
      required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title + (isRequired ? ' (Required)' : ''),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            maincontroller.pickAndUploadPdf(title, progress);
            // Logic for file upload here
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF5A31F4),
              border: Border.all(
                color: const Color(0xFF5A31F4),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Choose File To Upload',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Obx(
          () => LinearProgressIndicator(
            minHeight: 10,
            color: const Color(0xFF5A31F4),
            value: progress.value,
          ),
        )
      ],
    );
  }
}
