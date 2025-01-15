import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/views/authenication/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    authenticationController.getuserdetails();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        // backgroundColor: Colors.purple[50],
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Learn More',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Get.width <= 500
              ? Container()
              : Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    child: ListView(
                      children: [
                        ListTile(
                          title: const Text('My Profile'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('API Keys & Webhooks'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('IP Whitelisting'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('Notifications'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('Password & Security'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('Pay-Ins'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('Settlement'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[100],
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.purple[100],
                                child: const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.purple,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => 
                                    Text(
                                      authenticationController
                                          .userDetails.value.fullname
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      authenticationController
                                          .userDetails.value.businessName
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => InfoRow(
                                label: 'First Name',
                                value: authenticationController
                                    .userDetails.value.fullname
                                    .toString()),
                          ),
                          Obx(
                            () => InfoRow(
                                label: 'Business Name',
                                value: authenticationController
                                    .userDetails.value.businessName
                                    .toString()),
                          ),
                          Obx(
                            () => InfoRow(
                                label: 'Email Address',
                                value: authenticationController
                                    .userDetails.value.email
                                    .toString()),
                          ),
                          Obx(
                            () => InfoRow(
                                label: 'Phone Number',
                                value: authenticationController
                                    .userDetails.value.phone
                                    .toString()),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Business Information',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const InfoRow(
                              label: 'Business ID',
                              value: '66c0b6a4c984c93992cc0246'),
                          Obx(
                            () => InfoRow(
                              label: 'Business Name',
                              value: authenticationController
                                  .userDetails.value.businessName
                                  .toString(),
                            ),
                          ),
                          const Divider(),
                          Btn(
                            txtColor: Colors.white,
                            ontap: () async {
                              try {
                                await FirebaseAuth.instance.signOut();
                                print('User successfully signed out');
                              } catch (e) {
                                print('Error signing out: $e');
                              }
                              Get.to(
                                () => const LoginPage(),
                              );
                            },
                            btnName: 'Log Out',
                            color: Colors.red,
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
