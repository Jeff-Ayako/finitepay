import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/components/drop_down_btn.dart';
import 'package:finitepay/components/overrall_btn.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_data.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/views/authenication/login_page.dart';
import 'package:finitepay/views/on_board/pep_page.dart';
import 'package:finitepay/views/on_board/upload_doc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter/widgets.dart';

class ShareholdersPage extends StatelessWidget {
  const ShareholdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return 
    Scaffold(
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
              return shareholdersWidget(context);
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 3.5),
                child: shareholdersWidget(context),
              );
            }
          },
        ),
      ],
    ));
 
 
  }

  Widget shareholdersWidget(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: kycController.shareholdersGlobal.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Director Shareholders',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                    'We would like to know a bit about your Directors Shareholders'),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => RadioListTile<bool>(
                          title: const Text('Natural Person/UBOs'),
                          value: false,
                          groupValue: maincontroller.isUbo.value,
                          onChanged: (value) {
                            // setState(() {
                            maincontroller.isUbo.value = value!;
                            // });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => RadioListTile<bool>(
                          title: const Text('Legal Entity'),
                          value: true,
                          groupValue: maincontroller.isUbo.value,
                          onChanged: (value) {
                            // setState(() {
                            maincontroller.isUbo.value = value!;
                            // });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Row 1: First Name, Last Name, Position
                Row(
                  children: [
                    Expanded(
                        child: _buildTextField(
                      controller: kycController.firstName.value,
                      label: 'First Name',
                      validator: (value) => (value!.trim().isEmpty)
                          ? "First Name required"
                          : (value.trim().length < 2)
                              ? "Enter a valid First Name"
                              : null,
                    )),
                    const SizedBox(width: 16),
                    Expanded(
                        child: _buildTextField(
                      controller: kycController.lastName.value,
                      label: 'Last Name',
                      validator: (value) => (value!.trim().isEmpty)
                          ? "Last Name required"
                          : (value.trim().length < 2)
                              ? "Enter a valid Last Name"
                              : null,
                    )),
                    const SizedBox(width: 16),
                    Expanded(
                        child: _buildTextField(
                      controller: kycController.positionController.value,
                      label: 'Position',
                      validator: (value) => (value!.trim().isEmpty)
                          ? "Position required"
                          : (value.trim().length < 2)
                              ? "Enter a valid Position"
                              : null,
                    )),
                  ],
                ),
                const SizedBox(height: 16),

                // Row 2: Date of Birth, Nationality, Identification Document
                Row(
                  children: [
                    Expanded(
                        child:
                            _buildDateField(context, label: 'Date of Birth')),
                    const SizedBox(width: 16),
                    Expanded(
                      child: updatedDropDown(
                        validator: (value) => (value!.trim().isEmpty)
                            ? "Nationality required"
                            : (value.trim().length < 2)
                                ? "Enter a valid Nationality"
                                : null,
                        controller: kycController.nationalityController.value,
                        items: countries,
                        hintTxt: "Nationality",
                      ),
                      // _buildDropdownField(
                      //   label: 'Nationality',
                      //   optionsList: countries,
                      // ),
                    ),
                  ],
                ),
                // const SizedBox(height: 16),

                // Row 3: ID Number, Issued Country, Residential Address
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: kycController.idnumbercontroller.value,
                        label: 'ID Number',
                        validator: (value) => (value!.trim().isEmpty)
                            ? "ID Number required"
                            : (value.trim().length < 2)
                                ? "Enter a valid ID Number"
                                : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: updatedDropDown(
                        validator: (value) => (value!.trim().isEmpty)
                            ? "Country Issued required"
                            : (value.trim().length < 2)
                                ? "Enter a valid Country Issued"
                                : null,
                        controller: kycController.countryIssued.value,
                        items: countries,
                        hintTxt: "Country Issued",
                      ),
                      // _buildDropdownField(
                      //   label: 'Country Issued ',
                      //   optionsList: countries,
                      // ),
                    ),
                    // const SizedBox(width: 16),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: kycController.residentAddress.value,
                        label: 'Residential Address',
                        validator: (value) => (value!.trim().isEmpty)
                            ? "Residential Address required"
                            : (value.trim().length < 2)
                                ? "Enter a valid Residential Address"
                                : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: updatedDropDown(
                        validator: (value) => (value!.trim().isEmpty)
                            ? "Identification Document required"
                            : (value.trim().length < 2)
                                ? "Enter a valid Identification Document"
                                : null,
                        controller: kycController.iddoc.value,
                        items: ['Passport', 'National ID'],
                        hintTxt: "Identification Document",
                      ),
                      // _buildDropdownField(
                      //   label: 'Identification Document',
                      //   optionsList: ['Passport', 'National ID'],
                      // ),
                    ),
                  ],
                ),
                // const SizedBox(height: 16),

                _buildTextField(
                  controller: kycController.shareholderShares.value,
                  label: 'Percentage Share',
                  validator: (value) => (value!.trim().isEmpty)
                      ? "Percentage Share required"
                      : (value.trim().length < 1)
                          ? "Enter a valid Percentage Share"
                          : null,
                ),

                const SizedBox(height: 16),

                // Obx(
                //   () =>
                DocumentUploadField(
                  title: 'Identification Document Proof',
                  isRequired: true,
                  progress: maincontroller.directorID,
                ),
                // ),
                // Obx(
                //   () =>
                DocumentUploadField(
                  title: 'Residential Address Proof',
                  isRequired: true,
                  progress: maincontroller.directorResidenceProgress,
                ),

                // _buildTextField(
                //       controller: kycController.lastName.value,
                //       label: 'Percentage Share',
                //       validator: (value) => (value!.trim().isEmpty)
                //           ? "Percentage Share required"
                //           : (value.trim().length < 1)
                //               ? "Enter a valid Percentage Share"
                //               : null,
                //     )

                // ),

                // File Upload Fields
                // _buildFileUploadField(label: 'Identification Document Proof'),
                // _buildFileUploadField(label: 'Residential Address Proof'),
                // const SizedBox(height: 8),
                // Row(
                //   children: [
                //     Obx(
                //       () => Checkbox(
                //         // checkColor: const Color(0xFF5A31F4),
                //         // fillColor:   Color(0xff999),
                //         value: maincontroller.isShareholder.value,
                //         onChanged: (value) {
                //           maincontroller.isShareholder.value =
                //               !maincontroller.isShareholder.value;
                //         },
                //       ),
                //     ),
                //     const Text('This director is a shareholder'),
                //   ],
                // ),
                const SizedBox(height: 16),

                Btn(
                  txtColor: Colors.black,
                  ontap: () {
                    if (kycController.shareholdersGlobal.value.currentState!
                        .validate()) {
                           maincontroller.showLoading('Please wait');
                      // Define a Map that you want to add to the list in Firestore
                      final Map<String, dynamic> newItem = {
                        'FirstName': kycController.firstName.value.text,
                        'LastName': kycController.lastName.value.text,
                        'Position': kycController.positionController.value.text,
                        'DOB': kycController.dobController.value.text,
                        'Nationality':
                            kycController.nationalityController.value.text,
                        'IDNo': kycController.idnumbercontroller.value.text,
                        'CountryIssued': kycController.countryIssued.value.text,
                        'ResidentAddress':
                            kycController.residentAddress.value.text,
                        'IDdoctype': kycController.iddoc.value.text,
                        'IsDirectorShareHolder': true,
                        "Percentage": maincontroller
                            .percentageSharesController.text
                            .toString(),
                        "isUbo": maincontroller.isUbo,
                      };
                      FirebaseFirestore.instance
                          .collection('KycData')
                          .doc(fAuth.currentUser?.uid ?? '')
                          .update({
                        "Shareholders": FieldValue.arrayUnion([newItem])
                      }).then((value) {
                        maincontroller.directorID.value = 0.0;
                        maincontroller.directorResidenceProgress.value = 0.0;
                        Get.snackbar(
                            backgroundColor: Colors.green,
                            'Success',
                            '${kycController.firstName.value.text} was added successfully');
                        kycController.firstName.value.clear();
                        kycController.lastName.value.clear();
                        kycController.dobController.value.clear();
                        kycController.residentAddress.value.clear();

                        kycController.nationalityController.value.clear();

                        kycController.idnumbercontroller.value.clear();

                        kycController.countryIssued.value.clear();
                        kycController.iddoc.value.clear();
                        kycController.positionController.value.clear();
                      }).catchError((e) {
                        Get.snackbar(backgroundColor: Colors.red, 'Error', e);
                      });
                    }
                  },
                  btnName: "Save and Add Another Director Shareholders",
                  color: Colors.transparent,
                ),
                Btn(
                  txtColor: Colors.white,
                  ontap: () {
                    Get.to(
                      () => const PEPDeclarationPage(),
                    );
                  },
                  btnName: "I'm Done Adding Directors Shareholders",
                  color: const Color(0xFF5A31F4),
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required validator,
      required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, {required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: kycController.dobController.value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () async {
          maincontroller.selectDate(context, false);
          // // Show date picker
          // DateTime? pickedDate = await showDatePicker(
          //   context: context,
          //   initialDate: DateTime.now(),
          //   firstDate: DateTime(1900),
          //   lastDate: DateTime.now(),
          // );
          // Handle the selected date
        },
      ),
    );
  }
}














// import 'package:finitepay/components/overrall_btn.dart';
// import 'package:finitepay/controllers/init_controllers.dart';
// import 'package:finitepay/global/global_data.dart';
// import 'package:finitepay/views/on_board/pep_page.dart';
// import 'package:finitepay/views/on_board/upload_doc.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ShareholdersPage extends StatefulWidget {
//   const ShareholdersPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ShareholdersPageState createState() => _ShareholdersPageState();
// }

// class _ShareholdersPageState extends State<ShareholdersPage> {
//   bool isIndividual = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Shareholders'),
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Shareholders',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               const Text('We would like to know a bit about your shareholders'),
//               const SizedBox(height: 16),

//               // Shareholder Type Radio Buttons
//               Row(
//                 children: [
//                   Expanded(
//                     child: RadioListTile<bool>(
//                       title: const Text('Natural Person/UBOs'),
//                       value: true,
//                       groupValue: isIndividual,
//                       onChanged: (value) {
//                         setState(() {
//                           isIndividual = value!;
//                         });
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: RadioListTile<bool>(
//                       title: const Text('Legal Entity'),
//                       value: false,
//                       groupValue: isIndividual,
//                       onChanged: (value) {
//                         setState(() {
//                           isIndividual = value!;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Row 1: First Name, Last Name, Date of Birth
//               Row(
//                 children: [
//                   Expanded(
//                       child: _buildTextField(
//                     validator: (value) => (value!.trim().isEmpty)
//                         ? "First Name required"
//                         : (value.trim().length < 2)
//                             ? "Enter a valid First Name"
//                             : null,
//                     label: 'First Name',
//                     controller: kycController.shareholderFirstName.value,
//                   )),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: _buildTextField(
//                       validator: (value) => (value!.trim().isEmpty)
//                           ? "Last Name required"
//                           : (value.trim().length < 2)
//                               ? "Enter a valid Last Name"
//                               : null,
//                       label: 'Last Name',
//                       controller: kycController.shareholderLastName.value,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: _buildDateField(
//                       context,
//                       label: 'Date of Birth',
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Row 2: Nationality, Identification Document, ID/Passport Number
//               Row(
//                 children: [
//                   Expanded(
//                       child: _buildDropdownField(
//                           label: 'Nationality', optionsList: countries)),
//                   const SizedBox(width: 16),
//                   Expanded(
//                       child: _buildDropdownField(
//                           label: 'Identification Document',
//                           optionsList: ['National ID', 'Passport'])),
//                   const SizedBox(width: 16),
//                   Expanded(
//                       child: _buildTextField(
//                     label: 'ID/Passport Number',
//                     controller: kycController.shareholderidNumber.value,
//                     validator: (value) => (value!.trim().isEmpty)
//                         ? "ID/Passport Numbere required"
//                         : (value.trim().length < 2)
//                             ? "Enter a valid ID/Passport Number"
//                             : null,
//                   )),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Row 3: Issued Country, Residential Address, Percentage of Shares Owned
//               Row(
//                 children: [
//                   Expanded(
//                       child: _buildDropdownField(
//                           label: 'Issued Country', optionsList: countries)),
//                   const SizedBox(width: 16),
//                   Expanded(
//                       child: _buildTextField(
//                     label: 'Residential Address',
//                     controller:
//                         kycController.shareholderResidentialAddress.value,
//                     validator: (value) => (value!.trim().isEmpty)
//                         ? "Residential Address is required"
//                         : (value.trim().length < 2)
//                             ? "Enter a valid Residential Address"
//                             : null,
//                   )),
//                   const SizedBox(width: 16),
//                   Expanded(
//                       child: _buildTextField(
//                     label: 'Percentage of Shares Owned',
//                     controller: kycController.shareholderShares.value,
//                     validator: (value) => (value!.trim().isEmpty)
//                         ? "Percentage of Shares Owned is required"
//                         : (value.trim().length < 1)
//                             ? "Enter a valid Percentage of Shares Owned"
//                             : null,
//                   )),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // File Upload Fields

//                DocumentUploadField(

//                 title: 'Valid ID for Shareholder',
//                 isRequired: true,
//                 progress: maincontroller.directorID,
//               ),
//                DocumentUploadField(
//                 title: 'Proof of Address',
//                 isRequired: true,
//                   progress: maincontroller.directorResidenceProgress,
//               ),
//               // _buildFileUploadField(label: 'Valid ID for Shareholder'),
//               // _buildFileUploadField(label: 'Proof of Address'),
//               const SizedBox(height: 16),

//               // Buttons
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () {
//                         // Handle save and add another shareholder
//                       },
//                       child: const Text('Save and Add Another Shareholder'),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle done adding shareholders
//                 },
//                 child: const Text("I'm Done Adding Shareholders"),
//               ),
//               Btn(
//                 txtColor: Colors.black,
//                 ontap: () {
//                   // Get.to(
//                   //   () => const ShareholdersPage(),
//                   // );
//                 },
//                 btnName: "Save and Add Another Director",
//                 color: Colors.transparent,
//               ),
//               Btn(
//                 txtColor: Colors.white,
//                 ontap: () {
//                   Get.to(
//                     () => const PEPDeclarationPage(),
//                   );
//                 },
//                 btnName: "I'm Done Adding Directors",
//                 color: const Color(0xFF5A31F4),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     required validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         validator: validator,
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }

//   Widget _buildDateField(BuildContext context, {required String label}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//           suffixIcon: const Icon(Icons.calendar_today),
//         ),
//         readOnly: true,
//         onTap: () async {
//           // Show date picker
//           DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(1900),
//             lastDate: DateTime.now(),
//           );
//           // Handle the selected date
//         },
//       ),
//     );
//   }

//   Widget _buildDropdownField({
//     required String label,
//     required List<String> optionsList,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: DropdownButtonFormField<String>(
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//         items: optionsList
//             .map((option) =>
//                 DropdownMenuItem(value: option, child: Text(option)))
//             .toList(),
//         onChanged: (value) {
//           // Handle dropdown change
//         },
//       ),
//     );
//   }

//   Widget _buildFileUploadField({required String label}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: GestureDetector(
//         onTap: () {
//           // Handle file upload
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 16.0),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.upload_file, color: Colors.grey),
//               SizedBox(width: 8),
//               Text(
//                 'Choose File To Upload (Required)',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
