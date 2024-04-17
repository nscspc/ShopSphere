import 'package:flutter/material.dart';
import 'package:shopsphere/models/product.dart';

class SingleProductAdmin extends StatelessWidget {
  // final String image;
  Product product;
  // final Order orderOverview;
  SingleProductAdmin({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      // padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child:
            // Row(
            //   children: [
            Column(
          children: [
            Expanded(
              child: Container(
                // width: 180,
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.images[0],
                    // height: 160,
                    fit: BoxFit.cover,
                    // width: 180,
                  ),
                ),
              ),
            ),
            Text(
              product.name,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
        //   ],
        // ),
      ),
    );
  }
}
