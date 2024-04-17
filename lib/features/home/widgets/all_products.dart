import 'package:flutter/material.dart';
import 'package:shopsphere/common/loader4.dart';
import 'package:shopsphere/features/home/services/home_services.dart';
import 'package:shopsphere/features/home/widgets/product_widget.dart';
import 'package:shopsphere/features/product_details/screens/product_details_screen.dart';
import 'package:shopsphere/models/product.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<Product>? products; // ? is used to check that it is null or empty.
  final HomeServices homeServices = HomeServices();
  Product? dealOfDayProduct;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    products = await homeServices.fetchAllProducts(context: context);
    dealOfDayProduct = await homeServices.fetchDealOfDay(context: context);

    print("all products");
    print(products!.length);
    setState(() {});
  }

  void navigateToDetailScreen(Product product) {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? spinkitLoader() //Loader()
        // : products!.length == 0
        //     ? const SizedBox()
        :
        // Expanded(
        //     child:
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return products![index].id != dealOfDayProduct!.id
                  ? InkWell(
                      onTap: () {
                        navigateToDetailScreen(
                          products![index],
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Padding(
                          padding: EdgeInsets.zero,

                          child: ProductWidget(
                            product: products![index],
                          ),
                          // ),
                        ),
                      ),
                    )
                  : Container();
            },
            // ),
          );
  }
}
