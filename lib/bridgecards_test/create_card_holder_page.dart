import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_functions/cloud_functions.dart';
// import 'package:finitepay/bridgecards_test/card_payment.dart';
import 'package:finitepay/bridgecards_test/no_card_available_page.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/components/txt_input.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class CreateCardHolderPage extends StatelessWidget {
  CreateCardHolderPage({super.key, required this.country});

  String country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (maincontroller.shouldCreateCard.value == false &&
            cardsController.wasPaymentMade.value == false &&
            cardsController.wasCardIssued.value == false) {
          return const NoCardAvailablePage();
        } else if (cardsController.wasPaymentMade.value == true &&
            cardsController.wasCardIssued.value == false) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Lottie.asset(
                    'assets/success.json',
                  ),
                ),
                Text(
                    'Your Payment was successful Please Complete Your Card Creation'),
                Btn(
                  txtColor: Colors.white,
                  ontap: () {
                    cardsController.firstName.text = authenticationController
                        .userDetails.value.firstName
                        .toString();
                    cardsController.lastName.text = authenticationController
                        .userDetails.value.lastName
                        .toString();
                    cardsController.nationalIDNumber.text =
                        authenticationController.userDetails.value.nationalID
                            .toString();
                    cardsController.phone.text = authenticationController
                        .userDetails.value.phone
                        .toString();
                    maincontroller.shouldCreateCard.value = true;

                    Get.to(
                      CreateCardHolderPage(
                        country: 'Kenya',
                      ),
                    );

                    //cardsController.registerKenyaCardHolder();
                  },
                  btnName: 'Tap To Complete',
                  color: const Color.fromARGB(255, 13, 124, 17),
                )
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Create Your Card",
                style: TextStyle(
                    // color: Colors.white,
                    ),
              ),
              // backgroundColor: Colors.deepPurple,
              elevation: 0,
              // actions: [
              //   IconButton(
              //     onPressed: () {
              //       cardsController.createUSDCard(
              //           maincontroller.cardholderDB!.data()['cardholder_id'], '1234');
              //     },
              //     icon: const Icon(Icons.add),
              //   ),
              // ],
            ),
            body: ListView(
              children: [
                const Center(
                  child: Text(
                    'Tap to take Selfie*',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () => cardsController.takeSelfie(
                      'selfies', 'selfie', cardsController.imageUrl),
                  child: Obx(
                    () => CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.deepPurple,
                      child: cardsController.imageUrl.value != ''
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: CachedNetworkImage(
                                imageUrl: cardsController.imageUrl.value,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 10,
                                            strokeCap: StrokeCap.round,
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error_outline),
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : AvatarGlow(
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
                // TxtInput(
                //   inputName: 'First Name',
                //   controller: cardsController.firstName,
                // ),
                // TxtInput(
                //   inputName: 'Middle Name',
                //   controller: cardsController.middleName,
                // ),
                // TxtInput(
                //   inputName: 'Last Name',
                //   controller: cardsController.lastName,
                // ),
                // Obx(
                //   () =>
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'First Name Should Match that of the ID card to be Uploaded*',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 11, 168, 16),
                    ),
                  ),
                ),
                TxtInput(
                  // initialValue:
                  //     authenticationController.userDetails.value.firstName,
                  inputName: 'First Name*',
                  controller: cardsController.firstName,
                ),
                // ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Last Name Should Match that of the ID card to be Uploaded*',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 11, 168, 16),
                    ),
                  ),
                ),
                TxtInput(
                  inputName: 'Last Name*',
                  controller: cardsController.lastName,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'ID No Should Match that of the ID card to be Uploaded*',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 11, 168, 16),
                    ),
                  ),
                ),
                TxtInput(
                  inputName: 'National ID Number*',
                  controller: cardsController.nationalIDNumber,
                ),
                TxtInput(
                  inputName: 'Phone Number*',
                  controller: cardsController.phone,
                ),

                TxtInput(
                  inputName: 'Address*',
                  controller: cardsController.address,
                ),
                TxtInput(
                  inputName: 'House Number',
                  controller: cardsController.houseNumber,
                ),
                // TxtInput(
                //   inputName: 'Enter a 4 Digit Pin',
                //   controller: cardsController.pin,
                //   ispin: true,
                //   keyboardType: TextInputType.number,
                //   inputFormatters: [
                //     // for below version 2 use this
                //     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                //     // for version 2 and greater youcan also use this
                //     FilteringTextInputFormatter.digitsOnly
                //   ],
                // ),

                // const Padding(
                //   padding: EdgeInsets.only(left: 15.0),
                //   child: Text('Select your Gender'),
                // ),
                if (country == 'Nigeria')
                  Column(
                    children: [
                      TxtInput(
                        inputName: 'Bvn',
                        controller: cardsController.bvn,
                      ),
                      TxtInput(
                        inputName: 'Phone Number',
                        controller: cardsController.phone,
                      ),
                      TxtInput(
                        inputName: 'Email',
                        controller: cardsController.email,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: CSCPicker(
                      //     dropdownDecoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(5),
                      //         color: Theme.of(context).cardColor),
                      //     selectedItemStyle:
                      //         const TextStyle(color: Colors.black),
                      //     dropdownHeadingStyle:
                      //         const TextStyle(color: Colors.black),
                      //     dropdownItemStyle:
                      //         const TextStyle(color: Colors.black),
                      //     flagState: CountryFlag.DISABLE,
                      //     onCountryChanged: (value) {
                      //       signUpController.countryValue.value = value;
                      //     },
                      //     onStateChanged: (value) {
                      //       signUpController.stateValue.value =
                      //           value.toString();
                      //     },
                      //     onCityChanged: (value) {
                      //       signUpController.cityValue.value =
                      //           value.toString();
                      //       print(signUpController.cityValue.value);
                      //     },
                      //   ),
                      // ),

                      // TxtInput(
                      //   inputName: 'House Number',
                      //   controller: cardsController.houseNumber,
                      // ),
                    ],
                  ),
                if (country != 'Nigeria')
                  Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //       child: Obx(
                      //         () => ListTile(
                      //           title: const Text('Male'),
                      //           leading: Radio<String>(
                      //             value: 'male',
                      //             groupValue: cardsController.holderGender.value,
                      //             onChanged: (String? value) {
                      //               // setState(() {
                      //               cardsController.holderGender.value = value!;
                      //               // });
                      //             },
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Obx(
                      //         () => ListTile(
                      //           title: const Text('Female'),
                      //           leading: Radio<String>(
                      //             value: 'female',
                      //             groupValue: cardsController.holderGender.value,
                      //             onChanged: (String? value) {
                      //               // setState(() {
                      //               cardsController.holderGender.value = value!;
                      //               // });
                      //             },
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      const Divider(),
                      const Text(
                        'Upload Front and Back Image of Your National ID',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Front*',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () => cardsController.takeSelfie(
                                    'NationalIDs',
                                    'front',
                                    cardsController.frontIDImageUrl),
                                child: Obx(
                                  () => CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.deepPurple,
                                    child:
                                        cardsController.frontIDImageUrl.value !=
                                                ''
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: CachedNetworkImage(
                                                  imageUrl: cardsController
                                                      .frontIDImageUrl.value,
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 10,
                                                          strokeCap:
                                                              StrokeCap.round,
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(
                                                          Icons.error_outline),
                                                  height: 120,
                                                  width: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : AvatarGlow(
                                                child: const Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 60,
                                                  color: Colors.white,
                                                ),
                                              ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                'Back*',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () => cardsController.takeSelfie(
                                    'NationalIDs',
                                    'back',
                                    cardsController.backIDImageUrl),
                                child: Obx(
                                  () => CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.deepPurple,
                                    child:
                                        cardsController.backIDImageUrl.value !=
                                                ''
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: CachedNetworkImage(
                                                  imageUrl: cardsController
                                                      .backIDImageUrl.value,
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 10,
                                                          strokeCap:
                                                              StrokeCap.round,
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(
                                                          Icons.error_outline),
                                                  height: 120,
                                                  width: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : AvatarGlow(
                                                child: const Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 60,
                                                  color: Colors.white,
                                                ),
                                              ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                Btn(
                  txtColor: Colors.white,
                  ontap: () =>
                      cardsController.validatedCardRegistrationDetails(),
                  btnName: 'NEXT',
                  color: Colors.deepPurple,
                )
              ],
            ),
          );
        }
      }),
    );
  }
}

final functions = FirebaseFunctions.instance;
