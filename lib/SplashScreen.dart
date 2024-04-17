import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/auth/screens/auth_screen.dart';
import 'package:shopsphere/features/auth/services/auth_service.dart';
import 'package:shopsphere/providers/user_provider.dart';

import 'common/animated_bottom_bar.dart';
import 'features/admin/screens/admin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();

  navigateToNextScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Provider.of<UserProvider>(context, listen: false).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context, listen: false).user.type ==
                  'user'
              ? AnimatedBottomBar.routeName
              : AdminScreen.routeName
          : AuthScreen.routeName,
      (route) => false,
    );
  }

  @override
  void initState() {
    authService.getUserData(context);

    Timer(const Duration(seconds: 3), () {
      navigateToNextScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 0),
              child: Text(
                "ShopSphere",
                style: TextStyle(
                  fontFamily: GoogleFonts.laila(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 2))
                      .fontFamily,
                  fontWeight: FontWeight.bold,
                  color: GlobalVariables.darkblackThemeColor,
                  fontSize: 27,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: SizedBox(
                height: 150,
                width: 150,
                child:
                    Lottie.asset('assets/lottie_animations/splash_lottie.json'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
