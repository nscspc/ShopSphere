import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopsphere/constants/global_variables.dart';

import 'analtyics_screen.dart';
import 'orders_screen.dart';
import 'posts_screen.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/actual-admin';
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const PostsScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(), //OrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: GlobalVariables.darkblackThemeColor,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ShopSphere',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.laila(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 2))
                      .fontFamily,
                  fontSize: 22,
                ),
              ),
              const Text(
                'Seller',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        backgroundColor: GlobalVariables.backgroundColor,
        color: GlobalVariables.darkblackThemeColor,
        onTap: updatePage,
        items: [
          // Home
          const Icon(
            Icons.home_outlined,
            color: GlobalVariables.backgroundColor,
          ),

          // Analytics
          const Icon(
            Icons.analytics_outlined,
            color: GlobalVariables.backgroundColor,
          ),

          // Orders
          const Icon(
            Icons.all_inbox_outlined,
            color: GlobalVariables.backgroundColor,
          ),
          // ),
          // label: '',
          // ),
        ],
      ),
    );
  }
}
