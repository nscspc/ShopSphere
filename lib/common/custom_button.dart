import 'package:flutter/material.dart';
import 'package:shopsphere/common/loader4.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  bool? loader;
  Color? loaderColor;
  final Color? color;
  double? roundness;
  double? height;
  CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.loader = false,
    this.loaderColor,
    this.roundness = 4,
    this.height = 50,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // ignore: sort_child_properties_last
      child: loader!
          ? loaderColor == null
              ? spinkitLoader()
              : spinkitLoader(
                  color: loaderColor,
                )
          : Text(
              text,
              style: TextStyle(
                color: color == null ? Colors.white : Colors.black,
              ),
            ),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundness!),
        ),
        minimumSize: Size(double.infinity, height!),
        // ignore: deprecated_member_use
        primary: color,
      ),
    );
  }
}
