import 'package:finitepay/components/finitepay_icons.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_data.dart';
import 'package:finitepay/main.dart';
import 'package:finitepay/views/authenication/login_page.dart';
import 'package:finitepay/views/documentations/api_docs.dart';
import 'package:finitepay/views/home/mobile_selector.dart';
import 'package:finitepay/views/notifications/notifications_page.dart';
import 'package:finitepay/views/profile/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hidable/hidable.dart';
import 'package:simple_icons/simple_icons.dart';

// import 'package:flutter_side_menu/flutter_side_menu.dart';
// import 'package:badges/badges.dart' as badges;

class DashBoardHomePage extends StatelessWidget {
  const DashBoardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 500) {
          return DashPage(
            pagesize: 500,
          );
        } else {
          return DashPage(
            pagesize: 1000,
          );
        }
      },
    );
  }
}

// ignore: must_be_immutable
class DashPage extends StatelessWidget {
  DashPage({super.key, required this.pagesize});
  double pagesize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: Hive.box(darkModeBox).listenable(),
            builder: (BuildContext context, Box<dynamic> value, Widget? child) {
              var darkMode = value.get('darkMode', defaultValue: false);
              return Scaffold(
                appBar: pagesize == 500
                    ? AppBar(
                        title: InkWell(
                          onTap: () {
                            // print('Hello');
                            cardsController.encryptPin('1234');
                          },
                          child: const Text(
                            'Finitepay',
                            style: TextStyle(
                              color: Color(0xFF5A31F4),
                            ),
                          ),
                        ),
                        centerTitle: true,
                        actions: [
                          // Switch(
                          //   value: darkMode,
                          //   onChanged: (val) async {
                          //     value.put('darkMode', !darkMode);
                          //     await value.get('darkMode');
                          //   },
                          //   activeColor: const Color(0xFF5A31F4),
                          // ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                () => const AccountSettingsScreen(),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              child: Obx(
                                () => Text(
                                  authenticationController
                                      .userDetails.value.fullname
                                      .toString()[0]
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ), // Placeholder for user avatar or initials
                            ),
                          ),
                          IconButton(
                            onPressed: () => Get.to(
                              () => const MobileSelector(),
                            ),
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.black,
                            ),
                          )
                          // const NotificationsBtn(),
                        ],
                      )
                    : AppBar(
                        backgroundColor:
                            Theme.of(context).appBarTheme.backgroundColor,
                        elevation: 1,
                        title: InkWell(
                          onTap: () {
                            cardsController.getIfcardWasIssued();
                          },
                          child: Image.asset(
                            'assets/finitepay2.png',
                            color: Color(0xFF5A31F4),
                            width: 200,
                          ),
                        ),
                        // const Text(
                        //   'FinitePay',
                        //   style: TextStyle(
                        //       color: Color(0xFF5A31F4),
                        //       fontSize: 24,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        centerTitle: false,
                        actions: [
                          // Btn(
                          //   txtColor: Colors.white,
                          //   ontap: () {},
                          //   btnName: 'TestMode',
                          //   color: Colors.red,
                          // ),
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.red,
                          //   ),
                          //   onPressed: () {},
                          //   child: const Text(
                          //     "TestMode",
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),

                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                const Icon(Icons.help_outline),
                                Text(
                                  'Integration Support',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.to(
                              () => const GettingStartedScreen(),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.code),
                                Text(
                                  'API Documentation',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // THEME MODE COMMENTTED OUT TILL WE HAVE APPROPRIATE THEMES STYLES
                          // Switch(
                          //   value: darkMode,
                          //   onChanged: (val) async {
                          //     value.put('darkMode', !darkMode);
                          //     await value.get('darkMode');
                          //   },
                          //   activeColor: const Color(0xFF5A31F4),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () => Get.to(
                                      () => const NotificationsPage(),
                                    ),
                                child: const Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.black,
                                ) //const NotificationsBtn(),
                                ),
                          ),
                          // IconButton(
                          //   icon: Icon(Icons.notifications,
                          //       color: Colors.grey[800]),
                          //   onPressed: () => Get.to(
                          //     () => const NotificationsPage(),
                          //   ),
                          // ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                () => const AccountSettingsScreen(),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              child: Obx(
                                () => Text(
                                  authenticationController
                                      .userDetails.value.fullname
                                      .toString()[0]
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ), // Placeholder for user avatar or initials
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
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
                            icon: const Icon(
                              Icons.logout_outlined,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                body: Stack(
                  children: [
                    // Custom background painter
                    Positioned.fill(
                      child: CustomPaint(
                        painter: BackgroundPainter(),
                      ),
                    ),

                    // Obx(
                    //   () =>

                    Row(
                      children: [
                        // Sidebar
                        pagesize == 500
                            ? Container()
                            : Container(
                                width: 220,
                                // color: const Color(0xff534eff),
                                color: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                                child: Obx(
                                  () => ListView.builder(
                                    // ignore: invalid_use_of_protected_member
                                    itemCount:
                                        // ignore: invalid_use_of_protected_member
                                        maincontroller.dashIcons.value.length,
                                    itemBuilder: (context, index) {
                                      return

                                          // Obx(
                                          //   () =>
                                          Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Obx(
                                          () => Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: maincontroller
                                                              .currentTabIndex
                                                              .value ==
                                                          index
                                                      ? Colors.deepPurple
                                                      : Colors.transparent,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: maincontroller
                                                            .currentTabIndex
                                                            .value ==
                                                        index
                                                    ? Colors.blue[50]
                                                    : Colors.transparent,
                                              ),
                                              child:
                                                  // ignore: invalid_use_of_protected_member
                                                  maincontroller
                                                      // ignore: invalid_use_of_protected_member
                                                      .dashIcons
                                                      .value[index]),
                                        ),
                                        // ),
                                      );
                                    },
                                  ),
                                ),
                                // child: ListView(
                                //   padding: const EdgeInsets.all(16),
                                //   children: [
                                //     .
                                //   ],
                                // ),
                              ),

                        // const VerticalDivider(),
                        // Main Content

                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth <= 800) {
                                // ignore: invalid_use_of_protected_member
                                return Obx(
                                  // ignore: invalid_use_of_protected_member
                                  () => maincontroller.mobileScreensList.value[
                                      maincontroller.currentTabIndex.value],
                                );
                              } else {
                                // ignore: invalid_use_of_protected_member
                                return Obx(
                                  // ignore: invalid_use_of_protected_member
                                  () => maincontroller.pagesList.value[
                                      maincontroller.currentTabIndex.value],
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    // ),
                  ],
                ),

                bottomNavigationBar: MediaQuery.of(context).size.width > 800
                    ? null
                    : Hidable(
                        controller: scrollController,
                        enableOpacityAnimation: true,
                        child: Obx(
                          () => BottomNavigationBar(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            items: <BottomNavigationBarItem>[
                              BottomNavigationBarItem(
                                  icon: kIsWeb && GetPlatform.isIOS
                                      ? const Icon(Icons.home_outlined)
                                      : const Icon(FinitepayIcons.home),
                                  label: 'Home'),
                              const BottomNavigationBarItem(
                                  icon: Icon(Icons.credit_card),
                                  label: 'Cards'),
                              const BottomNavigationBarItem(
                                  icon: Icon(
                                      Icons.account_balance_wallet_outlined),
                                  label: 'Balances'),
                              const BottomNavigationBarItem(
                                  icon: Icon(Icons.monetization_on_outlined),
                                  label: 'Transcations'),
                              BottomNavigationBarItem(
                                  icon: kIsWeb && GetPlatform.isIOS
                                      ? const Icon(Icons.swap_horiz_outlined)
                                      : const Icon(
                                          SimpleIcons.moneygram,
                                        ),
                                  label:
                                      // fAuth.currentUser != null
                                      //     ? 'You'
                                      // :
                                      'Conversions'),
                            ],
                            currentIndex: maincontroller.currentTabIndex.value,
                            unselectedItemColor:
                                Theme.of(context).iconTheme.color,
                            selectedItemColor: const Color(0xFF5A31F4),
                            showUnselectedLabels: true,
                            selectedLabelStyle: const TextStyle(fontSize: 12),
                            type: BottomNavigationBarType.fixed,
                            onTap: maincontroller.onItemClicked,
                          ),
                        ),
                      ),

                // ),
              );
            }),
      ),
    );
  }
}

const _navItems = [
  NavItemModel(name: 'Item 1', icon: Icons.home),
  NavItemModel(name: 'Item 2', icon: Icons.settings),
  NavItemModel(name: 'Item 3', icon: Icons.info),
];
const _accountItems = [
  NavItemModel(name: 'Item 4', icon: Icons.access_alarms_sharp),
  NavItemModel(name: 'Item 5', icon: Icons.accessibility_new_sharp),
  NavItemModel(name: 'Item 6', icon: Icons.ac_unit_sharp),
];

extension on Widget {
  Widget? showOrNull(bool isShow) => isShow ? this : null;
}

class NavItemModel {
  const NavItemModel({
    required this.name,
    required this.icon,
  });

  final String name;
  final IconData icon;
}
