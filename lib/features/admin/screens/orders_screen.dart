import 'package:shopsphere/common/loader4.dart';
import 'package:shopsphere/features/admin/services/admin_services.dart';
import 'package:shopsphere/features/admin/widgets/single_product_admin.dart';
import 'package:shopsphere/features/order_details/screens/order_details.dart';
import 'package:shopsphere/models/order.dart';
import 'package:flutter/material.dart';

import '../../../common/loader.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Center(
            child: spinkitLoader(),
          )
        : GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OrderDetailScreen.routeName,
                    arguments: orderData,
                  );
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProductAdmin(
                    product: orderData.products[0],
                  ),
                ),
              );
            },
          );
  }
}
