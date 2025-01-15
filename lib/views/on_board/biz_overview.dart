import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/components/drop_down_btn.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_data.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/views/authenication/login_page.dart';
import 'package:finitepay/views/on_board/socials_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BizOverviewPage extends StatelessWidget {
  BizOverviewPage({super.key, required this.size});
  double size;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
            if (constraints.maxWidth <= 500) {
              return const BizOverviewWidget();
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 3.5),
                child: const BizOverviewWidget(),
              );
            }
          },
        ),
      ],
    ));
  }
}

class BizOverviewWidget extends StatelessWidget {
  const BizOverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: kycController.bizOverViewController.value,
            child: ListView(
              physics:
                  // size == 500
                  //     ? const NeverScrollableScrollPhysics()
                  //     :

                  const ScrollPhysics(),
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let's Know Your Business",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tell us a bit about you & your business",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: kycController.businessName.value,
                  validator: (value) => (value!.trim().isEmpty)
                      ? "Businass Name is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Businass Name"
                          : null,
                  decoration: const InputDecoration(
                    labelText: 'Business Name*',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: updatedDropDown(
                        validator: (value) => (value!.trim().isEmpty)
                            ? "Comapany type required"
                            : (value.trim().length < 2)
                                ? "Enter a valid Comapany type"
                                : null,
                        controller: kycController.companyType.value,
                        items: companyTypes,
                        hintTxt: "Enter a valid Comapany type",
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: updatedDropDown(
                        validator: (value) => (value!.trim().isEmpty)
                            ? "Business Model required"
                            : (value.trim().length < 2)
                                ? "Enter a valid Business Model"
                                : null,
                        controller: kycController.businessModel.value,
                        items: businessModels,
                        hintTxt: 'Business Model*',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) => (value!.trim().isEmpty)
                      ? "Incorporation Number required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Incorporation Number"
                          : null,
                  controller: kycController.incorporationNo.value,
                  decoration: const InputDecoration(
                    labelText: 'Incorporation Number*',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          onTap: () async {
                            maincontroller.selectDate(context, false);
                            // Show date picker
                            // DateTime? pickedDate = await showDatePicker(
                            //   context: context,
                            //   initialDate: DateTime.now(),
                            //   firstDate: DateTime(1900),
                            //   lastDate: DateTime.now(),
                            // );
                            // Handle the selected date
                          },
                          validator: (value) => (value!.trim().isEmpty)
                              ? "Date of Incorporation required"
                              : (value.trim().length < 2)
                                  ? "Enter a valid Date of Incorporation"
                                  : null,
                          controller: kycController.dateofIncorporation.value,
                          decoration: const InputDecoration(
                            labelText: 'Date of Incorporation*',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 27.0, horizontal: 10),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: updatedDropDown(
                          validator: (value) => (value!.trim().isEmpty)
                              ? "Country of Incorporation required"
                              : (value.trim().length < 2)
                                  ? "Enter a valid Country of Incorporation"
                                  : null,
                          controller: kycController.countryIncoporated.value,
                          items: countries,
                          hintTxt: "Enter a valid Country of Incorporation",
                        ),
                        // TextFormField(
                        //   validator: (value) => (value!.trim().isEmpty)
                        //       ? "Country of Incorporation required"
                        //       : (value.trim().length < 2)
                        //           ? "Enter a valid Country of Incorporation"
                        //           : null,
                        //   controller: kycController.countryIncoporated.value,
                        //   decoration: const InputDecoration(
                        //     labelText: 'Country of Incorporation*',
                        //     border: OutlineInputBorder(),
                        //     suffixIcon: Icon(Icons.arrow_drop_down),
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: kycController.taxNumber.value,
                  validator: (value) => (value!.trim().isEmpty)
                      ? "Tax Number required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Tax Number"
                          : null,
                  decoration: const InputDecoration(
                    labelText: 'Tax Number*',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.info_outline),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) => (value!.trim().isEmpty)
                      ? "Company Address required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Company Address"
                          : null,
                  controller: kycController.companyAddress.value,
                  decoration: const InputDecoration(
                    labelText: 'Company Address*',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) => (value!.trim().isEmpty)
                            ? "State required"
                            : (value.trim().length < 2)
                                ? "Enter a valid State"
                                : null,
                        controller: kycController.state.value,
                        decoration: const InputDecoration(
                          labelText: 'State*',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        validator: (value) => (value!.trim().isEmpty)
                            ? "City required"
                            : (value.trim().length < 2)
                                ? "Enter a valid City"
                                : null,
                        controller: kycController.city.value,
                        decoration: const InputDecoration(
                          labelText: 'City*',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) => (value!.trim().isEmpty)
                      ? "Zip code required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Zip code"
                          : null,
                  controller: kycController.zipcode.value,
                  decoration: const InputDecoration(
                    labelText: 'Zip code*',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) => (value!.trim().isEmpty &&
                          value.contains('https') == false)
                      ? "Company Website required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Company Website"
                          : null,
                  controller: kycController.companyWebsite.value,
                  decoration: const InputDecoration(
                    labelText: 'Company Website*',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) => (value!.trim().isEmpty &&
                          value.contains('https') == false)
                      ? "Brief Description required"
                      : (value.trim().length < 10)
                          ? "Enter a valid Brief Description"
                          : null,
                  controller: kycController.companyActivities.value,
                  decoration: const InputDecoration(
                    labelText: 'What does your business do?*',
                    border: OutlineInputBorder(),
                    hintText: 'Brief Description',
                    suffixIcon: Icon(Icons.info_outline),
                  ),
                ),
                const SizedBox(height: 24),
                Btn(
                  txtColor: Colors.white,
                  ontap: () {
                    if (kycController.bizOverViewController.value.currentState!
                        .validate()) {
                      maincontroller.showLoading('Please wait');
                      FirebaseFirestore.instance
                          .collection('KycData')
                          .doc(fAuth.currentUser?.uid ?? '')
                          .set({
                        "BusinessName": kycController.businessName.value.text,
                        "BusinessModel": kycController.businessModel.value.text,
                        "IncorporationNumber":
                            kycController.incorporationNo.value.text,
                        "DateofIncorporation":
                            kycController.dateofIncorporation.value.text,
                        "CountryOfIncorporation":
                            kycController.countryIncoporated.value.text,
                        "TaxNumber": kycController.taxNumber.value.text,
                        "CompanyAddress":
                            kycController.companyAddress.value.text,
                        "State": kycController.state.value.text,
                        "City": kycController.city.value.text,
                        "Zipcode": kycController.zipcode.value.text,
                        "CompanyWebsite":
                            kycController.companyWebsite.value.text,
                        "CompanyActivities":
                            kycController.companyActivities.value.text,
                      }).then((value) {
                        Get.back();
                        Get.to(
                          () => const SocialsDetailsPage(),
                        );
                      });
                      // kycController.uploadKycData();
                    }

                    //  Get.to(()=>const SocialsDetailsPage());
                  },
                  btnName: 'Next',
                  color: const Color(0xFF5A31F4),
                )
              ],
            ),
          ),
          // ),
        ),
      ),
    );
  }
}
