import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KycController extends GetxController {
   final companyActivities = TextEditingController().obs;
  final shareholderFirstName = TextEditingController().obs;
  final shareholderidNumber = TextEditingController().obs;
  final shareholderResidentialAddress = TextEditingController().obs;
  final shareholderShares = TextEditingController().obs;
  final shareholderLastName = TextEditingController().obs;
  final formcontrollers = GlobalKey<FormState>().obs;
  final bizOverViewController = GlobalKey<FormState>().obs;
  
  final socialsControllerKey = GlobalKey<FormState>().obs;
    
  final directorsController = GlobalKey<FormState>().obs;
    final shareholdersGlobal = GlobalKey<FormState>().obs;
  
  final pepStatusGlobal = GlobalKey<FormState>().obs;
    final fullnameController = TextEditingController().obs;
  final businessName = TextEditingController().obs;
  final companyType = TextEditingController().obs;
  final businessModel = TextEditingController().obs;
  final incorporationNo = TextEditingController().obs;
  final dateofIncorporation = TextEditingController().obs;
  final countryIncoporated = TextEditingController().obs;
  final taxNumber = TextEditingController().obs;
  final companyAddress = TextEditingController().obs;
  final state = TextEditingController().obs;
  final city = TextEditingController().obs;
  final zipcode = TextEditingController().obs;
  final companyWebsite = TextEditingController().obs;
  final aboutBusiness = TextEditingController().obs;
  final linkedinController = TextEditingController().obs;
  final xcontroller = TextEditingController().obs;
  final instagramcontroller = TextEditingController().obs;
  final facebookcontroller = TextEditingController().obs;
  final firstName = TextEditingController().obs;
  final lastName = TextEditingController().obs;
  final positionController = TextEditingController().obs;
  final dobController = TextEditingController().obs;
  final nationalityController = TextEditingController().obs;
  final iddoc = TextEditingController().obs;
  final idnumbercontroller = TextEditingController().obs;
  final countryIssued = TextEditingController().obs;
  final residentAddress = TextEditingController().obs;
  final pepname = TextEditingController().obs;
  final pepposition = TextEditingController().obs;
  final pepstatus = TextEditingController().obs;

  uploadKycData() {
    FirebaseFirestore.instance
        .collection('KycData')
        .doc(authenticationController.userDetails.value.uid)
        .set({
      'BusinessName': businessName.value.text,
      'businessModel': businessModel.value.text,
      'companyWebsite': companyWebsite.value.text,
      'city': city.value.text,
      'linkedin': linkedinController.value.text,
      'instagram': instagramcontroller.value.text,
      'x': xcontroller.value.text,
      'companyAddress': companyAddress.value.text,
      'companyType': companyType.value.text,
      'aboutBusiness': aboutBusiness.value.text,
      'zipcode': zipcode.value.text,
      'countryIssued': countryIssued.value.text,
      'state': state.value.text,
      'dob': dobController.value.text,
      'nationality': nationalityController.value.text,
      'countryIncoporated': countryIncoporated.value.text,
      'taxNumber': taxNumber.value.text,
      'dateofIncorporation': dateofIncorporation.value.text,
      'firstName': firstName.value.text,
      'lastName': lastName.value.text,
      'pepname': pepname.value.text,
      'pepposition': pepposition.value.text,
      'pepstatus': pepstatus.value.text,
      'residentAddress': residentAddress.value.text,
      'shareholderFirstName': shareholderFirstName.value.text,
      'shareholderLastName': shareholderLastName.value.text,
      'shareholderResidentialAddress': shareholderResidentialAddress.value.text,
      'shareholderidNumber': shareholderidNumber.value.text,
      'iddoc': iddoc.value.text,
      'idnumbercontroller': idnumbercontroller.value.text,
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(fAuth.currentUser?.email ?? '')
          .collection('information')
          .doc(fAuth.currentUser?.uid ?? '')
          .update({'onboardingDone': true});
      Get.snackbar(
          backgroundColor: const Color.fromARGB(255, 17, 129, 21),
          'Success',
          'Data Uploaded Successfully');

      authenticationController.getuserdetails().then((value) {
        Get.back();
      });
    });
  }
}
