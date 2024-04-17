import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shopsphere/common/loader.dart';
import 'package:shopsphere/common/loader4.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/admin/screens/add_product_screen.dart';
import 'package:shopsphere/features/admin/services/admin_services.dart';
import 'package:shopsphere/models/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>?
      products; // we have used ? , so that we can check that if products list == null , means that the user has not added any product to be shown, and if products is empty(products.isEmpty()) , which means that the fetched products list will be equal to [].
  final AdminServices adminServices = AdminServices();
  bool deleteBtnClicked = false;

  @override
  void initState() {
    // initState() function can never be async.
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    // ignore: avoid_print
    print(products.toString());
    setState(() {});
  }

  void deleteProduct(Product product, int index) async {
    setState(() {
      deleteBtnClicked = true;
    });
    await adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
    setState(() {
      deleteBtnClicked = false;
    });
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Center(
            child: spinkitLoader(),
          )
        : Scaffold(
            body:
                // Text(""),
                GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // to show 2 items in a row in grid.
              ),
              itemBuilder: (context, index) {
                final productData = products![index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    // height: 300,
                    child: DottedBorder(
                      color: GlobalVariables.blackThemeColor,
                      strokeWidth: 1.5,
                      borderType: BorderType.RRect,
                      strokeCap: StrokeCap.round,
                      dashPattern: const [1, 1],
                      radius: const Radius.circular(10),
                      child: SizedBox(
                        // height: 400,
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 0,
                                ),
                                child: SizedBox(
                                  height: 300,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    elevation: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        productData.images[0],
                                        height: 150,
                                        fit: BoxFit.contain,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Expanded(
                                  //   child:
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      productData.name,
                                      overflow: TextOverflow.ellipsis,
                                      // maxLines: 2,
                                    ),
                                  ),
                                  // ),
                                  // deleteBtnClicked
                                  //     ? spinkitLoader()
                                  //     :
                                  IconButton(
                                    onPressed: () =>
                                        deleteProduct(productData, index),
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // deleteBtnClicked
                            //     ? Container(
                            //         child: spinkitLoader(),
                            //       )
                            //     : Container()
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddProduct,
              tooltip:
                  'Add a Product', // it will appear when user is going to hover or long press on the floatingActionButton.
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
