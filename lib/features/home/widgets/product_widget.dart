import 'package:flutter/material.dart';
import 'package:shopsphere/common/stars.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/models/product.dart';

// ignore: must_be_immutable
class ProductWidget extends StatefulWidget {
  Product product;

  ProductWidget({required this.product, super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
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

    return Material(
      // color: GlobalVariables.greyBackgroundCOlor,
      borderRadius: BorderRadius.circular(10),

      elevation: 8,
      // shadowColor: GlobalVariables.blackThemeColor,
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
                      padding: const EdgeInsets.only(left: 15, top: 5),
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
    );
  }
}
