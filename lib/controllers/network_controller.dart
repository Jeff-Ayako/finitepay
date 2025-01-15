import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService extends GetxService {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _listenToConnectivityChanges();
  }

  void _checkInitialConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = _updateConnectionStatus(connectivityResult.last);
  }

  void _listenToConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((connectivityResult) {
      isConnected.value = _updateConnectionStatus(connectivityResult.last);
    });
  }

  bool _updateConnectionStatus(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
  }
}
