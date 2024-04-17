import 'package:flutter/material.dart';
import 'package:shopsphere/SplashScreen.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/auth/services/auth_service.dart';
import 'package:shopsphere/providers/user_provider.dart';
import 'package:shopsphere/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  final AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    authService.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopSphere',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // background color of screen
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,

          // color appbar and buttons
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.blackThemeColor,
          ),

          // for keeping elevation of appbar zero and icons of black color
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          )
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          ),
      onGenerateRoute: (settings) => generateRoute(
        settings,
      ), // as it is needed to mention all the routes in main file so we can access the routes that we have mentioned in generateRoute() method in router.dart file by using onGenerateRoute property.
      home: const SplashScreen(),
      // Provider.of<UserProvider>(context).user.token.isNotEmpty
      //     ? Provider.of<UserProvider>(context).user.type == 'user'
      //         ? const AnimatedBottomBar()
      //         : const AdminScreen()
      //     : const AuthScreen(),

      // const AuthScreen(),

      /*
      Scaffold(
          appBar: AppBar(title: const Text("Amazon Clone")),
          body: Column(
            children: [
              const Center(
                child: Text('Flutter Demo Home Page'),
              ),
              Builder(builder: (context) {
                // if Builder is not used then this exception will be thrown :-
                /*
                => Navigator operation requested with a context that does not include a Navigator.
                   The context used to push or pop routes from the Navigator must be that of a widget that is a
                   descendant of a Navigator widget.
                */
                return ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AuthScreen.routeName);
                  },
                  child: Text("Button"),
                );
              })
            ],
          ),),
          */
    );
  }
}
