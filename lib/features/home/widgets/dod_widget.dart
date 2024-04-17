import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopsphere/common/stars.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/product_details/screens/product_details_screen.dart';
import 'package:shopsphere/models/product.dart';

// ignore: must_be_immutable
class DodWidget extends StatefulWidget {
  Product product;

  DodWidget({required this.product, super.key});

  @override
  State<DodWidget> createState() => _DodWidgetState();
}

class _DodWidgetState extends State<DodWidget> {
  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }

    return InkWell(
      onTap: navigateToDetailScreen,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DottedBorder(
          color: GlobalVariables.darkGrey,
          strokeWidth: 1,
          borderType: BorderType.RRect,
          strokeCap: StrokeCap.round,
          dashPattern: [4, 4],
          radius: Radius.circular(10),
          child: Column(
            children: [
              Container(
                // height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: GlobalVariables.greyBackgroundCOlor),
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 12,

                        // top: 25,
                      ),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SizedBox(
                        height: 52,
                        child: Lottie.asset(
                          'assets/lottie_animations/dealOfDay_lottie.json',
                        ),
                      ),
                    ),
                  ],
                ),
                // ),
              ),
              Padding(
                padding: EdgeInsets.zero,
                // child: DottedBorder(
                //   color: GlobalVariables.green,
                //   strokeWidth: 1,
                //   borderType: BorderType.RRect,
                //   strokeCap: StrokeCap.round,
                //   dashPattern: [4, 4],
                //   radius: Radius.circular(10),
                child: Material(
                  // color: GlobalVariables.greyBackgroundCOlor,
                  borderRadius: BorderRadius.circular(10),
                  // elevation: 15,
                  shadowColor: GlobalVariables.blackThemeColor,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            // GlobalVariables.sampleProductLink,
                            widget.product.images[0],
                            height: 200,
                            // width: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    // '\$100',
                                    widget.product.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 5, right: 40),
                                  child: Text(
                                    "Rs ${widget.product.price.toString()}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              // width: 235,
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Stars(
                                rating: avgRating,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // ),
              ),

              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: product!.images
              //         .map(
              //           (e) => Image.network(
              //             e,
              //             fit: BoxFit.fitWidth,
              //             width: 100,
              //             height: 100,
              //           ),
              //         )
              //         .toList(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
