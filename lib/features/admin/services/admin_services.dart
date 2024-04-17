// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:shopsphere/constants/error_handling.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/constants/utils.dart';
import 'package:shopsphere/features/admin/screens/admin_screen.dart';
import 'package:shopsphere/features/admin/screens/posts_screen.dart';
import 'package:shopsphere/models/product.dart';
import 'package:shopsphere/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/order.dart';
import '../models/sales.dart';

class AdminServices {
  Future<void> sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
    // required List<dynamic> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // final cloudinary = CloudinaryPublic("dgklzqfkh", "pz6ro6ck");
      // List<String> imageUrls = [];
      // List<int> bytes = image.readAsBytesSync();
      //   var base64Image = base64Encode(bytes);
      // List<dynamic> byteDataImages = [];
      // for (int i = 0; i < images.length; i++) {
      //   byteDataImages.add(images[i].bytes.buffer.asByteData());
      //   print(images[i].bytes.buffer.asByteData());
      // }
      // for (int i = 0; i < images.length; i++) {
      //   // var bytes = images[i].readAsBytesSync();
      //   // var base64Image = base64Encode(bytes);
      //   CloudinaryResponse res = await cloudinary.uploadFile(
      //     CloudinaryFile.fromFile(images[i].path, folder: name),
      //     // folder will be created in cloudinary ji by the name of the product.
      //     // CloudinaryResponse res = await cloudinary.uploadFile(
      //     //   CloudinaryFile.fromByteData(images[i].readAsBytesSync(),
      //     //       // images[i].bytes.buffer.asByteData(),
      //     //       folder: name),
      //   );
      // if(res.s) {
//         print('Get your image from with ${res.secureUrl}');
// // }
//         print(res.secureUrl);
//         imageUrls.add(res.secureUrl);
      // }

      final cloudinary = CloudinaryPublic('dgklzqfkh', 'pz6ro6ck');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      // showSnackBar(context, product.toString());

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      // showSnackBar(context, res.body.toString());

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully !');
          // Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: ((context) {
              return AdminScreen();
            })),
            ModalRoute.withName('/'),
          );
          // ModalRoute.withName('/'),
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      // showSnackBar(context, "yaar");
      print("--------------------" + e.toString());
    }
  }

  // get all the products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  // we are decoding and then encoding the res.body because fromJson() method requires String.
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<void> deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Deleted Successfully !');
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  Future<String> changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
      return "success";
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "error";
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Essentials', response['essentialEarnings']),
            Sales('Books', response['booksEarnings']),
            Sales('Appliances', response['applianceEarnings']),
            Sales('Fashion', response['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}
