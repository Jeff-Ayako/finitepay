// import 'package:finitepay/bridgecards_test/create_usd_euro_accounts.dart';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:finitepay/firebase_options.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:finitepay/modes/dark.dart';
import 'package:finitepay/modes/lightmode.dart';
import 'package:finitepay/views/authenication/login_page.dart';
import 'package:finitepay/views/home/dashboard_page.dart';
import 'package:finitepay/views/internet/no_connection.dart';
// import 'package:finitepay/views/test_counter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mpesa_package/flutter_mpesa_services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

const darkModeBox = 'darkModeTutorial';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notification',
  description: "High Importance Notification description",
  importance: Importance.high,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterMpesa.initFlutterMpesa(
    consumerKey: "WQmCj12yj0IaTIJT9GLpBPnHtIv9gCJXxe9OpNrCV5QL7IAO",
    consumerSecret:
        "81T1ybrLnORYkf1un8Q198QHAwa5FX9J103Rcs3WC3pmvROAMXZh8kwwGI1jEjIT",
    securityCredential: "",
  );

  if (kIsWeb == false) {
    MpesaFlutterPlugin.setConsumerKey(
        'WQmCj12yj0IaTIJT9GLpBPnHtIv9gCJXxe9OpNrCV5QL7IAO');
    MpesaFlutterPlugin.setConsumerSecret(
        '81T1ybrLnORYkf1un8Q198QHAwa5FX9J103Rcs3WC3pmvROAMXZh8kwwGI1jEjIT');
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox(darkModeBox);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(darkModeBox).listenable(),
      builder: (BuildContext context, value, Widget? child) {
        print(
          value.get(
            'NationalID',
            defaultValue: '',
          ),
        );
        var darkMode = value.get('darkMode', defaultValue: false);
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: value.get(
              'darkMode',
              defaultValue: false,
            )
                ? Colors.transparent
                : Colors.transparent,
          ),
        );
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FinitePay',
          theme: darkMode ? darkmode : lightmode,
          home: //TestCounterPage() //const BridgeCardPageTest()
              //const CardPaymentPage() //const BeforePay(), //const UpgradeCardholderScreen()
              //const BeforePay() //const TestPageTrigger() //const VirtualCardScreen()
              // const NoCardAvailablePage() // const MasterCardDesktopPage() // const BridgeCardPageTest()
              // CreateCardHolderPage(
              //   country: 'Kenya',
              // ) //const UserCountryPage(),
              //); //const BridgeCardPageTest());
              //const CreateCardHolderPage() //const BridgeCardPageTest() //const SingleCardDetailsPage()
              // const CreateCardHolderPage() //const BridgeCardPageTest() //const PyhomeTest() //const UploadDocsPage()
              //const SocialsDetailsPage() //const Shareholb dersPage() //BizOverviewPage(size: 500)

              connectivityService.isConnected.value
                  ? fAuth.currentUser == null
                      ? const LoginPage()
                      : const DashBoardHomePage()
                  : const NoInternetConnectionPage(),
        );
      },
    );
  }
}
