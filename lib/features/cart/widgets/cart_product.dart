import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/cart/services/cart_services.dart';
import 'package:shopsphere/features/product_details/services/product_details_services.dart';
import 'package:shopsphere/models/product.dart';
import 'package:shopsphere/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  // it is StatefulWidget because we are going to inc and dec the product so the state needs to change.
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(
      context: context,
      product: product,
    );
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context
        .watch<UserProvider>()
        .user
        .cart[widget.index]; // it contains Product and Quantity.
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];

    return Column(
      children: [
        // Container(
        //   margin: const EdgeInsets.symmetric(
        //     horizontal: 0,
        //   ),

        //   child:
        Padding(
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
                          product.images[0],
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
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        // width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          'Rs ${product.price}',
                          style: const TextStyle(
                            fontSize: 20,
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
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => decreaseQuantity(product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(
                          quantity.toString(),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => increaseQuantity(product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
