// Flutter imports:
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Color color;
  final onPressed;

  const Button({
    required this.onPressed,
    required this.color,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 15),
      height: 70,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: color,
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
      ),
    );
  }
}

class ThemeHelper {
  BoxDecoration buttonBoxDecoration(
      BuildContext context, Color color1, Color color2) {
    Color c1 = color1;
    Color c2 = color2;

    return BoxDecoration(
      border: Border.all(
        color: c2,
      ),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.0, 1.0],
        colors: [
          c1,
          c1,
        ],
      ),
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    );
  }

  BoxDecoration buttonBoxDecoration1(
      BuildContext context, Color color1, Color color2) {
    Color c1 = color1;
    Color c2 = color2;

    return BoxDecoration(
      border: Border.all(
        color: c2,
      ),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.0, 1.0],
        colors: [
          c1,
          c1,
        ],
      ),
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    );
  }
}
