import 'package:finitepay/controllers/accounts_controllers/usd_euro_controller.dart';
import 'package:finitepay/controllers/authentication_controller.dart';
import 'package:finitepay/controllers/business_accounts/business_accounts_controller.dart';
import 'package:finitepay/controllers/cards_controller.dart';
import 'package:finitepay/controllers/create_beneficiary_controller.dart';
import 'package:finitepay/controllers/currency_cloud_api_requests.dart';
import 'package:finitepay/controllers/cybersource/payments_controller.dart';
import 'package:finitepay/controllers/fx_controller.dart';
import 'package:finitepay/controllers/kyc_controller.dart';
import 'package:finitepay/controllers/main_controller.dart';
import 'package:finitepay/controllers/network_controller.dart';
import 'package:finitepay/controllers/sub_accounts/sub_account_controller.dart';
import 'package:finitepay/controllers/success_controller.dart';
// import 'package:finitepay/sub_accounts/sub_account_controller.dart';
import 'package:get/get.dart';
import 'package:finitepay/controllers/sign_up_controller.dart';
// import 'package:stream_lunar/controllers/sign_up_controller.dart';

SignUpController signUpController = Get.put(SignUpController());
BusinessAccountsController businessAccountsController =
    Get.put(BusinessAccountsController());

UsdEuroController usdEuroController = Get.put(UsdEuroController());

Maincontroller maincontroller = Get.put(Maincontroller());
KycController kycController = Get.put(KycController());

CardsController cardsController = Get.put(CardsController());
SubAccountController subAccountController = Get.put(SubAccountController());

CybersourceController cybersourceController = Get.put(CybersourceController());

CreateBeneficiaryController createBeneficiaryController =
    Get.put(CreateBeneficiaryController());

SuccessController successController = Get.put(SuccessController());

CurrencyCloudController currencyCloudController =
    Get.put(CurrencyCloudController());

FxController fxController = Get.put(FxController());

ConnectivityService connectivityService = Get.put(ConnectivityService());
AuthenticationController authenticationController = Get.put(
  AuthenticationController(),
);
