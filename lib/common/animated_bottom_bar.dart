import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopsphere/features/account/screens/account_screen.dart';
import 'package:shopsphere/features/cart/screens/cart_screen.dart';
import 'package:shopsphere/features/home/screens/home_screen.dart';
import 'package:shopsphere/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AnimatedBottomBar extends StatefulWidget {
  static const String routeName = '/animated-home-bottombar';
  const AnimatedBottomBar({Key? key}) : super(key: key);

  @override
  State<AnimatedBottomBar> createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    // const Center(
    //   child: Text("page 1"),
    // ),

    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
    // const Center(
    //   child: Text("page 3"),
    // ),
  ];

  List<IconData> iconList = [
    Icons.home_outlined,
    Icons.person_outline_outlined,
    Icons.shopping_cart_outlined,
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        backgroundColor: Colors.transparent,
        // buttonBackgroundColor: GlobalVariables.secondaryColor,
        color: GlobalVariables.darkblackThemeColor,
        // animationCurve: Curves.slowMiddle,
        onTap: updatePage,
        items: [
          const Icon(
            Icons.home_outlined,
            color: GlobalVariables.backgroundColor,
          ),
          const Icon(
            Icons.person_outline_outlined,
            color: GlobalVariables.backgroundColor,
          ),
          badges.Badge(
            elevation: 0,
            badgeContent: Text(userCartLen.toString()),
            badgeColor: Colors.white,
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: GlobalVariables.backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
