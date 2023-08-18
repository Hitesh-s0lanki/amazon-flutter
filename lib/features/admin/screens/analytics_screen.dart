import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/category_product_chart.dart';
import 'package:flutter/material.dart';

import '../model/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

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
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null ? const Loader() : Column(
      children: [
          CategoryProductChart(salesData: earnings!)
      ],
    );
  }
}
