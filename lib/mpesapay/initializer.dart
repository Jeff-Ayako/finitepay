// import 'package:fixplum/mpesapay/api_caller.dart';
import 'package:finitepay/mpesapay/api_caller.dart';
import 'package:intl/intl.dart';
// import 'package:mpesa_integration/mpesapay/api_caller.dart';

class MpesaPlugin {
  static Future<dynamic> initializeMpesaSTKPush({
    required double amount,
    required String phone,
  }) async {
    var rawTimeStamp = DateTime.now();
    var formatter = DateFormat('yyyyMMddHHmmss');
    String actualTimeStamp = formatter.format(rawTimeStamp);

    return RequestHandle().mSTKRequest(
      amount: amount,
      phone: phone,
      mTimeStamp: actualTimeStamp,
    );
  }
}
