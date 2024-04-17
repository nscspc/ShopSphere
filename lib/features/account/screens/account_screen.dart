import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/account/widgets/below_app_bar.dart';
import 'package:shopsphere/features/account/widgets/orders.dart';
import 'package:shopsphere/features/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            // we have used here flexibleSpace to use gradient in appbar.
            decoration: const BoxDecoration(
              color: GlobalVariables.darkblackThemeColor,
            ),
          ),
          title:
              // Container(
              //   padding: EdgeInsets.all(15),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(14),
              //     color: GlobalVariables.darkblackThemeColor,
              //   ),
              //   child:
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Center(
              // alignment: Alignment.center,
              // child:
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 5),
                child: Text(
                  "ShopSphere",
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: GoogleFonts.laila(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, letterSpacing: 2))
                        .fontFamily,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 5),
                child: SizedBox(
                  height: 60,
                  // width: 65,
                  child: Lottie.asset(
                      'assets/lottie_animations/shoppingbag_lottie.json'),
                ),
              ),
            ],
            // Image(
            //   image: AssetImage('assets/images/amazon_in.png'),
            //   width: 120,
            //   height: 45,
            //   color: Colors.black,
            // ),
          ),
          // Container(
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: Row(
          //     children: const [
          //       Padding(
          //         padding: EdgeInsets.only(right: 15),
          //         child: Icon(Icons.notifications_outlined),
          //       ),
          //       Icon(
          //         Icons.search,
          //       ),
          //     ],
          //   ),
          // )
          //   ],
          // ),
        ),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 8.0,
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            BelowAppBar(),
            SizedBox(height: 10),
            TopButtons(),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(
                left: 0,
              ),
              child: Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Orders(),
          ],
        ),
      ),
    );
  }
}
