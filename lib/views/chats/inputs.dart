// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

class Inputs extends StatelessWidget {
  Inputs({super.key, required this.hint, this.controller, this.Icon});
  String hint;
  TextEditingController? controller;

  Widget? Icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 5,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Theme.of(context).cardColor,
        border: const OutlineInputBorder(),
        focusColor: const Color.fromARGB(255, 2, 73, 4),
        hintText: hint,
        suffixIcon: Icon,
      ),
    );
  }
}
