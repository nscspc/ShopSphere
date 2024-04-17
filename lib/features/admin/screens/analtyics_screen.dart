import 'package:lottie/lottie.dart';
import 'package:shopsphere/common/loader.dart';
import 'package:shopsphere/common/loader4.dart';
import 'package:shopsphere/features/account/services/account_services.dart';
import 'package:shopsphere/features/account/widgets/account_button.dart';
import 'package:shopsphere/features/admin/models/sales.dart';
import 'package:shopsphere/features/admin/services/admin_services.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? Center(
            child: spinkitLoader(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 15,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Sales : Rs $totalSales',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: AccountButton(
                          text: 'Log Out',
                          onTap: () async {
                            AccountServices().logOut(context);
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  // SizedBox is used because CategoryProductsChart() widget needs to be defined with a height or size.
                  height: 250,
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: 'Half yearly sales analysis'),
                      // Enable legend
                      // legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<Sales, String>>[
                        LineSeries<Sales, String>(
                            dataSource: earnings!,
                            xValueMapper: (Sales sales, _) => sales.label,
                            yValueMapper: (Sales sales, _) => sales.earning,
                            name: 'Sales',
                            // Enable data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true))
                      ]),
                  // CategoryProductsChart(seriesList: [
                  //   charts.Series(
                  //     id: 'Sales',
                  //     data: earnings!,
                  //     domainFn: (Sales sales, _) => sales.label,
                  //     measureFn: (Sales sales, _) => sales.earning,
                  //   ),
                  // ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  height: 200,
                  width: 200,
                  child: Lottie.asset(
                    'assets/lottie_animations/analytics_lottie.json',
                  ),
                ),
              ],
            ),
          );
  }
}
