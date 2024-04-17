import 'package:dotted_border/dotted_border.dart';
import 'package:shopsphere/common/custom_button.dart';
import 'package:shopsphere/common/rounded_button.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/features/admin/services/admin_services.dart';
import 'package:shopsphere/features/search/screens/search_screen.dart';
import 'package:shopsphere/models/order.dart';
import 'package:shopsphere/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();
  bool doneBtnClicked = false;

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      currentStep = widget.order.status;
      //  <= 0
      //     ? 0
      //     : widget.order.status >= 3
      //         ? 3
      //         : widget.order.status;
    });
    // currentStep = widget.order.status;
  }

  // !!! ONLY FOR ADMIN !!!
  void changeOrderStatus(int status) async {
    setState(() {
      doneBtnClicked = true;
    });
    await adminServices.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          currentStep = (currentStep + 1); // > 3 ? 3 : currentStep + 1;
        });
      },
    );
    setState(() {
      doneBtnClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: GlobalVariables.backgroundColor,
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
            "Order Details",
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [

          //   ],
          // ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   'View order details',
              //   style: TextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              DottedBorder(
                color: GlobalVariables.darkGrey,
                strokeWidth: 1,
                borderType: BorderType.RRect,
                strokeCap: StrokeCap.round,
                dashPattern: [4, 4],
                radius: Radius.circular(10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 0; i < widget.order.products.length; i++)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        widget.order.products[i].images[0],
                                        height: 200,
                                        // width: Media,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                // const SizedBox(width: 5),
                                // Expanded(
                                // child:
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(15),
                                    color: GlobalVariables.greyBackgroundCOlor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.order.products[i].name,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            'Qty: ${widget.order.quantity[i]}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      // decoration: BoxDecoration(
                      //   border: Border.all(
                      //     color: Colors.black12,
                      //   ),
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order Date :      ${DateFormat().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                widget.order.orderedAt),
                          )}'),
                          Text('Order ID :          ${widget.order.id}'),
                          Text(
                              'Order Total :     Rs ${widget.order.totalPrice}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                  physics: const NeverScrollableScrollPhysics(),
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (user.type == 'admin') {
                      return currentStep > 3
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: RoundedButton(
                                text: 'Done',
                                loader: doneBtnClicked,
                                loaderColor: GlobalVariables.backgroundColor,
                                widthInfinity: true,
                                onTap: () =>
                                    changeOrderStatus(details.currentStep),
                              ),
                            );
                    }
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                      title: const Text('Pending'),
                      content: const Text(
                        'Your order is Pending',
                      ),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Completed'),
                      content: const Text(
                        'Your order has been completed',
                      ),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Received'),
                      content: const Text(
                        'Order has been Received for Dispatching',
                      ),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Delivered'),
                      content: const Text(
                        'Your order has been delivered and signed by you!',
                      ),
                      isActive: currentStep > 3,
                      state: currentStep > 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Thanks'),
                      content: const Text(
                        '',
                      ),
                      isActive: currentStep >= 4,
                      state: currentStep >= 4
                          ? StepState.thanks
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
