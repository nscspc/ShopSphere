import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shopsphere/common/loader.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/home/services/home_services.dart';
import 'package:shopsphere/features/product_details/screens/product_details_screen.dart';
import 'package:shopsphere/models/product.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          titleSpacing: 0,
          leading: InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: GlobalVariables.darkblackThemeColor,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : productList!.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 100,
                          child: Lottie.asset(
                            'assets/lottie_animations/emptysearch_lottie.json',
                          ),
                        ),
                      ),
                      Text(
                        'Sorry , No products availabe in ${widget.category} !',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: GoogleFonts.darkerGrotesque().fontFamily,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Keep shopping for ${widget.category}',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: GoogleFonts.darkerGrotesque().fontFamily,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 280,
                      child: GridView.builder(
                        // builder() is used when we do not know the itemcount(keep changing or dynamic), so that it can build according to the demand.
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 15),
                        itemCount: productList!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.4,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final product = productList![index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductDetailScreen.routeName,
                                arguments: product,
                              );
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    // height: 200,
                                    child: DottedBorder(
                                      color: GlobalVariables.blackThemeColor,
                                      strokeWidth: 1.5,
                                      borderType: BorderType.RRect,
                                      strokeCap: StrokeCap.round,
                                      dashPattern: [1, 1],
                                      radius: Radius.circular(10),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 0,
                                              vertical: 0,
                                            ),
                                            child: SizedBox(
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                elevation: 10,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    product.images[0],
                                                    height: 140,
                                                    fit: BoxFit.contain,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Expanded(
                                                //   child:
                                                Text(
                                                  product.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  // maxLines: 2,
                                                ),
                                                // ),
                                                // IconButton(
                                                //   onPressed: () =>
                                                //       deleteProduct(productData, index),
                                                //   icon: const Icon(
                                                //     Icons.delete_outline,
                                                //     size: 20,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   alignment: Alignment.topLeft,
                                //   padding: const EdgeInsets.only(
                                //     left: 0,
                                //     top: 5,
                                //     right: 15,
                                //   ),
                                //   child: Text(
                                //     product.name,
                                //     maxLines: 1,
                                //     overflow: TextOverflow.ellipsis,
                                //   ),
                                // ),
                              ],
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
