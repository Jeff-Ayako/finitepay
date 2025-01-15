import 'package:finitepay/views/authenication/login_page.dart';
import 'package:flutter/material.dart';
// import 'package:shamba_solutions_agent/components/background_layout.dart';

class NoInternetConnectionPage extends StatelessWidget {
  const NoInternetConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: BackgroundPainter(),
              ),
            ),
            const Center(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.signal_wifi_connected_no_internet_4_outlined,
                      size: 200,
                      color: Colors.red,
                    ),
                    Center(
                      child: Text(
                        'No Internet Connection',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
