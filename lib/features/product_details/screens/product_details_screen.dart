import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shopsphere/common/custom_button.dart';
import 'package:shopsphere/common/facilities_regarding_product_widget.dart';
import 'package:shopsphere/common/stars.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/address/screens/address_screen.dart';
import 'package:shopsphere/features/product_details/services/product_details_services.dart';
import 'package:shopsphere/features/search/screens/search_screen.dart';
import 'package:shopsphere/models/product.dart';
import 'package:shopsphere/providers/user_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;
  List images = [
    "data:image/jpeg;base64,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",
    "data:image/jpeg;base64,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"
  ];

  List facilitiesIcon = [
    "assets/icons_png/free-shipping.png",
    "assets/icons_png/cash-on-delivery.png",
    "assets/icons_png/replacement.png",
    "assets/icons_png/warranty.png",
  ];

  List facilitiesText = [
    "Free Delivery",
    "Cash On Delivery",
    "7 Days Replacement",
    "Warranty",
  ];

  bool cartBtnClicked = false;
  bool buyBtnClicked = false;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    if (query.isNotEmpty) {
      Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    }
    // Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() async {
    setState(() {
      cartBtnClicked = true;
    });
    await productDetailsServices.addToCart(
      context: context,
      product: widget.product,
    );
    setState(() {
      cartBtnClicked = false;
    });
  }

  void buy() async {
    setState(() {
      buyBtnClicked = true;
    });
    await productDetailsServices.addToCart(
      context: context,
      product: widget.product,
    );
    setState(() {
      buyBtnClicked = false;
    });
  }

  void navigateToAddress(int sum) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: InkWell(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: false,
          titleSpacing: 0,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         widget.product.id!,
              //       ),
              //       Stars(
              //         rating: avgRating,
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Stars(
                      rating: avgRating,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CarouselSlider(
                    items:
                        // widget.product.images
                        // images
                        widget.product.images.map(
                      (i) {
                        return Builder(
                          builder: (BuildContext context) => Image.network(
                            i,
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        );
                      },
                    ).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 200,
                    ),
                  ),
                ),
              ),
              // Container(
              //   color: Colors.black12,
              //   height: 2,
              // ),

              Container(
                alignment: Alignment.center,
                height: 125,
                margin: const EdgeInsets.symmetric(vertical: 5),
                color: GlobalVariables.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: FacilitiesRegardingProductWidget(
                            text: facilitiesText[index],
                            iconData: facilitiesIcon[index]),
                      );
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: DottedBorder(
                  color: GlobalVariables.darkGrey,
                  strokeWidth: 1,
                  borderType: BorderType.RRect,
                  strokeCap: StrokeCap.round,
                  dashPattern: [4, 4],
                  radius: const Radius.circular(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color: GlobalVariables.greyBackgroundCOlor,
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Deal Price: ',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Rs ${widget.product.price}',
                                      style: const TextStyle(
                                        fontSize: 19,
                                        color: GlobalVariables.green,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 14),
                        child: RichText(
                          text: TextSpan(
                            text: 'Description : ',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '${widget.product.description}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: GlobalVariables.blackThemeColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Text(
                        //   "Description : ${widget.product.description}",
                        //   style: TextStyle(
                        //     fontSize: 15,
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
              ),
              // Container(
              //   color: Colors.black12,
              //   height: 2,
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: CustomButton(
                  loader: buyBtnClicked,
                  loaderColor: GlobalVariables.backgroundColor,
                  text: 'Buy Now',
                  roundness: 10,
                  height: 60,
                  onTap: () {
                    buy();
                    navigateToAddress(widget.product.price.toInt());
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: CustomButton(
                  loader: cartBtnClicked,
                  text: 'Add to Cart',
                  roundness: 10,
                  height: 55,
                  onTap: addToCart,
                  color: const Color.fromRGBO(254, 216, 19, 1),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.black12,
                height: 2,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0, left: 10.0),
                child: Text(
                  'Rate The Product',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RatingBar.builder(
                initialRating: myRating,
                itemSize: 35.0,
                glow: true,
                glowColor: const Color.fromARGB(255, 255, 251, 0),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: GlobalVariables.secondaryColor,
                ),
                onRatingUpdate: (rating) {
                  productDetailsServices.rateProduct(
                    context: context,
                    product: widget.product,
                    rating: rating,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
