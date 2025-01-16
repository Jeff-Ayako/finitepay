import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:flutter/material.dart';
// import 'package:searchfield/searchfield.dart';

Widget updatedDropDown(
    {validator,
    required TextEditingController controller,
    required List items,
    required String hintTxt}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(0.0),
        child: Form(
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(157, 171, 164, 164),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container()
              // SearchField(
              //   validator: validator,
              //   // maxSuggestionsInViewPort = 5,
              //   itemHeight: 80,
              //   controller: controller,
              //   maxSuggestionsInViewPort: 10,
              //   searchInputDecoration: SearchInputDecoration(
              //     border: InputBorder.none,
              //     suffixIcon: const Icon(Icons.arrow_downward_outlined),
              //     contentPadding:
              //         const EdgeInsets.symmetric(vertical: 27.0, horizontal: 10),
              //     hintText: hintTxt,
              //     // border: OutlineInputBorder(
              //     //   borderRadius: BorderRadius.circular(
              //     //     10,
              //     //   ),
              //     // ),
              //   ),
              //   suggestions: items
              //       .map(
              //         (e) => SearchFieldListItem(
              //           e,
              //           child: Text(e),
              //         ),
              //       )
              //       .toList(),
              //   onSuggestionTap: (value) {
              //     maincontroller.selectedregOpt.value =
              //         maincontroller.registrationOpt.text.toString();
              //     maincontroller.selectedSubAct.value =
              //         maincontroller.subAccountOpt.text.toString();
              //     maincontroller.countryCode.value =
              //         countryCodes[maincontroller.beneficiaryCountry.text]
              //             .toString();
              //     maincontroller.countryCode.refresh();
              //   },
              // ),

              ),
        ),
      ),
      const SizedBox(height: 16.0),
    ],
  );
}
