import 'package:flutter/material.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/home/widgets/all_products.dart';
import 'package:shopsphere/features/home/widgets/carousel_image.dart';
import 'package:shopsphere/features/home/widgets/deal_of_day.dart';
import 'package:shopsphere/features/home/widgets/top_categories.dart';
import 'package:shopsphere/features/search/screens/search_screen.dart';
import 'package:shopsphere/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showAllProducts = false;

  void navigateToSearchScreen(String query) {
    if (query.isNotEmpty) {
      Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: GlobalVariables.backgroundColor,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.only(left: 8),
                  child: Material(
                    borderRadius: BorderRadius.circular(18),
                    // elevation: 10,
                    color: GlobalVariables.greyBackgroundCOlor,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          // InkWell is used because when we click on it , it gives a splash effect.
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: GlobalVariables.greyBackgroundCOlor,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          borderSide: BorderSide(
                            color: GlobalVariables.greyBackgroundCOlor,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Material(
                  color: GlobalVariables.greyBackgroundCOlor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    color: Colors.transparent,
                    height: 44,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: const Icon(Icons.mic, color: Colors.black, size: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const TopCategories(),
            const SizedBox(height: 10),
            const CarouselImage(),
            const DealOfDay(),
            InkWell(
              onTap: () {
                setState(() {
                  showAllProducts = !showAllProducts;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                // margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.only(left: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: GlobalVariables.darkblackThemeColor,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Explore more product',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.teal,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                    showAllProducts
                        ? const Icon(Icons.keyboard_arrow_up_rounded)
                        : const Icon(Icons.keyboard_arrow_down_rounded)
                  ],
                ),
              ),
            ),
            showAllProducts
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: AllProducts(),
                  )
                : Container(),
            // Text("------------")
          ],
        ),
      ),
    );
  }
}
