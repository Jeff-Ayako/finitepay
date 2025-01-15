import 'dart:math';
import 'dart:ui';

import 'package:confetti/confetti.dart';
import 'package:get/get.dart';

class SuccessController extends GetxController {
  late ConfettiController controllerCenter;
  late ConfettiController controllerCenterRight;
  late ConfettiController controllerCenterLeft;
  late ConfettiController controllerTopCenter;
  late ConfettiController controllerBottomCenter;

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  void onInit() {
    controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 10));
    controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 10));
    controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    super.onInit();
  }

  @override
  void onClose() {
    controllerCenter.dispose();
    controllerCenterRight.dispose();
    controllerCenterLeft.dispose();
    controllerTopCenter.dispose();
    controllerBottomCenter.dispose();

    super.onClose();
  }
}
