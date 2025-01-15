import 'package:finitepay/components/drop_down_btn.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/currency_cloud_api_requests.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_data.dart';
// import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/views/authenication/create_account_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBeneficiaryPage extends StatelessWidget {
  const CreateBeneficiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    CurrencyCloudController xurrencyCloudController =
        Get.put(CurrencyCloudController());
    // xurrencyCloudController.createBeneficiaryFunction();
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            'Create Beneficiary ${maincontroller.countryCode.value}',
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width / 3.5,
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                txtForm(
                  'Beneficiary  Nickname',
                  maincontroller.beneficiaryNickName,
                  (value) => (value!.trim().isEmpty)
                      ? "Beneficiary  Nickname is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Beneficiary  Nickname "
                          : null,
                ),
                updatedDropDown(
                    controller: maincontroller.beneficiaryCountry,
                    items: countries,
                    hintTxt: 'Beneficiary Country'),
                updatedDropDown(
                    controller: maincontroller.bankcountryController,
                    items: countries,
                    hintTxt: 'Bank Country'),
                updatedDropDown(
                    controller: maincontroller.currencyController,
                    items: countries,
                    hintTxt: 'Select Currency'),
                txtForm(
                  'Bank Account Holder Name',
                  maincontroller.accountNameHolderController,
                  (value) => (value!.trim().isEmpty)
                      ? "Bank Account Holder Name is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Bank Account Holder Name"
                          : null,
                ),
                updatedDropDown(
                  controller: maincontroller.beneficiaryTypeController,
                  items: countries,
                  hintTxt: 'Beneficiary Type',
                ),
                txtForm(
                  'BIC/SWIFT',
                  maincontroller.bicSwiftController,
                  (value) => (value!.trim().isEmpty)
                      ? "BIC/SWIFT is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid BIC/SWIFT"
                          : null,
                ),
                txtForm(
                  'Account Number',
                  maincontroller.accountNumber,
                  (value) => (value!.trim().isEmpty)
                      ? "Account Number is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Account Number"
                          : null,
                ),
                txtForm(
                  'First Name',
                  maincontroller.firstNameController,
                  (value) => (value!.trim().isEmpty)
                      ? "First Name is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid First Name"
                          : null,
                ),
                txtForm(
                  'Last Name',
                  maincontroller.lastNameController,
                  (value) => (value!.trim().isEmpty)
                      ? "Last Name is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Last Name"
                          : null,
                ),
                txtForm(
                  'Address',
                  maincontroller.addressController,
                  (value) => (value!.trim().isEmpty)
                      ? "Address is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid Address"
                          : null,
                ),
                txtForm(
                  'City',
                  maincontroller.cityController,
                  (value) => (value!.trim().isEmpty)
                      ? "City is required"
                      : (value.trim().length < 2)
                          ? "Enter a valid City"
                          : null,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ElevatedButton(
                    //   style:
                    //       ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    //   onPressed: () {},
                    //   child: const Text(
                    //     'Cancel',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    Btn(
                      txtColor: Colors.white,
                      ontap: () {
                        Get.back();
                      },
                      btnName: 'Cancel',
                      color: Colors.red,
                    ),

                    Btn(
                        txtColor: Colors.white,
                        ontap: () {
                          Get.back();
                        },
                        btnName: 'Create Beneficiary',
                        color: const Color.fromARGB(255, 54, 73, 244)),

                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //       backgroundColor:
                    //           const Color.fromARGB(255, 54, 73, 244)),
                    //   onPressed: () {
                    //     xurrencyCloudController.createBeneficiaryFunction();

                    //     // Get.snackbar(
                    //     //   'Currency',
                    //     //   countryCodes[maincontroller.beneficiaryCountry.text]
                    //     //       .toString(),
                    //     // );
                    //   },
                    //   child: const Text(
                    //     'Proceed',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
