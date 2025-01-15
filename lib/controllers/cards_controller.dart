import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/bridgecards_test/all_cards_homepage.dart';
import 'package:finitepay/bridgecards_test/cardholders_page_list.dart';
import 'package:finitepay/bridgecards_test/single_card_page_details.dart';
import 'package:finitepay/bridgecards_test/test_customer_card.dart';
// import 'package:finitepay/bridgecards_test/test_transaction_page.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/models/cards_models/actual_card_details.dart';
import 'package:finitepay/models/cards_models/bridge_fx.dart';
import 'package:finitepay/models/cards_models/card_holders.dart';
import 'package:finitepay/models/cards_models/card_token_model.dart';
import 'package:finitepay/models/cards_models/card_transaction.dart';
import 'package:finitepay/models/cards_models/cards_under_account.dart';
import 'package:finitepay/models/cards_models/countries_states.dart';
import 'package:finitepay/models/cards_models/customer_card_model.dart';
import 'package:finitepay/models/cards_models/on_created_card_holder.dart';
import 'package:finitepay/models/cards_models/single_card_model.dart';
import 'package:finitepay/models/cards_models/unloading_transcation_model.dart';
import 'package:finitepay/models/cards_models/wallet_balance.dart';
import 'package:finitepay/views/home/dashboard_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

// import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

//  cardholderid kenyan based: 49fb225b46344edfb9dd008dc23a5124

// "cardholder_id": "107611bc7a464c03b399a65ab9511cb1"

class CardsController extends GetxController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController houseNumber = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController numberOfDollars = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController bvn = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController nationalIDNumber = TextEditingController();

  TextEditingController amountTranscated = TextEditingController();
  final cardAmountInCents = 0.0.obs;
  final mpesaMerchantID = ''.obs;

  final isCardholderPresentButNoCards = false.obs;

  RxList<Map<String, dynamic>> flags = <Map<String, dynamic>>[
    {
      'flag':
          'https://avatars.mds.yandex.net/i?id=2d5b9bb3eb41a38ece4086973a01a170f0feb1ec-7086266-images-thumbs&n=13',
      'country': 'Kenya',
    },
    {
      'flag':
          'https://avatars.mds.yandex.net/i?id=e8e20bece4f2e0ae7008341eb30aa18efbed49de-10918904-images-thumbs&n=13',
      'country': 'Uganda',
    },
    {
      'flag':
          'https://avatars.mds.yandex.net/i?id=1d0b5bea3658da4e3a4dee6b4efed786709a7996-7979832-images-thumbs&n=13',
      'country': 'Nigeria',
    },
    {
      'flag':
          'https://avatars.mds.yandex.net/i?id=379489267cac4789ebcae622fe4bde66b8085913-5888427-images-thumbs&n=13',
      'country': 'Ghana',
    },
    // 'https://avatars.mds.yandex.net/i?id=e8e20bece4f2e0ae7008341eb30aa18efbed49de-10918904-images-thumbs&n=13',
    // 'https://avatars.mds.yandex.net/i?id=1d0b5bea3658da4e3a4dee6b4efed786709a7996-7979832-images-thumbs&n=13',
    // 'https://avatars.mds.yandex.net/i?id=379489267cac4789ebcae622fe4bde66b8085913-5888427-images-thumbs&n=13'
  ].obs;

  final bridgetestKey =
      'sk_test_VTJGc2RHVmtYMS9oSndkdDY2V04rN2VTejRxNEc5dFpuWUN2RnNOWlVpeVdZZnpTZTIrRGtTR2dxRDkrRC85ZGRZbUhpQnNxMjB0b1RiUXZ6SGNRL1phZ243ZVVlZVA1eGpubUNJNm1HbzBGTFk5YUJWUFNvdVFiZTNsbExNV3RpczNmWHFTVmIzWDVLdXVkNFdPdXE5OXlIdXlteGtQYk12S0ZRYXcxUXJCa2d0SU1RTnZWcW9JQW5EUDNDaWV1QTVnTnJDV2V3MkprT2xURktWWjZ1SSt0MVg0ak5jZ2ZSWXNUdFdqWDlMbWVHc0dlVGcxVk0yRkV3VUYrZXpCTDFncEJidCt0M2IxYzVtbVk1N2dVMjRZeE5aSlVKQzMyQU8rWHRnbFlMOHZ2bEs2VU9vZzVyUHlWYy9YY01hNnpxbHVjZG1ZYzIvWmtENTVyRGdKRldlbjU2cFlubDdESlJMRjMwejZOMERyUmN4cUczekUvMUJ3NGtyU2dxd0ZweUVWbVR0SHpnYjFMamZrS05saWhrWnV0TWw4Q3JhV2ZZM1FEM2kvQ2ZkWXhnREorMFJRSUg4STlmYkdzWVRBL0VkTTh0TG1iRGw4NHppL0hEeGpXTnpja2JaTUttbC9VQUd1bXNraEFJaE09'
          .obs;
  final cardholder = Rxn<CardHolder>();

  final showCardDetails = false.obs;

  final holderGender = 'male'.obs;
  final cardBrand = 'Visa'.obs;

  final cardsUnderAccount = Rxn<CardsUnderAccount>();

  final walletBallance = Rxn<WalletBallance>();

  final bridgeFxRate = Rxn<BridgeFxRate>();

  final singleCardDetails = Rxn<SingleCardDetails>();

  final countriesStates = Rxn<CountriesStates>();

  final cardTokenModel = Rxn<CardTokenModel>();

  final actualCardDetails = Rxn<ActualCardDetails>();

  final cardHolderCreatedSuccessfully = Rxn<CardHolderCreatedSuccessfully>();

  final unloadingTranscation = Rxn<UnloadingTranscation>();

  final cardTransactions = Rxn<CardTransactions>();

  final customerCards = Rxn<CustomerCards>();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  final imageUrl = ''.obs;
  final frontIDImageUrl = ''.obs;
  final backIDImageUrl = ''.obs;
  final encryptedPinCardPinValue = ''.obs;

  XFile? selfieFile;

  Future<String> encryptPin(String pin) async {
    final url = Uri.parse(
        "https://us-central1-mpesa-flutter.cloudfunctions.net/encryptPin");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"pin": pin}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(responseData['encryptedPin']);
      encryptedPinCardPinValue.value = responseData['encryptedPin'];
      encryptedPinCardPinValue.refresh();
      return responseData['encryptedPin'];
    } else {
      throw Exception('Failed to encrypt PIN: ${response.body}');
    }
  }

  // import 'package:flutter/foundation.dart' show kIsWeb;

  Future<XFile> compressXFileToXFile(XFile xFile, int quality) async {
    // Convert XFile to bytes
    final bytes = await xFile.readAsBytes();

    // Decode the image
    final image = img.decodeImage(bytes);
    if (image == null) {
      throw Exception('Could not decode image.');
    }

    // Compress the image
    final compressedBytes = img.encodeJpg(image, quality: quality);

    // Save the compressed image to a temporary file
    final directory = await getTemporaryDirectory();
    final compressedFilePath =
        '${directory.path}/compressed_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final compressedFile = File(compressedFilePath);

    await compressedFile.writeAsBytes(compressedBytes);

    // Return the compressed image as an XFile
    return XFile(compressedFilePath);
  }

  Future<void> takeSelfie(
    String storageLocation,
    String imageType,
    RxString displayImage,
  ) async {
    try {
      XFile? imageFile;

      // Capture image differently for web and mobile
      if (kIsWeb) {
        imageFile = await _picker.pickImage(source: ImageSource.gallery);
        selfieFile = imageFile;
        // Compress the XFile and get a compressed XFile
        imageFile = await compressXFileToXFile(imageFile!, 75);
      } else {
        imageFile = await _picker.pickImage(source: ImageSource.camera);
        // Compress the XFile and get a compressed XFile
        imageFile = await compressXFileToXFile(imageFile!, 75);
      }

      if (imageFile == null) {
        return; // User canceled the operation
      }

      final String fileName =
          "$storageLocation/${DateTime.now().millisecondsSinceEpoch}.jpg";

      // Handle file upload for web
      if (kIsWeb) {
        final Uint8List imageData = await imageFile.readAsBytes();
        final UploadTask uploadTask = _storage.ref(fileName).putData(imageData);
        final TaskSnapshot snapshot = await uploadTask;
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        displayImage.value = downloadUrl;
      } else {
        // Handle file upload for mobile
        final File file = File(imageFile.path);
        final TaskSnapshot snapshot =
            await _storage.ref(fileName).putFile(file);
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        displayImage.value = downloadUrl;
      }

      // Store metadata in Firestore
      await _firestore.collection(storageLocation).add({
        'imageUrl': displayImage.value,
        'Username':
            authenticationController.userDetails.value.fullname.toString(),
        'uid': authenticationController.userDetails.value.uid.toString(),
        'email':
            authenticationController.userDetails.value.firstName.toString(),
        'imaageType': imageType,
      });

      displayImage.refresh();

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
            backgroundColor: const Color.fromARGB(255, 9, 128, 13),
            content: Text('$imageType uploaded successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('Failed to upload $imageType: $e')),
      );
    }
  }

  String decryptCardDetail(String encryptedText, String key) {
    try {
      // Extract relevant parts if needed
      final parts = encryptedText.split(':');
      if (parts.length < 5) {
        throw Exception("Invalid encryption format");
      }

      // Assuming the encryption algorithm is AES with Base64 encoding
      final encryptedValue =
          parts[3]; // Extract encrypted value from the format
      final keyBytes =
          encrypt.Key.fromUtf8(key.padRight(32)); // Key must be 32 bytes
      final iv = encrypt.IV.fromLength(16); // Adjust IV as per your algorithm

      // Initialize the encrypter
      final encrypter = encrypt.Encrypter(encrypt.AES(keyBytes));

      // Decrypt the data
      final decrypted = encrypter.decrypt64(encryptedValue, iv: iv);

      return decrypted; // Return the decrypted text
    } catch (e) {
      return "Error decrypting: $e";
    }
  }

  Future<Map<String, dynamic>> registerNigeriaCardHolder() async {
    showLoading("Please Wait...");
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cardholder/register_cardholder_synchronously');

    final headers = {
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    final body = jsonEncode({
      "first_name": "Mwakideu",
      "last_name": "Mulla",
      "address": {
        "address": "Mombasa Road Street",
        "city": "Nairobi",
        "state": "Nairobi",
        "country": "Kenya",
        "postal_code": "43833",
        "house_no": "13"
      },
      "phone": "0746073345",
      "email_address": "jeffmwakideu1@gmail.com",
      "identity": {
        "id_type": "KENYAN_NATIONAL_ID",
        "id_no": "36657489",
        "first_name": "Mwakideu",
        "last_name": "Mulla",
        "middle_name": "Moe",
        "date_of_birth": "1990-12-02",
        "gender": "male",
        "selfie_image": "https://image.com"
      },
      "meta_data": {"any_key": "any_value"}
    }

        //   {
        //   "first_name":
        //       firstName.text,
        //   "last_name":
        //       lastName.text,
        //   "address": {
        //     "address": address.text,
        //     "city": authenticationController.userDetails.value.city.toString(),
        //     "state": authenticationController.userDetails.value.state.toString(),
        //     "country": authenticationController.userDetails.value.country.toString(),
        //     "postal_code":
        //         authenticationController.userDetails.value.postalCode.toString(),
        //     "house_no": houseNumber.text.toString(),
        //   },
        //   "phone": "08452277789",
        //   "email_address": 'testingboy4@gmail.com',
        //   //authenticationController.userDetails.value.email.toString(),
        //   "identity": {
        //     "id_type": "NIGERIAN_BVN_VERIFICATION",
        //     "bvn": bvn.text.toString(),
        //     "selfie_image": imageUrl.value.toString(),
        //   },
        //   "meta_data": {"any_key": "any_value"}
        // }

        //     {
        //   "first_name":
        //       authenticationController.userDetails.value.firstName.toString(),
        //   "last_name":
        //       authenticationController.userDetails.value.lastName.toString(),
        //   "address": {
        //     "address": address.text.toString(),
        //     "city": authenticationController.userDetails.value.city.toString(),
        //     "state": authenticationController.userDetails.value.state.toString(),
        //     "country":
        //         authenticationController.userDetails.value.country.toString(),
        //     "postal_code":
        //         authenticationController.userDetails.value.postalCode.toString(),
        //     "house_no": houseNumber.text.toString(),
        //   },
        //   "phone": authenticationController.userDetails.value.phone.toString(),
        //   "email_address":
        //       authenticationController.userDetails.value.email.toString(),
        //   "identity": {
        //     "id_type": "KENYAN_VOTERS_ID",
        //     "id_no":
        //         authenticationController.userDetails.value.nationalID.toString(),
        //     "first_name":
        //         authenticationController.userDetails.value.firstName.toString(),
        //     "last_name":
        //         authenticationController.userDetails.value.lastName.toString(),
        //     "middle_name": middleName.text,
        //     "date_of_birth": '1990-12-02',
        //     //authenticationController.userDetails.value.dob.toString(),
        //     "gender": cardsController.holderGender.value,
        //     "selfie_image": imageUrl.value.toString(),
        //   },
        //   "meta_data": {"any_key": "any_value"},
        // }
        );

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Check the status code
      if (response.statusCode == 201) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        Get.snackbar(
          'Success',
          'Cardholder created successfully.',
          backgroundColor: Colors.green,
        );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to create card holder.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

  validatedCardRegistrationDetails() {
    firstName.text.trim();
    lastName.text.trim();
    nationalIDNumber.text.trim();
    phone.text.trim();
    address.text.trim();
    houseNumber.text.trim();
    // phone.text.trim();

    if (firstName.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Enter a Valid First Name',
          ),
        ),
      );
    } else if (lastName.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Enter a Valid Last Name',
          ),
        ),
      );
    } else if (nationalIDNumber.text.length < 8) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'National ID number cannot be less than 8 characters Long',
          ),
        ),
      );
    } else if (phone.text.length != 10) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Phone Number cannot be less or more than 10 Characters Long',
          ),
        ),
      );
    } else if (imageUrl == '') {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Upload Your Selfie Image to Proceed',
          ),
        ),
      );
    } else if (address.text.isEmpty && houseNumber.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Please enter You address and House Number',
          ),
        ),
      );
    } else if (frontIDImageUrl == '' && backIDImageUrl == '') {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Front and Back Images Of you National ID required',
          ),
        ),
      );
    } else {
      fxController.getCurrentApiConversionRates();
    }
  }

  Future registerKenyaCardHolder() async {
    if (imageUrl == '') {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Upload Your Selfie Image to Proceed',
          ),
        ),
      );
    } else if (address.text.isEmpty && houseNumber.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Please enter You address and House Number',
          ),
        ),
      );
    } else if (frontIDImageUrl == '' && backIDImageUrl == '') {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Front and Back Images Of you National ID required',
          ),
        ),
      );
    } else if (pin.text.length != 4) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Card pin should not be less or more than 4 characters',
          ),
        ),
      );
    } else {
      showLoading("Please Wait...");
      // ignore: unrelated_type_equality_checks

      encryptPin(pin.text.toString()).then((value) async {
        final url = Uri.parse(
            'https://issuecards.api.bridgecard.co/v1/issuing/cardholder/register_cardholder_synchronously');

        final headers = {
          'Content-Type': 'application/json',
          'token': // Use "Authorization" instead of "token"
              'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
        };

        final body = jsonEncode({
          "first_name": firstName.text.toString(),
          // authenticationController.userDetails.value.firstName.toString(),
          "last_name": lastName.text.toString(),
          // authenticationController.userDetails.value.lastName.toString(),
          "address": {
            "address": address.text.toString(),
            "city": "Nairobi",
            "state": "Nairobi",
            "country": "Kenya",
            "postal_code": authenticationController.userDetails.value.postalCode
                .toString(),
            "house_no": houseNumber.text.toString().isEmpty
                ? '1'
                : houseNumber.text.toString(),
          },
          "phone": phone.text
              .toString(), //authenticationController.userDetails.value.phone.toString(),
          "email_address":
              authenticationController.userDetails.value.email.toString(),
          "identity": {
            "id_type": "KENYAN_NATIONAL_ID",
            "id_no": nationalIDNumber.text.toString(),
            // authenticationController.userDetails.value.nationalID.toString(),
            "id_image": frontIDImageUrl.value.toString(),
            "selfie_image": imageUrl.value.toString(),
            "back_id_image": backIDImageUrl.value.toString()
          },
          "meta_data": {"any_key": "any_value"}
        });

        try {
          final response = await http.post(url, headers: headers, body: body);

          // Check the status code
          if (response.statusCode == 201) {
            // Decode JSON
            final Map<String, dynamic> data = jsonDecode(response.body);

            print(response.body);

            cardHolderCreatedSuccessfully.value =
                cardHolderCreatedSuccessfullyFromJson(response.body);
            cardHolderCreatedSuccessfully.refresh();

            Get.snackbar(
              'Success',
              'Cardholder created successfully.',
              backgroundColor: Colors.green,
            );

            FirebaseFirestore.instance
                .collection('CardHolders')
                .doc(data["data"]["cardholder_id"])
                .set({
              'cardholder_id': data["data"]["cardholder_id"],
              'uid': authenticationController.userDetails.value.uid,
              'email': authenticationController.userDetails.value.email,
              'fullname': authenticationController.userDetails.value.fullname,
            }).then((value) {
              Get.snackbar(
                  backgroundColor: Colors.green,
                  'Success',
                  'Data Uploaded Successfully');
              createUSDCard(
                data["data"]["cardholder_id"],
                // pin.text.toString(),
              );
              maincontroller.getCardHolder();
            }).catchError((error) {
              Get.snackbar(
                  backgroundColor: Colors.red,
                  'Error',
                  'Following error occured $error');
            });

            return data;
          } else {
            // Handle other status codes
            final Map<String, dynamic> errorData = jsonDecode(response.body);
            Get.snackbar(
              'Error',
              'Error: ${errorData['message'] ?? 'Failed to create card holder.'}',
              backgroundColor: Colors.red,
            );
            throw Exception('Error: ${errorData['message']}');
          }
        } catch (error) {
          // Handle network or other unexpected errors
          Get.snackbar(
            'Error',
            'An unexpected error occurred: $error',
            backgroundColor: Colors.red,
          );
          throw Exception('Unexpected Error: $error');
        }
      });
    }
  }

  Future<Map<String, dynamic>> registerCardHolder() async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cardholder/register_cardholder_synchronously');

    final headers = {
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    final body = jsonEncode({
      "first_name": "Alex",
      "last_name": "Mwakideu",
      "address": {
        "address": "9 Kiambu",
        "city": "Nairobi",
        "state": "Ruiru",
        "country": "Kenya",
        "postal_code": "1000242",
        "house_no": "13"
      },
      "phone": "08122277789",
      "email_address": "testingboy@gmail.com",
      "identity": {
        "id_type": "KENYAN_VOTERS_ID",
        "id_no": "32747711121",
        "first_name": "Alex",
        "last_name": "Mwakideu",
        "middle_name": "Moe",
        "date_of_birth": "1990-12-02",
        "gender": "male",
        "selfie_image": "https://image.com",
      },
      "meta_data": {"any_key": "any_value"}
    }

        //     {
        //   "first_name":
        //       authenticationController.userDetails.value.firstName.toString(),
        //   "last_name":
        //       authenticationController.userDetails.value.lastName.toString(),
        //   "address": {
        //     "address": address.text.toString(),
        //     "city": authenticationController.userDetails.value.city.toString(),
        //     "state": authenticationController.userDetails.value.state.toString(),
        //     "country":
        //         authenticationController.userDetails.value.country.toString(),
        //     "postal_code":
        //         authenticationController.userDetails.value.postalCode.toString(),
        //     "house_no": houseNumber.text.toString(),
        //   },
        //   "phone": authenticationController.userDetails.value.phone.toString(),
        //   "email_address":
        //       authenticationController.userDetails.value.email.toString(),
        //   "identity": {
        //     "id_type": "KENYAN_VOTERS_ID",
        //     "id_no":
        //         authenticationController.userDetails.value.nationalID.toString(),
        //     "first_name":
        //         authenticationController.userDetails.value.firstName.toString(),
        //     "last_name":
        //         authenticationController.userDetails.value.lastName.toString(),
        //     "middle_name": middleName.text,
        //     "date_of_birth": '1990-12-02',
        //     //authenticationController.userDetails.value.dob.toString(),
        //     "gender": cardsController.holderGender.value,
        //     "selfie_image": imageUrl.value.toString(),
        //   },
        //   "meta_data": {"any_key": "any_value"},
        // }
        );

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Check the status code
      if (response.statusCode == 201) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        Get.snackbar(
          'Success',
          'Cardholder created successfully.',
          backgroundColor: Colors.green,
        );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to create card holder.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

//  GET ALL THE CARD HOLDERS.
  Future<Map<String, dynamic>> getAllCardHolders() async {
    showLoading("Please Wait...");
    // Show a loading dialog
    // Get.dialog(
    //   const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    //   barrierDismissible: false, // Prevent dismissing the dialog
    // );
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/get_all_cardholder?page=1');

    final headers = {
      // 'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        cardholder.value = cardHolderFromJson(response.body);
        Get.snackbar(
          'Success',
          ' Got this Card Cardholders.',
          backgroundColor: Colors.green,
        );

        Get.to(
          () => const CardHoldersList(),
        )!
            .then((value) {
          // Close the loading dialog
          Get.back();
        });
        // Get.back();
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to get cardholders.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

  //  GET ALL THE CARD INFORMATION.
  Future<Map<String, dynamic>> getSingleCardInfo(String cardID) async {
    showLoading("Please Wait...");
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/get_card_details?card_id=$cardID');

    final headers = {
      // 'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        singleCardDetails.value = singleCardDetailsFromJson(response.body);
        Get.snackbar(
          'Success',
          ' Got Card Details.',
          backgroundColor: Colors.green,
        );
        Get.to(
          () => const SingleCardDetailsPage(),
        )!
            .then((value) {
          // Close the loading dialog
          Get.back();
        });
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to get Card Details.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

  //  GET ALL THE CARD HOLDERS UNDER SPECIFIC CARD HOLDER.
  Future<Map<String, dynamic>> getallCardsIssued() async {
    showLoading("Please Wait...");
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/get_all_cards?page=1');

    final headers = {
      // 'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        cardsUnderAccount.value = cardsUnderAccountFromJson(response.body);

        // for (int i = 0; i < cardsUnderAccount.value!.data.cards.length; i++) {
        //    .
        // }

        Get.snackbar(
          'Success',
          ' Got this Card Cards.',
          backgroundColor: Colors.green,
        );
        Get.to(
          () => const CardsUnderAccountPage(),
        )!
            .then((value) {
          // Close the loading dialog
          Get.back();
        });
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to get cardholders.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

  //  Get issuing wallet balance
  Future<Map<String, dynamic>> getissueingWalletBalance() async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/get_issuing_wallet_balance');

    final headers = {
      // 'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        walletBallance.value = walletBallanceFromJson(response.body);
        walletBallance.refresh();
        // cardsUnderAccount.value = cardsUnderAccountFromJson(response.body);
        Get.snackbar(
          'Success',
          ' Got this Card Cards. ${walletBallance.value?.data.issuingBalanceUsd ?? '0.0'}',
          backgroundColor: Colors.green,
        );
        // Get.to(
        //   () => const CardsUnderAccountPage(),
        // );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to get cardholders.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

  //  GET COUNTRIES STATES
  Future<Map<String, dynamic>> getCountriesStates() async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cardholder/get_all_states?country=Kenya');

    final headers = {
      // 'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        countriesStates.value = countriesStatesFromJson(response.body);
        countriesStates.refresh();
        // cardsUnderAccount.value = cardsUnderAccountFromJson(response.body);
        Get.snackbar(
          'Success',
          ' Got this States. ${countriesStates.value?.data.states ?? '[]'}',
          backgroundColor: Colors.green,
        );
        print('${countriesStates.value?.data.states ?? '[]'}');
        // Get.to(
        //   () => const CardsUnderAccountPage(),
        // );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to get Countries.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

  //  GET TOKEN TO CHECK CARD DETAILS,
  Future<Map<String, dynamic>> getCardToken(String cardID) async {
    // showLoading('Please wait...');
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/generate_token_for_card_details?card_id=$cardID');

    final headers = {
      // 'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        cardTokenModel.value = cardTokenModelFromJson(response.body);
        cardTokenModel.refresh();
        // cardsUnderAccount.value = cardsUnderAccountFromJson(response.body);

        // Get.snackbar(
        //   'Success',
        //   'Your Card token is: ${cardTokenModel.value?.data.token ?? ''}',
        //   backgroundColor: Colors.green,
        // );
        // print("Card token: ${cardTokenModel.value?.data.token ?? ''}");

        getCardTransactions(cardID);

        getActualCardDetails(cardTokenModel.value?.data.token ?? '');
        // Get.to(
        //   () => const CardsUnderAccountPage(),
        // );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to get Token'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

//  GET ACTUAL CARD DETAILS,
  Future<Map<String, dynamic>> getActualCardDetails(String token) async {
    // showLoading("Please Wait...");
    final url = Uri.parse(
        'https://issuecards-api-bridgecard-co.relay.evervault.com/v1/issuing/cards/get_card_details_from_token?token=$token');

    final headers = {
      // 'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('11111111111111111111111111111111111111111111111111');
        print(response.body);
        print('2222222222222222222222222222222222222222222222222');

        actualCardDetails.value = actualCardDetailsFromJson(response.body);
        actualCardDetails.refresh();
        // cardsUnderAccount.value = cardsUnderAccountFromJson(response.body);
        // Get.snackbar(
        //   'Success',
        //   'Got Actual Card Details',
        //   backgroundColor: Colors.green,
        // );

        if (maincontroller.cardCreatedFromHome.value == true) {
          Get.to(
            () => const SingleCardDetailsPage(),
          )!
              .then((result) {
            if (result == 'refresh') {
              // Call your refresh method
              cardsController.customerCards.refresh();
            }
            // Close the loading dialog
            Get.back();
            Get.back();
            Get.back();
          });
        }
        // Get.to(
        //   () => const SingleCardDetailsPage(),
        // )!
        //     .then((value) {
        //   // Close the loading dialog
        //   Get.back();
        //   Get.back();
        //   Get.back();
        // });
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to get Card Details'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

  //  Get issuing wallet balance
  Future<Map<String, dynamic>> getbridgeFxRates() async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/fx-rate');

    final headers = {
      // 'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        bridgeFxRate.value = bridgeFxRateFromJson(response.body);
        bridgeFxRate.refresh();
        // cardsUnderAccount.value = cardsUnderAccountFromJson(response.body);
        Get.snackbar(
          'Success',
          ' Got this Fx Rates. ${bridgeFxRate.value?.data.ngnUsd ?? '0.0'}',
          backgroundColor: Colors.green,
        );
        // Get.to(
        //   () => const CardsUnderAccountPage(),
        // );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to get FX rates.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

  //  FUND WALLETS ACCOUNTS. WE CALLING THE PATCH FUNCTION  DURING THE FUNDING OPPERATION.
  Future<Map<String, dynamic>> fundWalletsAccount() async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/fund_issuing_wallet');

    final headers = {
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.patch(
        url,
        headers: headers,
        body: {
          "amount": "150",
        },
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          ' Wallet funded successfully.',
          backgroundColor: Colors.green,
        );
        // Get.to(
        //   () => const CardsUnderAccountPage(),
        // );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Fund Wallet.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.amber,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

//  ACTIVATE PHYSICAL DOLLAR CARD FUNCTION.....
  Future<Map<String, dynamic>> activatePhysicalCardFunc(
      String cardholderId, String cardtoken) async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/activate_physical_card');

    final headers = {
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: {
          "cardholder_id": cardholderId, //"37383839939030",
          "card_type": "physical",
          "card_brand": "Mastercard",
          "card_currency": "NGN",
          "card_token_number": cardtoken, //"37383839939030",
          "meta_data": {}
        },
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          ' Card Activated successfully.',
          backgroundColor: Colors.green,
        );
        // Get.to(
        //   () => const CardsUnderAccountPage(),
        // );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Fund Wallet.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.amber,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

//  CREATE USD CARD.....
  createUSDCard(
    String cardholderId,
  ) async {
    showLoading('Creating Card...');
    // const pin = pin; // Replace with your 4-digit PIN
    const secretKey =
        'sk_test_VTJGc2RHVmtYMS9oSndkdDY2V04rN2VTejRxNEc5dFpuWUN2RnNOWlVpeVdZZnpTZTIrRGtTR2dxRDkrRC85ZGRZbUhpQnNxMjB0b1RiUXZ6SGNRL1phZ243ZVVlZVA1eGpubUNJNm1HbzBGTFk5YUJWUFNvdVFiZTNsbExNV3RpczNmWHFTVmIzWDVLdXVkNFdPdXE5OXlIdXlteGtQYk12S0ZRYXcxUXJCa2d0SU1RTnZWcW9JQW5EUDNDaWV1QTVnTnJDV2V3MkprT2xURktWWjZ1SSt0MVg0ak5jZ2ZSWXNUdFdqWDlMbWVHc0dlVGcxVk0yRkV3VUYrZXpCTDFncEJidCt0M2IxYzVtbVk1N2dVMjRZeE5aSlVKQzMyQU8rWHRnbFlMOHZ2bEs2VU9vZzVyUHlWYy9YY01hNnpxbHVjZG1ZYzIvWmtENTVyRGdKRldlbjU2cFlubDdESlJMRjMwejZOMERyUmN4cUczekUvMUJ3NGtyU2dxd0ZweUVWbVR0SHpnYjFMamZrS05saWhrWnV0TWw4Q3JhV2ZZM1FEM2kvQ2ZkWXhnREorMFJRSUg4STlmYkdzWVRBL0VkTTh0TG1iRGw4NHppL0hEeGpXTnpja2JaTUttbC9VQUd1bXNraEFJaE09'; // Replace with your secret key

    // Ensure the secret key is 32 characters for AES-256
    final key = encrypt.Key.fromUtf8(
      secretKey.padRight(32).substring(0, 32),
    );

    // AES requires an Initialization Vector (IV); it's usually random for encryption
    final iv = encrypt.IV.fromLength(16); // Generates a random IV of 16 bytes

    final encrypter = encrypt.Encrypter(
      encrypt.AES(
        key,
      ),
    );

    // Encrypt the PIN
    final encrypted =
        encrypter.encrypt(cardsController.pin.text.toString(), iv: iv);

    // Encrypted value and IV (Base64 encoding for API transmission)

    print('Holder ID: $cardholderId');

    print('Encrypted Value: ${encrypted.base64}');
    print('Initialization Vector (IV): ${iv.base64}');

    final url = Uri.parse(
      'https://issuecards.api.bridgecard.co/v1/issuing/cards/create_card',
    );

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    // numberOfDollars.text =
    //     (double.parse(numberOfDollars.text.toString()) * 100).toString();

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(
          {
            "cardholder_id": cardholderId,
            "card_type": "virtual",
            "card_brand": "Mastercard",
            "card_currency": "USD",
            "card_limit": "500000",
            "transaction_reference": "",
            "funding_amount":
                cardsController.cardAmountInCents.value.toStringAsFixed(0),
            "pin": encryptedPinCardPinValue.value.toString(),
            "meta_data": {"user_id": cardholderId}
          },
        ),
      );

      // // Check the status code
      // Get.snackbar('status code', response.statusCode.toString());
      if (response.statusCode == 201) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          ' Card Created Successfully.',
          backgroundColor: Colors.green,
        );
        FirebaseFirestore.instance
            .collection('mpesaData')
            .doc(mpesaMerchantID.value.toString())
            .update({
          "CardIssued": true,
        });
        if (fAuth.currentUser != null) {
          maincontroller.getCardHolder();
        }
        Get.to(
          () => const TestCustomerCards(),
        );
        // Get.offAll(
        //   () => const DashBoardHomePage(),
        // )!
        //     .then((value) {
        //   if (fAuth.currentUser != null) {
        //     maincontroller.getCardHolder();
        //   }
        // });

        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Create Card.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.amber,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

//  CREATE USD CARD.....
  createNairaCard(String cardholderId) async {
    showLoading("Please Wait...");
    const pin = '1234'; // Replace with your 4-digit PIN
    const secretKey =
        'sk_test_VTJGc2RHVmtYMS9oSndkdDY2V04rN2VTejRxNEc5dFpuWUN2RnNOWlVpeVdZZnpTZTIrRGtTR2dxRDkrRC85ZGRZbUhpQnNxMjB0b1RiUXZ6SGNRL1phZ243ZVVlZVA1eGpubUNJNm1HbzBGTFk5YUJWUFNvdVFiZTNsbExNV3RpczNmWHFTVmIzWDVLdXVkNFdPdXE5OXlIdXlteGtQYk12S0ZRYXcxUXJCa2d0SU1RTnZWcW9JQW5EUDNDaWV1QTVnTnJDV2V3MkprT2xURktWWjZ1SSt0MVg0ak5jZ2ZSWXNUdFdqWDlMbWVHc0dlVGcxVk0yRkV3VUYrZXpCTDFncEJidCt0M2IxYzVtbVk1N2dVMjRZeE5aSlVKQzMyQU8rWHRnbFlMOHZ2bEs2VU9vZzVyUHlWYy9YY01hNnpxbHVjZG1ZYzIvWmtENTVyRGdKRldlbjU2cFlubDdESlJMRjMwejZOMERyUmN4cUczekUvMUJ3NGtyU2dxd0ZweUVWbVR0SHpnYjFMamZrS05saWhrWnV0TWw4Q3JhV2ZZM1FEM2kvQ2ZkWXhnREorMFJRSUg4STlmYkdzWVRBL0VkTTh0TG1iRGw4NHppL0hEeGpXTnpja2JaTUttbC9VQUd1bXNraEFJaE09'; // Replace with your secret key

    // Ensure the secret key is 32 characters for AES-256
    final key = encrypt.Key.fromUtf8(secretKey.padRight(32).substring(0, 32));

    // AES requires an Initialization Vector (IV); it's usually random for encryption
    final iv = encrypt.IV.fromLength(16); // Generates a random IV of 16 bytes

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    // Encrypt the PIN
    final encrypted = encrypter.encrypt(pin, iv: iv);

    // Encrypted value and IV (Base64 encoding for API transmission)

    print('Holder ID: $cardholderId');

    print('Encrypted Value: ${encrypted.base64}');
    print('Initialization Vector (IV): ${iv.base64}');

    final url = Uri.parse(
      'https://issuecards.api.bridgecard.co/v1/issuing/cards/create_card',
    );

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.post(url,
          headers: headers,
          body: jsonEncode(
            {
              "cardholder_id": cardholderId,
              "card_type": "virtual",
              "card_brand": "Mastercard",
              "card_currency": "NGN",
              "pin": encrypted.base64.toString(),
              "nin": "22236748901",
              "meta_data": {"user_id": cardholderId}
            },
          ));

      // Check the status code
      Get.snackbar('status code', response.statusCode.toString());
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          ' Card Created Successfully.',
          backgroundColor: Colors.green,
        );
        // Get.to(
        //   () => const CardsUnderAccountPage(),
        // );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Create Card.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.amber,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

//  UNLOAD  A CARD .....
  unloadCard(String cardID, String amount) async {
    showLoading("Please Wait...");
    var uuid = const Uuid();
    final url = Uri.parse(
      'https://issuecards.api.bridgecard.co/v1/issuing/cards/unload_card_asynchronously',
    );

    final headers = {
      // 'accept': 'application/json',
      'Content-Type': 'application/json',
      'token': // Use "Authorization" instead of "token"
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.patch(
        url,
        headers: headers,
        body: jsonEncode(
          {
            "card_id": cardID,
            "amount": amount,
            "transaction_reference": uuid.v1().toString(),
            "currency": "USD"
          },
        ),
      );

      // // Check the status code
      // Get.snackbar('status code', response.statusCode.toString());
      if (response.statusCode == 202) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        unloadingTranscation.value =
            unloadingTranscationFromJson(response.body);

        Get.snackbar(
          'Success',
          'Card unloading in progress',
          backgroundColor: Colors.green,
        );
        maincontroller.getCardHolder().then((value) {
          cardsController.customerCards.refresh();

          maincontroller.currentTabIndex.value = 1;

          cardsController.amountTranscated.clear();

          Get.offAll(const DashBoardHomePage());
        });
        // Get.to(
        //   () => const CardsUnderAccountPage(),
        // );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Unload Card.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.amber,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

  //  GET ALL CARD TRANSANCTIONS FOR THE SELECTED CARD.
  Future<Map<String, dynamic>> getCardTransactions(String cardID) async {
    // showLoading('Please wait...');
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/get_card_transactions?card_id=$cardID&page=1');

    final headers = {
      'token':
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        cardTransactions.value = cardTransactionsFromJson(response.body);
        cardTransactions.refresh();

        // for (int i = 0; i < cardsUnderAccount.value!.data.cards.length; i++) {
        //    .
        // }

        // Get.snackbar(
        //   'Success',
        //   ' Got Transactions.',
        //   backgroundColor: Colors.green,
        // );

        // Get.to(
        //   () => const TestTransactionsPage(),
        // );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to get card transcations.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

//  FREEZE  SELECTED CARD.
  Future<Map<String, dynamic>> freezeCard(String cardID) async {
    showLoading("Please Wait...");
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/freeze_card?card_id=$cardID');

    final headers = {
      'token':
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http
          .patch(
        url,
        headers: headers,
      )
          .then((value) {
        Get.back();
      });

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        // cardTransactions.value = cardTransactionsFromJson(response.body);
        // cardTransactions.refresh();

        // for (int i = 0; i < cardsUnderAccount.value!.data.cards.length; i++) {
        //    .
        // }

        Get.snackbar(
          'Success',
          ' This card has been frozen successfully.',
          backgroundColor: Colors.green,
        );

        // Get.to(
        //   () => const TestTransactionsPage(),
        // );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Freeze card try again.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

//  UNFREEZE  SELECTED CARD.
  Future<Map<String, dynamic>> unfreezeCard(String cardID) async {
    showLoading("Please Wait...");
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/unfreeze_card?card_id=$cardID');

    final headers = {
      'token':
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.patch(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          ' This card has been Unfrozen successfully.',
          backgroundColor: Colors.green,
        );

        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Unfrozen card try again.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

//  DELETE  SELECTED CARD.
  Future<Map<String, dynamic>> deleteCard(
      String cardID, String cardHolderID) async {
    showLoading("Please Wait...");
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/delete_card/$cardID');

    final headers = {
      'accept': 'application/json',
      'token':
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.delete(
        url,
        headers: headers,
      );
      //     .then((value) {
      //   Get.back();
      // });

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          'Card was deleted Successfully',
          backgroundColor: Colors.green,
        );
        deleteCardHolder(cardHolderID);
        FirebaseFirestore.instance
            .collection('CardHolders')
            .doc(cardHolderID)
            .delete()
            .then((value) {
          cardsController.customerCards.refresh();

          maincontroller.currentTabIndex.value = 1;

          maincontroller.cardholderDB = null;
          // maincontroller.cardCreatedFromHome.value = false;
          maincontroller.shouldCreateCard.value = false;

          maincontroller.refresh();

          Get.offAll(const DashBoardHomePage())!.then((value) {
            Get.back();
          });
        });

        // Get.back();

        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Delete card try again.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

//  DELETE  SELECTED CARDHOLDER.
  Future<Map<String, dynamic>> deleteCardHolder(String cardholderID) async {
    showLoading("Please Wait...");
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cardholder/delete_cardholder/$cardholderID');

    final headers = {
      // 'accept': 'application/json',
      'token':
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.delete(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          'CardHolder was deleted Successfully',
          backgroundColor: Colors.green,
        );

        // Get.back();

        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to Delete card try again.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

  //  GET ALL THE CARDS FOR A SPECIFIC CARDHOLDER THE CARD HOLDER ID IS STORED IN FIREBASE DURING CREATION OF A CARD HOLDER.
  Future<Map<String, dynamic>> getCustomerCards(String cardHolderID) async {
    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/get_all_cardholder_cards?cardholder_id=$cardHolderID');

    final headers = {
      'token':
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        print('888888888888888888888888888888888888');
        print(response.body);
        // response.body.length();
        print('9999999999999999999999999999999999999');
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data.length);
        if (data.length == 3) {
          isCardholderPresentButNoCards.value = true;
        }
        print('9999999999999999999999999999999999999');
        customerCards.value = customerCardsFromJson(response.body);
        customerCards.refresh();
        getCardToken(customerCards.value?.data.cards[0].cardId ?? '');

        // cardsUnderAccount.value = cardsUnderAccountFromJson(response.body);
        // Get.snackbar(
        //   'Success',
        //   ' Yay Your Cards',
        //   backgroundColor: Colors.green,
        // );
        // Get.to(
        //   () => const CardsUnderAccountPage(),
        // );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to get your cards.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }

//  MIGRATE CARD BETWEEN VISA  CARD AND MASTERCARD.
  Future<Map<String, dynamic>> migrateCardFunction(
      String cardHolderID, String cardID, String brand, String cardpin) async {
    // const pin = pin; // Replace with your 4-digit PIN
    const secretKey =
        'sk_test_VTJGc2RHVmtYMS9oSndkdDY2V04rN2VTejRxNEc5dFpuWUN2RnNOWlVpeVdZZnpTZTIrRGtTR2dxRDkrRC85ZGRZbUhpQnNxMjB0b1RiUXZ6SGNRL1phZ243ZVVlZVA1eGpubUNJNm1HbzBGTFk5YUJWUFNvdVFiZTNsbExNV3RpczNmWHFTVmIzWDVLdXVkNFdPdXE5OXlIdXlteGtQYk12S0ZRYXcxUXJCa2d0SU1RTnZWcW9JQW5EUDNDaWV1QTVnTnJDV2V3MkprT2xURktWWjZ1SSt0MVg0ak5jZ2ZSWXNUdFdqWDlMbWVHc0dlVGcxVk0yRkV3VUYrZXpCTDFncEJidCt0M2IxYzVtbVk1N2dVMjRZeE5aSlVKQzMyQU8rWHRnbFlMOHZ2bEs2VU9vZzVyUHlWYy9YY01hNnpxbHVjZG1ZYzIvWmtENTVyRGdKRldlbjU2cFlubDdESlJMRjMwejZOMERyUmN4cUczekUvMUJ3NGtyU2dxd0ZweUVWbVR0SHpnYjFMamZrS05saWhrWnV0TWw4Q3JhV2ZZM1FEM2kvQ2ZkWXhnREorMFJRSUg4STlmYkdzWVRBL0VkTTh0TG1iRGw4NHppL0hEeGpXTnpja2JaTUttbC9VQUd1bXNraEFJaE09'; // Replace with your secret key

    // Ensure the secret key is 32 characters for AES-256
    final key = encrypt.Key.fromUtf8(secretKey.padRight(32).substring(0, 32));

    // AES requires an Initialization Vector (IV); it's usually random for encryption
    final iv = encrypt.IV.fromLength(16); // Generates a random IV of 16 bytes

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    // Encrypt the PIN
    final encrypted = encrypter.encrypt(cardpin, iv: iv);

    // Encrypted value and IV (Base64 encoding for API transmission)

    final url = Uri.parse(
        'https://issuecards.api.bridgecard.co/v1/issuing/cards/migrate_card');

    final headers = {
      'Content-Type': 'application/json',
      'token':
          'Bearer at_live_bb7d01d04bb640df29c07bbeee936bee56591b01420fc4b275e586b5be54e827f968ffc727d23570a3e33695e0df04c69527d81a1977513513de3d7836384d3598048b561067afb402880d687a47b15e2f7df1a297ebc993e9161dd84aefebb891f15e222f1b2e87084a871f656896b9a622a55dd2913515221b035b3a89ec2e3c4bcab8ad06f38471539886e564c695cfa7b46b8dceea908482d216225e85d0a70e93f232b1b05475b9f999139db91fbc8c4d17d3f2bf87fb978c957f42f34ad0be9f021107b751df70ab836a879b866a76e3fd7635ed46ca7f943d2f46e3718c0de782949ccac0e399effe038aa0e0cf407427bfa7b0c1c15d7843d63c262d'
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(
          {
            "cardholder_id": cardHolderID,
            "card_id": cardID,
            "card_type": "virtual",
            "target_card_brand": brand,
            "target_card_currency": "USD",
            "card_limit": "1000000",
            "pin": encrypted.base64.toString(),
          },
        ),
      );

      // Check the status code
      if (response.statusCode == 200) {
        // Decode JSON
        print(response.body);
        final Map<String, dynamic> data = jsonDecode(response.body);
        customerCards.value = customerCardsFromJson(response.body);
        customerCards.refresh();
        getCardToken(customerCards.value?.data.cards[0].cardId ?? '');
        // cardsUnderAccount.value = cardsUnderAccountFromJson(response.body);
        // Get.snackbar(
        //   'Success',
        //   ' Yay Your Cards',
        //   backgroundColor: Colors.green,
        // );
        // Get.to(
        //   () => const CardsUnderAccountPage(),
        // );
        return data;
      } else {
        // Handle other status codes
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          'Error: ${errorData['message'] ?? 'Failed to get your cards.'}',
          backgroundColor: Colors.red,
        );
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (error) {
      // Handle network or other unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $error',
        backgroundColor: Colors.red,
      );
      throw Exception('Unexpected Error: $error');
    }
  }
}
