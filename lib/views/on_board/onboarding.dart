import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/views/authenication/login_page.dart';
import 'package:finitepay/views/on_board/biz_overview.dart';
import 'package:finitepay/views/on_board/directors_page.dart';
// import 'package:finitepay/views/on_board/finitepay_use.dart';
import 'package:finitepay/views/on_board/pep_page.dart';
import 'package:finitepay/views/on_board/share_holderspage.dart';
import 'package:finitepay/views/on_board/socials_details.dart';
import 'package:finitepay/views/on_board/upload_doc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingMainPage extends StatelessWidget {
  const OnboardingMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return

        //  MaterialApp(
        //   home:

        Scaffold(
            // backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: const Text('Business Onboarding'),
              // backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth <= 500) {
                  return OnboardLayout(
                    size: 500,
                  );
                } else {
                  return OnboardLayout(
                    size: 1000,
                  );
                }
              },
            )

            // ),
            );
  }
}

// ignore: must_be_immutable
class OnboardLayout extends StatelessWidget {
  OnboardLayout({super.key, required this.size});

  double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Custom background painter
        Positioned.fill(
          child: CustomPaint(
            painter: BackgroundPainter(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Side (Business Overview)
              size == 500
                  ? Container()
                  : Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Business Overview',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              const ListTile(
                                title: Text('Know Your Business'),
                              ),
                              const ListTile(
                                title: Text('Use of FinitePay'),
                              ),
                              const ListTile(
                                title: Text('Additional Information'),
                              ),
                              const ListTile(
                                title: Text('Directors'),
                              ),
                              const ListTile(
                                title: Text('Shareholders'),
                              ),
                              const ListTile(
                                title: Text('PEPs (Optional)'),
                              ),
                              const ListTile(
                                title: Text('Documents'),
                              ),
                              const Spacer(),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Handle FAQ support action
                                },
                                icon: const Icon(
                                  Icons.headset_mic,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Get Support/FAQS',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5A31F4),
                                  // primary: Colors.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(width: 16),
              // Right Side (Let's Know Your Business)
              Expanded(
                flex: 5,
                child: Obx(
                  () => Form(
                    key: kycController.formcontrollers.value,
                    child: ListView(
                      children: [
                       BizOverviewPage(size: size,),
                       
                        SizedBox(
                          height: Get.height / 2,
                          child: const SocialsDetailsPage(),
                        ),
                        SizedBox(
                          height: Get.height,
                          child: const Card(
                            child: DirectorsPage(),
                          ),
                        ),
                        SizedBox(
                          height: Get.height,
                          child: const Card(
                            child: ShareholdersPage(),
                          ),
                        ),
                        SizedBox(
                          height: Get.height,
                          child: const Card(
                            child: PEPDeclarationPage(),
                          ),
                        ),
                        SizedBox(
                          height: Get.height,
                          child: const Card(
                            child: UploadDocsPage(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
