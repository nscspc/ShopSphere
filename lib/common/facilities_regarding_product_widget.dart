import 'package:flutter/material.dart';
import 'package:shopsphere/constants/global_variables.dart';

class FacilitiesRegardingProductWidget extends StatelessWidget {
  final String iconData;
  final String text;
  const FacilitiesRegardingProductWidget({
    Key? key,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 68,
      child: Material(
        color: GlobalVariables.backgroundColor,
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: GlobalVariables.greyBackgroundCOlor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    iconData,
                    // width: 40,
                    // height: 40,
                  ),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                text,
                style: TextStyle(
                  color: GlobalVariables.blackThemeColor,
                  fontSize: 11.5,

                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
