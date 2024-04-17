import 'package:flutter/material.dart';
import 'package:shopsphere/common/loader4.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final bool? loader;
  Color? loaderColor;
  final bool? widthInfinity;
  RoundedButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.loader = false,
    this.loaderColor,
    this.widthInfinity = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
          borderRadius: BorderRadius.circular(25),
        ),
        minimumSize: Size(widthInfinity! ? double.infinity : 200, 60),
        // maximumSize: const Size(double.infinity / 2, 65),
        primary: color,
      ),
    );
  }
}
