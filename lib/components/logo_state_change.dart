// ignore_for_file: must_be_immutable

// Flutter imports:
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:flutter/material.dart';

// Project imports:

class LogoStateChange extends StatelessWidget {
  LogoStateChange({super.key, this.height});
  double? height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authenticationController.getmode(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Image(
            color: const Color.fromARGB(255, 103, 6, 121),
            // color: snapshot.data ? Colors.red : null,
            alignment: Alignment.center,
            height: height ?? 100.0,
            image: snapshot.data
                ? const AssetImage(
                    "assets/fwhitelogo.png",
                  )
                : const AssetImage("assets/fwhitelogo.png"),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class HomeLogoStates extends StatelessWidget {
  const HomeLogoStates({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authenticationController.getmode(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Image(
            alignment: Alignment.center,
            height: 100.0,
            color: const Color.fromARGB(255, 103, 6, 121),
            image: snapshot.data
                ? const AssetImage(
                    "assets/fwhitelogo.png",
                  )
                : const AssetImage("assets/fwhitelogo.png"),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
