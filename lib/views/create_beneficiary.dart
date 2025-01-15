import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:finitepay/components/progressdialog.dart';
import 'package:finitepay/main.dart';
import 'package:finitepay/views/authenication/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/services.dart';
// import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CreateBeneficiary extends StatefulWidget {
  const CreateBeneficiary({super.key});

  @override
  State<CreateBeneficiary> createState() => _CreateBeneficiaryState();
}

class _CreateBeneficiaryState extends State<CreateBeneficiary> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  bool agree = false;
  String image64base = "";

  TextEditingController emailController = TextEditingController();

  TextEditingController businessName = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  BuildContext? loadingDialogContext;
  final auth = FirebaseAuth.instance;

  bool obsecure = true;
  bool obsecure2 = true;
  bool match = true;
  bool obscure1 = true;
  bool obscure2 = true;
  bool isZero = false;
  bool isZero1 = false;
  bool isZerod = false;
  bool isZerom = false;

  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var box = Hive.box(darkModeBox);

  getThumbnail() async {
    ByteData bytes = await rootBundle.load("assets/finitepay.png");
    setState(() {
      image64base = base64Encode(bytes.buffer.asUint8List());
    });
  }

  @override
  void initState() {
    getThumbnail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Custom background painter
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
          // Centered login form
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 90.0),
                      child: Container(
                        width: 400,
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/finitelw.png',
                                color: const Color(0xFF5A31F4),
                                height: 100,
                              ),
                            ),
                            const Center(
                              child: Text(
                                'FinitePay',
                                style: TextStyle(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5A31F4),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            const Text(
                              'Beneficiary',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            // TextFormField(
                            //   decoration: InputDecoration(
                            //     labelText: 'Email Address',
                            //     labelStyle: const TextStyle(color: Colors.black54),
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(8.0),
                            //       borderSide: const BorderSide(
                            //         color: Color(0xFF5A31F4),
                            //       ),
                            //     ),
                            //     focusedBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(8.0),
                            //       borderSide: const BorderSide(
                            //         color: Color(0xFF5A31F4),
                            //       ),
                            //     ),
                            //   ),
                            //   // initialValue: 'jeffayako1@gmail.com',
                            // ),
                            // const SizedBox(height: 16.0),
                            txtForm(
                              'Full Name',
                              fullNameController,
                              (value) => (value!.trim().isEmpty)
                                  ? "Full Name is required"
                                  : (value.trim().length < 2)
                                      ? "Enter a valid Full Name"
                                      : null,
                            ),
                            txtForm(
                              'Phone Number',
                              phoneNoController,
                              (value) => (value!.trim().isEmpty)
                                  ? "Phone Number is required"
                                  : (value.trim().length < 9)
                                      ? "Enter a valid phone number"
                                      : null,
                            ),
                            txtForm(
                              'Business Name',
                              businessName,
                              (value) => (value!.trim().isEmpty)
                                  ? "Full Name is required"
                                  : (value.trim().length < 2)
                                      ? "Enter a valid Full Name"
                                      : null,
                            ),
                            txtForm(
                              'Enter Your Email',
                              emailController,
                              (email) => email != null &&
                                      !EmailValidator.validate(email.trim())
                                  ? 'Enter a Valid email'
                                  : null,
                            ),

                            // const SizedBox(height: 16.0),
                            // CSCPicker(
                            //   dropdownDecoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       color: Theme.of(context).cardColor),
                            //   selectedItemStyle:
                            //       const TextStyle(color: Colors.black),
                            //   dropdownHeadingStyle:
                            //       const TextStyle(color: Colors.black),
                            //   dropdownItemStyle:
                            //       const TextStyle(color: Colors.black),
                            //   flagState: CountryFlag.DISABLE,
                            //   onCountryChanged: (value) {
                            //     signUpController.countryValue.value = value;
                            //   },
                            //   onStateChanged: (value) {
                            //     signUpController.stateValue.value =
                            //         value.toString();
                            //   },
                            //   onCityChanged: (value) {
                            //     signUpController.cityValue.value =
                            //         value.toString();
                            //     print(signUpController.cityValue.value);
                            //   },
                            // ),

                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              validator: (value) => value!.trim().isNotEmpty &&
                                      value.trim().length > 7
                                  ? null
                                  : "Password must be at least 8 characters",
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF5A31F4),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF5A31F4),
                                  ),
                                ),
                                suffixIcon: const Icon(
                                  Icons.visibility,
                                  color: Color(0xFF5A31F4),
                                ),
                              ),
                              // initialValue: 'hhhhhhhhhhhhhhhhh',
                            ),
                            const SizedBox(height: 16.0),

                            TextFormField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              validator: (value) => value!.trim().isNotEmpty &&
                                      value.trim().length > 7
                                  ? null
                                  : "Password must be at least 8 characters",
                              onFieldSubmitted: (value) {
                                _onPressed();
                              },
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF5A31F4),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF5A31F4),
                                  ),
                                ),
                                suffixIcon: const Icon(
                                  Icons.visibility,
                                  color: Color(0xFF5A31F4),
                                ),
                              ),
                              // initialValue: 'hhhhhhhhhhhhhhhhh',
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Checkbox(
                            //           value: true,
                            //           onChanged: (value) {},
                            //           activeColor: const Color(0xFF5A31F4),
                            //         ),
                            //         const Text('Keep me signed in'),
                            //       ],
                            //     ),
                            //     TextButton(
                            //       onPressed: () {},
                            //       child: const Text(
                            //         'Forgot login details?',
                            //         style: TextStyle(color: Color(0xFF5A31F4)),
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            const SizedBox(height: 24.0),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  _onPressed();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  backgroundColor: const Color(0xFF5A31F4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  'Create My Account',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            ),
                            // Center(
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: TextButton(
                            //       onPressed: () {
                            //         Get.to(
                            //           () => const LoginPage(),
                            //         );
                            //       },
                            //       child: const Text(
                            //         ' Have an Account? Login',
                            //         style: TextStyle(color: Color(0xFF5A31F4)),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // const Divider(),
                            // const Text(
                            //     '''By clicking the “Create your account” button, you agree to FinitePay’s terms of acceptable use and Data Processing Agreement.'''),

                            // const Divider(),
                            // const Text(
                            //     '''To learn more about how Paystack collects, uses and discloses your personal data, please read our Privacy Policy.''')
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Need Support?',
                        style: TextStyle(
                            // color: Colors.black54,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/fwhitelogo.png',
                color: const Color(0xFF5A31F4),
                height: 100,
              ),
            ),
          )
        ],
      ),
    );
  }

  _onPressed() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text.trim() ==
          confirmPasswordController.text.trim()) {
        // registerUser();
      } else {
        setState(() {
          match = false;
        });
        showUpDismissible(context, "Passwords Do Not Match!!", "");
      }
    }
  }
}

Widget txtForm(
    String formLable, TextEditingController controller, validatiorFunc) {
  return Column(
    children: [
      TextFormField(
        controller: controller,
        validator: validatiorFunc,
        decoration: InputDecoration(
          labelText: formLable,
          labelStyle: const TextStyle(color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color(0xFF5A31F4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color(0xFF5A31F4),
            ),
          ),
        ),
        // initialValue: 'jeffayako1@gmail.com',
      ),
      const SizedBox(height: 16.0),
    ],
  );
}

@override
bool shouldRepaint(CustomPainter oldDelegate) {
  return false;
}
