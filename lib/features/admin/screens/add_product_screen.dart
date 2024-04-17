import 'dart:io';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shopsphere/common/custom_button.dart';
import 'package:shopsphere/common/custom_grey_textfield.dart';
import 'package:shopsphere/common/custom_textfield.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/constants/utils.dart';
import 'package:shopsphere/features/admin/services/admin_services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  bool sellBtnClicked = false;

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void sellProduct() async {
    setState(() {
      sellBtnClicked = true;
    });
    if (_addProductFormKey.currentState!.validate()) {
      // &&
      // images.isNotEmpty
      // ) {
      await adminServices.sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        images: images,
      );
    }
    setState(() {
      sellBtnClicked = false;
    });
  }

  void selectImages() async {
    // var res = await pickImagesInBytes();
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          titleSpacing: 0,
          leading: InkWell(
            child: const Padding(
              padding: EdgeInsets.only(left: 8),
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
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                              //     Image.memory(
                              //   Uint8List.fromList(i.bytes),
                              //   width: 300,
                              //   height: 300,
                              //   fit: BoxFit.cover,
                              // ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : InkWell(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomGreyTextField(
                  controller: productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(height: 10),
                CustomGreyTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomGreyTextField(
                  controller: priceController,
                  hintText: 'Price',
                ),
                const SizedBox(height: 10),
                CustomGreyTextField(
                  controller: quantityController,
                  hintText: 'Quantity',
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(221, 32, 32, 32),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButton(
                        alignment: Alignment.center,
                        // enableFeedback: true,
                        // dropdownColor: Colors.black,
                        // focusColor: Colors.black,
                        elevation: 8,

                        // isExpanded: false,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        borderRadius: BorderRadius.circular(10),
                        value: category,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: productCategories.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          // by onChanged property we rebuild the whole screen.
                          setState(() {
                            category = newVal!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  roundness: 10,
                  loader: sellBtnClicked,
                  loaderColor: GlobalVariables.backgroundColor,
                  height: 60,
                  text: 'Sell',
                  onTap: sellProduct,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
