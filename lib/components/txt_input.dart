import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class TxtInput extends StatelessWidget {
  TxtInput(
      {super.key,
      required this.controller,
      required this.inputName,
      this.ispin,
      this.keyboardType,
      this.inputFormatters,
      this.onchanged
      // this.initialValue,
      });

  TextEditingController controller;
  String inputName;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  // String? initialValue;

  bool? ispin;

  Function(String)? onchanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: onchanged,
        // initialValue: initialValue ?? inputName,
        keyboardType: keyboardType,
        obscureText: ispin ?? false,
        inputFormatters: inputFormatters,
        controller: controller,
        decoration: InputDecoration(
          hintText: inputName,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
