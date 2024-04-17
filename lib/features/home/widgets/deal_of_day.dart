import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopsphere/common/loader4.dart';
import 'package:shopsphere/common/stars.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/home/services/home_services.dart';
import 'package:shopsphere/features/home/widgets/dod_widget.dart';
import 'package:shopsphere/features/product_details/screens/product_details_screen.dart';
import 'package:shopsphere/models/product.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product; // ? is used to check that it is null or empty.
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    print("deal of the day");
    print(product!.name);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    // double totalRating = 0;
    // double avgRating = 0;
    // if (product != null) {
    //   if (product!.name.isEmpty) {
    //     for (int i = 0; i < product!.rating!.length; i++) {
    //       totalRating += product!.rating![i].rating;
    //     }

    //     if (totalRating != 0) {
    //       avgRating = totalRating / product!.rating!.length;
    //     }
    //   }
    //   setState(() {});
    // }

    return product == null
        ? Padding(
            padding: EdgeInsets.only(top: 150.0, bottom: 150.0),
            child: spinkitLoader(),
          ) //Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : DodWidget(product: product!);
  }
}
