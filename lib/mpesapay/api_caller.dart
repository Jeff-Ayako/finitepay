import 'package:cloud_functions/cloud_functions.dart';

class RequestHandle {
  final functions = FirebaseFunctions.instance;

  RequestHandle();
  Future<Map<String, String>> mSTKRequest({
    required double amount,
    required String phone,
    required String mTimeStamp,
  }) async {
    HttpsCallable callable = functions.httpsCallable('mpesaFunPay');
    final resp = await callable.call(<String, dynamic>{
      "amount": amount,
      "phone": phone,
      "email":
          "jeffayako1@gmail.com", //user!.email!, ensure the one paying is loged in and take their email. you need it for saving transaction
      "timeStamp": mTimeStamp,
    });

    final Map<String, String> result = <String, String>{};
    result["result"] = resp.data;
    return result;
  }
}
