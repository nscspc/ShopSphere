import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopsphere/constants/global_variables.dart';

class spinkitLoader extends StatelessWidget {
  Color? color;
  spinkitLoader({this.color = GlobalVariables.darkblackThemeColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      child: SpinKitCircle(
        color: color,
        size: 45.0,
        // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
      ),
    );
  }
}

// final spinkit = SpinKitSquareCircle(
//   color: Colors.white,
//   size: 50.0,
//   controller: AnimationController(
//       vsync: this, duration: const Duration(milliseconds: 1200)),
// );
