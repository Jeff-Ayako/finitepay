import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/views/on_board/biz_overview.dart';
// import 'package:finitepay/views/on_board/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboadingScreen extends StatelessWidget {
  const OnboadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    authenticationController.getuserdetails();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    "${maincontroller.gettime()} ${authenticationController.userDetails.value.fullname}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "Please complete the required sections to complete your FinitePay Account Creation",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "0% Done To Your First Transaction",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Obx(
                              () => Text(
                                authenticationController
                                    .userDetails.value.fullname
                                    .toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Btn(
                        txtColor: Colors.white,
                        ontap: () => Get.to(
                          () => BizOverviewPage(
                            size: 500,
                          ),
                        ),
                        // ontap: () => Get.to(
                        //   () => const OnboardingMainPage(),
                        // ),
                        btnName: 'Start Onboarding',
                        color: const Color(0xFF5A31F4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: width <= 800 ? 1 : 3,
                    childAspectRatio: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      buildCard(
                        "Business Overview",
                        Icons.business,
                        () {},
                      ),
                      buildCard(
                        "Directors",
                        Icons.group,
                        () {},
                      ),
                      buildCard(
                        "Shareholders",
                        Icons.people,
                        () {},
                      ),
                      buildCard(
                        "Political Persons",
                        Icons.account_balance,
                        () {},
                      ),
                      buildCard(
                        "Documents",
                        Icons.file_copy,
                        () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Card buildCard(String title, IconData icon, Function ontap) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: InkWell(
      onTap: ontap(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: const Color(0xFF5A31F4),
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    ),
  );
}
