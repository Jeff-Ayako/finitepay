import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Btn extends StatelessWidget {
  Btn(
      {super.key,
      required this.txtColor,
      required this.ontap,
      required this.btnName,
      required this.color});

  void Function()? ontap;
  Color color;

  String btnName;

  Color txtColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: .3,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                btnName,
                style: TextStyle(color: txtColor),
              ),
              Icon(Icons.arrow_forward, color: txtColor),
            ],
          ),
        ),
      ),
    );
  }
}
