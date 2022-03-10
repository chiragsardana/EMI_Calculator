import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class MyChart extends StatelessWidget {
  Map<String, double> dataMap;
  MyChart({Key? key, required this.dataMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: dataMap,
      colorList: const [Colors.orange, Colors.green],
    );
  }
}
