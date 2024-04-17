import 'package:flutter/material.dart';
import 'package:shopsphere/constants/global_variables.dart';

class CustomGreyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomGreyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1, // by default maxLines will be 1.
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: GlobalVariables.greyBackgroundCOlor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black38,
              ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
