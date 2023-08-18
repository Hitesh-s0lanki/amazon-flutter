import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../model/sales.dart';

class CategoryProductChart extends StatelessWidget {

  final List<Sales> salesData;
  const CategoryProductChart({super.key , required this.salesData});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 300,
      child: Column(children: [
        //Initialize the chart widget
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Half yearly sales analysis'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<Sales, String>>[
              LineSeries<Sales, String>(
                  dataSource: salesData,
                  xValueMapper: (Sales sales, _) => sales.label,
                  yValueMapper: (Sales sales, _) => sales.earning,
                  name: 'Sales',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            //Initialize the spark charts widget
            child: SfSparkLineChart.custom(
              //Enable the trackball
              trackball:const SparkChartTrackball(
                  activationMode: SparkChartActivationMode.tap),
              //Enable marker
              marker:const SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all),
              //Enable data label
              labelDisplayMode: SparkChartLabelDisplayMode.all,
              xValueMapper: (int index) => salesData[index].label,
              yValueMapper: (int index) => salesData[index].earning,
              dataCount: 5,
            ),
          ),
        )
      ]),
    );
  }
}
