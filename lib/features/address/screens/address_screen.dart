import 'package:flutter/material.dart';
import 'package:shopsphere/common/custom_grey_textfield.dart';
import 'package:shopsphere/constants/global_variables.dart';
import 'package:shopsphere/constants/payment_configurations.dart';
import 'package:shopsphere/constants/utils.dart';
import 'package:shopsphere/features/address/services/address_services.dart';
import 'package:shopsphere/features/cart/widgets/cart_product.dart';
import 'package:shopsphere/features/cart/widgets/cart_subtotal.dart';
import 'package:shopsphere/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:pay/pay.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      const PaymentItem(
        amount: '99.99', //widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
        if (Provider.of<UserProvider>(context, listen: false)
            .user
            .address
            .isEmpty) {
          addressServices.saveUserAddress(
              context: context, address: addressToBeUsed);
        }
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
    print(addressToBeUsed);

    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    var address =
        context.watch<UserProvider>().user.address; //'631 , amer , jaipur';
    // address = "address";
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          // automaticallyImplyLeading: true,
          leading: InkWell(
            child: const Icon(
              Icons.arrow_back_ios,
              color: GlobalVariables.backgroundColor,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: false,
          titleSpacing: 0,
          title: const Text("Order Details"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: GlobalVariables.darkblackThemeColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    // DottedBorder(
                    //   color: GlobalVariables.darkGrey,
                    //   strokeWidth: 1,
                    //   borderType: BorderType.RRect,
                    //   strokeCap: StrokeCap.round,
                    //   dashPattern: [4, 4],
                    //   radius: Radius.circular(10),
                    //   child:
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: GlobalVariables.greyBackgroundCOlor,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          color: GlobalVariables.greyBackgroundCOlor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    // ),
                    const SizedBox(height: 15),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomGreyTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomGreyTextField(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomGreyTextField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomGreyTextField(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return
                      // Flexible(
                      //   child:
                      CartProduct(
                    index: index,
                    // ),
                  );
                },
              ),

              const CartSubtotal(),

              // ApplePayButton(
              //   width: double.infinity,
              //   style: ApplePayButtonStyle.whiteOutline,
              //   type: ApplePayButtonType.buy,
              //   paymentConfigurationAsset: 'applepay.json',
              //   onPaymentResult: onApplePayResult,
              //   paymentItems: paymentItems,
              //   margin: const EdgeInsets.only(top: 15),
              //   height: 50,
              //   onPressed: () => payPressed(address),
              // ),
              // const SizedBox(height: 10),
              // GooglePayButton(
              //   onPressed: () => payPressed(address),
              //   paymentConfiguration: PaymentConfiguration.fromAsset('gpay.json'),
              //   onPaymentResult: onGooglePayResult,
              //   paymentItems: paymentItems,
              //   height: 50,
              //   style: GooglePayButtonStyle.black,
              //   type: GooglePayButtonType.buy,
              //   margin: const EdgeInsets.only(top: 15),
              //   loadingIndicator: const Center(
              //     child: CircularProgressIndicator(),
              //   ),
              // ),
              // import 'package:pay/pay.dart';

// const _paymentItems = [
//   PaymentItem(
//     label: 'Total',
//     amount: '99.99',
//     status: PaymentItemStatus.final_price,
//   )
// ];

              ApplePayButton(
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(defaultApplePay),
                paymentItems: paymentItems,
                style: ApplePayButtonStyle.black,
                type: ApplePayButtonType.buy,
                height: 50,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onApplePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                onPressed: () => payPressed(address),
              ),

              GooglePayButton(
                onPressed: () => payPressed(address),
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(defaultGooglePay),
                paymentItems: paymentItems,
                height: 50,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),

              // InkWell(
              //   onTap: () async {
              //     final _paymentItems = [
              //       PaymentItem(
              //         label: 'Total',
              //         amount: '99.99',
              //         status: PaymentItemStatus.final_price,
              //       )
              //     ];
              //     Pay payClient = Pay({
              //       PayProvider.google_pay: PaymentConfiguration.fromJsonString(
              //           defaultGooglePay), // your gpay json
              //       PayProvider.apple_pay: PaymentConfiguration.fromJsonString(
              //           defaultApplePay), // your apay json
              //     });
              //     final result = await payClient.showPaymentSelector(
              //       false ? PayProvider.apple_pay : PayProvider.google_pay,
              //       paymentItems,
              //     );
              //     print(result.toString());
              //   },
              //   // }
              //   // );
              //   // },
              //   child: Text("google pay"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
