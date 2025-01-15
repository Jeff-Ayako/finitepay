import 'package:finitepay/constants/listofcustomers.dart';
import 'package:finitepay/views/authenication/create_account_page.dart';
import 'package:finitepay/views/authenication/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class FinitePayHomePage extends StatelessWidget {
  const FinitePayHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 1.5,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Navbar Section with dropdowns
              _buildNavBar(context),
              const SizedBox(height: 50),

              // Hero Section (Main Banner)
              _buildHeroSection(context),
              const SizedBox(height: 50),

              // Features Section
              // _buildFeaturesSection(context),

              partnersOnBoard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget partnersOnBoard() {
    return SizedBox(
      height: Get.width <= 500 ? Get.height / 2 : Get.height,
      child: Column(
        children: [
          const Center(
            child: Text(
              'Our Customers',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color(0xFF5A31F4),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: Get.width <= 500
                  ? const NeverScrollableScrollPhysics()
                  : const ScrollPhysics(),
              itemCount: customers.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Get.width <= 500 ? 4 : 8),
              itemBuilder: (context, index) {
                return customers[index];
              },
            ),
          ),
        ],
      ),
    );
  }

  // Build Navbar
  Widget _buildNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Image.asset(
                'assets/finitepay2 brown.png',
                color: const Color(0xFF5A31F4),
                height: 40,
              ),
              // const Text(
              //   "FinitePay",
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //   ),
              // ),
              // Navbar Items
              if (constraints.maxWidth > 800)
                Row(
                  children: [
                    _navItemWithDropdown("Products", [
                      "Global Accounts",
                      "Borderless Cards",
                      "Multi-currency Wallet",
                      'Bill Pays',
                      'Payments Links & Plugins',
                      'Software intergrations',
                      'Payouts',
                      'Payins',
                      'Embedded Finance',
                      'Transactional Fx API',
                      'Issuing API',
                      'Global Treasury',
                    ]),
                    _navItemWithDropdown(
                        "Pricing", ["Plans", "Discounts", "Offers"]),
                    _navItemWithDropdown("Developers",
                        ["API Documentation", "SDKs", "Integration"]),
                    _navItemWithDropdown(
                        "Company", ["About Us", "Careers", "Press"]),
                  ],
                ),
              // Call-to-action buttons
              Row(
                children: [
                  if (constraints.maxWidth > 800)
                    TextButton(
                      onPressed: () => Get.to(() => const LoginPage()),
                      child: const Text(
                        'Log in',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => Get.to(
                      () => const CreateAccountPage(),
                    ),
                    style: ElevatedButton.styleFrom(
                      //  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: const Color(0xFF5A31F4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      // ),
                      // primary: Colors.purple,
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 24, vertical: 12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Get started',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  // Navbar Item with Dropdown
  Widget _navItemWithDropdown(String title, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PopupMenuButton<String>(
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        onSelected: (value) {
          Get.to(
            () => const CreateAccountPage(),
          );
          print(value);
        },
        itemBuilder: (context) => options.map((option) {
          return PopupMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
      ),
    );
  }

  // Build Hero Section
  Widget _buildHeroSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // return

          if (constraints.maxWidth <= 800) {
            // constraints.maxWidth <= 800
            //             ?
            return SizedBox(
              height: Get.height * .7,
              child: Column(
                children: [
                  Text(
                    "The financial platform for your global ambition",
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 800 ? 40 : 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "we leverage our industry expertise to offer tailored payment solutions that meet the unique needs of each Merchant.",
                    style: TextStyle(
                        fontSize: constraints.maxWidth > 800 ? 18 : 16,
                        color: Colors.black54),
                  ),
                  const SizedBox(height: 30),
                  // Expanded(
                  //   // width: Get.width,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // _onPressed();
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(vertical: 16.0),
                  //       backgroundColor: const Color(0xFF5A31F4),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //     ),
                  //     child: const Text(
                  //       'Get Started',
                  //       style: TextStyle(fontSize: 16.0, color: Colors.white),
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(width: 20),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: const Text(
                  //     'Contact sales',
                  //     style: TextStyle(fontSize: 16, color: Colors.black),
                  //   ),
                  // ),
                  Row(
                    children: [
                      Expanded(
                        // width: Get.width,
                        child: ElevatedButton(
                          onPressed: () => Get.to(
                            () => const CreateAccountPage(),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            backgroundColor: const Color(0xFF5A31F4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Contact sales',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //     width: constraints.maxWidth > 800 ? 50 : 0,
                  //     height: constraints.maxWidth > 800 ? 0 : 20),
                  // Image Placeholder (Use Network Image or asset)
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/dash.png',
                    // fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/mobile.png',
                    // fit: BoxFit.cover,
                  ),
                ],
              ),
            );
          } else {
            return Flex(
              direction:
                  constraints.maxWidth > 800 ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text Column
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "The financial platform for your global ambition",
                        style: TextStyle(
                          fontSize: constraints.maxWidth > 800 ? 40 : 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "we leverage our industry expertise to offer tailored payment solutions that meet the unique needs of each Merchant.",
                        style: TextStyle(
                            fontSize: constraints.maxWidth > 800 ? 18 : 16,
                            color: Colors.black54),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            // width: Get.width,
                            child: ElevatedButton(
                              onPressed: () {
                                // _onPressed();
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                backgroundColor: const Color(0xFF5A31F4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Contact sales',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    width: constraints.maxWidth > 800 ? 50 : 0,
                    height: constraints.maxWidth > 800 ? 0 : 20),
                // Image Placeholder (Use Network Image or asset)
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/dash.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // Build Features Section
  Widget _buildFeaturesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Why FinitePay?",
                style: TextStyle(
                  fontSize: constraints.maxWidth > 800 ? 32 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              Flex(
                direction: constraints.maxWidth > 800
                    ? Axis.horizontal
                    : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFeatureCard("Fast & Secure Payments",
                      "Make international payments with lower fees and faster processing times."),
                  _buildFeatureCard("Financial Operations",
                      "Manage your financial operations with ease and flexibility."),
                  _buildFeatureCard("Borderless Cards",
                      "Issue virtual cards to streamline expenses for your team."),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  // Feature Card Widget
  Widget _buildFeatureCard(String title, String description) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
