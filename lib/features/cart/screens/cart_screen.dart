import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shopsphere/common/custom_button.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/address/screens/address_screen.dart';
import 'package:shopsphere/features/cart/widgets/cart_product.dart';
import 'package:shopsphere/features/cart/widgets/cart_subtotal.dart';
import 'package:shopsphere/features/search/screens/search_screen.dart';
import 'package:shopsphere/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddress(int sum) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: GlobalVariables.darkblackThemeColor,
            ),
          ),
          title: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: GlobalVariables.darkblackThemeColor,
            ),
            child: Center(
              // alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 9.0),
                    child: Text(
                      "Cart",
                      style: TextStyle(
                        fontFamily: GoogleFonts.aclonica()
                            .
                            // textStyle: TextStyle(
                            //   letterSpacing: 105,
                            // ),
                            // ).
                            fontFamily,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    child: Lottie.asset(
                      'assets/lottie_animations/cart_lottie.json',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // const AddressBox(),
              const CartSubtotal(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: 'Proceed to Buy (${user.cart.length} items)',
                  onTap: () => navigateToAddress(sum),
                  roundness: 10,
                  color: Colors.yellow[600],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                color: Colors.black12.withOpacity(0.08),
                height: 1,
              ),
              const SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    child: CartProduct(
                      index: index,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
