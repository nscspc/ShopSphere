import 'package:flutter/material.dart';
import 'package:shopsphere/features/account/services/account_services.dart';
import 'package:shopsphere/features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () async {
                AccountServices().logOut(context);
              },
            ),
            // AccountButton(
            //   text: 'Your Orders',
            //   onTap: () {},
            // ),
            AccountButton(
              text: 'Turn Seller',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Row(
        //   children: [
        //     AccountButton(
        //         text: 'Log Out',
        //         onTap: () async {
        //           AccountServices().logOut(context);
        //         }),
        //     AccountButton(
        //       text: 'Your Wish List',
        //       onTap: () {},
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
