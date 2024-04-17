import 'package:flutter/material.dart';
import 'package:shopsphere/common/loader.dart';
import 'package:shopsphere/common/loader4.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/product_details/screens/product_details_screen.dart';
import 'package:shopsphere/features/search/services/search_services.dart';
import 'package:shopsphere/features/search/widget/searched_product.dart';
import 'package:shopsphere/models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    if (query.isNotEmpty) {
      Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    }
    // Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          // automaticallyImplyLeading: false,
          leading: InkWell(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: false,
          titleSpacing: 0,
          flexibleSpace: Container(
            // margin: EdgeInsets.zero,
            decoration: const BoxDecoration(
              color: GlobalVariables.backgroundColor,
            ),
          ),
          title: Container(
            margin: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    margin: const EdgeInsets.only(left: 0),
                    child: Material(
                      borderRadius: BorderRadius.circular(18),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
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
                  padding: const EdgeInsets.only(left: 4, right: 10),
                  child: Material(
                    color: GlobalVariables.greyBackgroundCOlor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      color: Colors.transparent,
                      height: 44,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child:
                          const Icon(Icons.mic, color: Colors.black, size: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: products == null
          ? Center(child: spinkitLoader())
          : Column(
              children: [
                // const AddressBox(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailScreen.routeName,
                            arguments: products![index],
                          );
                        },
                        child: SearchedProduct(
                          product: products![index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
