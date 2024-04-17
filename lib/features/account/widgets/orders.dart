import 'package:flutter/material.dart';
import 'package:shopsphere/common/loader.dart';
import 'package:shopsphere/common/loader4.dart';
import 'package:shopsphere/features/account/services/account_services.dart';
import 'package:shopsphere/features/account/widgets/single_product.dart';
import 'package:shopsphere/features/order_details/screens/order_details.dart';
import 'package:shopsphere/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  // List list = [
  //   'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60',
  //   'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60',
  //   'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60',
  //   'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60',
  // ];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Padding(
            padding: const EdgeInsets.only(
              top: 150,
            ),
            child: spinkitLoader(),
          )
        :
        // SingleChildScrollView(
        //     child:
        // Column(
        //     children: [
        // Expanded(
        //   child:
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        // Container(
        //   padding: const EdgeInsets.only(
        //     left: 15,
        //   ),
        //   child: const Text(
        //     'Your Orders',
        //     style: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        // // Container(
        //   padding: const EdgeInsets.only(
        //     right: 15,
        //   ),
        //   child: Text(
        //     'See all',
        //     style: TextStyle(
        //       color: GlobalVariables.selectedNavBarColor,
        //     ),
        //   ),
        // ),
        //   ],
        // ),
        // ),
        // display orders
        Expanded(
            child: ListView.builder(
              // scrollDirection: Axis.horizontal,
              // itemCount: orders!.length,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: orders!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetailScreen.routeName,
                      arguments: orders![index],
                    );
                  },
                  child:
                      // Text(
                      //   orders![index].id.toString(),
                      // ),
                      //   Expanded(
                      // child:
                      SingleProduct(orderOverview: orders![index]
                          // ![index].products[0].images[0]
                          // ),
                          ),
                );
              },
              // ),
              // Container(
              //   height: MediaQuery.of(context).size.height / 1.615,
              //   child: Padding(
              //     // height: ,
              //     padding: const EdgeInsets.only(
              //       left: 0,
              //       top: 20,
              //       right: 0,
              //     ),
              //     child: Container(
              //       child: ListView.builder(
              //         // scrollDirection: Axis.horizontal,
              //         // itemCount: orders!.length,
              //         // physics: const NeverScrollableScrollPhysics(),
              //         shrinkWrap: true,
              //         itemCount: orders!.length,
              //         itemBuilder: (context, index) {
              //           return InkWell(
              //             onTap: () {
              //               Navigator.pushNamed(
              //                 context,
              //                 OrderDetailScreen.routeName,
              //                 arguments: orders![index],
              //               );
              //             },
              //             child:
              //                 // Text(
              //                 //   orders![index].id.toString(),
              //                 // ),
              //                 Container(
              //               child: SingleProduct(orderOverview: orders![index]
              //                   // ![index].products[0].images[0]
              //                   ),
              //             ),
              //           );
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              // ],
              // ),
            ),
          );
  }
}
