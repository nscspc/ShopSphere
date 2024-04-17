import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shopsphere/common/stars.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/models/product.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DottedBorder(
            color: GlobalVariables.blackThemeColor,
            strokeWidth: 1.5,
            borderType: BorderType.RRect,
            strokeCap: StrokeCap.round,
            dashPattern: [1, 1],
            radius: Radius.circular(10),
            child: Container(
              // margin: const EdgeInsets.symmetric(
              //   horizontal: 10,
              // ),
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
                          product.images[0],
                          // "data:image/jpeg;base64,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",
                          fit: BoxFit.contain,
                          height: 130,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          product.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        // width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Stars(
                          rating: avgRating,
                        ),
                      ),
                      Container(
                        // width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          'Rs ${product.price}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        // width: 235,
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text('Eligible for FREE Shipping'),
                      ),
                      Container(
                        // width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: const Text(
                          'In Stock',
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
