import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/models/order.dart';

class SingleProduct extends StatelessWidget {
  // final String image;
  final Order orderOverview;
  const SingleProduct({
    Key? key,
    required this.orderOverview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: DottedBorder(
        color: GlobalVariables.blackThemeColor,
        strokeWidth: 1.5,
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        dashPattern: [1, 1],
        radius: Radius.circular(10),
        child: Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      orderOverview.products[0].images[0],
                      // GlobalVariables.sampleProductLink,
                      fit: BoxFit.cover,
                      height: 125,
                      width: 140,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // width: 235,
                    // alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      orderOverview.products[0].name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    // width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'Rs ${orderOverview.products[0].price}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      color: GlobalVariables.greyBackgroundCOlor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 15.0),
                        child: Text(
                          'Qty: ${orderOverview.quantity[0]}',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 5),
    //   child: DecoratedBox(
    //     decoration: BoxDecoration(
    //       border: Border.all(
    //         color: Colors.black12,
    //         width: 1.5,
    //       ),
    //       borderRadius: BorderRadius.circular(5),
    //       color: Colors.white,
    //     ),
    //     child: Row(
    //       children: [
    //         Container(
    //           width: 180,
    //           padding: const EdgeInsets.all(10),
    //           child: Image.network(
    //             image,
    //             height: 160,
    //             fit: BoxFit.cover,
    //             // width: 180,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
