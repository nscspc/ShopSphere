import 'package:flutter/material.dart';
import 'package:shopsphere/common/animated_bottom_bar.dart';
import 'package:shopsphere/common/bottom_bar.dart';
import 'package:shopsphere/features/address/screens/address_screen.dart';
import 'package:shopsphere/features/admin/screens/add_product_screen.dart';
import 'package:shopsphere/features/admin/screens/admin_screen.dart';
import 'package:shopsphere/features/auth/screens/auth_screen.dart';
import 'package:shopsphere/features/home/screens/category_deals_screen.dart';
import 'package:shopsphere/features/home/screens/home_screen.dart';
import 'package:shopsphere/features/order_details/screens/order_details.dart';
import 'package:shopsphere/features/product_details/screens/product_details_screen.dart';
import 'package:shopsphere/features/search/screens/search_screen.dart';
import 'package:shopsphere/models/order.dart';
import 'package:shopsphere/models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings
      .name) // routeSettings.name is the name of the route that we specify in pushNamed statment to navigate to the screen.
  {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    case AnimatedBottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AnimatedBottomBar(),
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );

    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );

    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist'),
          ),
        ),
      );
  }
}
