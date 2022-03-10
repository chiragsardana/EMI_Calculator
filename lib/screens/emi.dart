import 'dart:math';

import 'package:emi_calculator_/widgets/chart.dart';
import 'package:emi_calculator_/widgets/output.dart';
import 'package:emi_calculator_/widgets/slider.dart';
import 'package:emi_calculator_/widgets/textbox.dart';
import 'package:flutter/material.dart';

class EMI extends StatefulWidget {
  const EMI({Key? key}) : super(key: key);

  @override
  State<EMI> createState() => _EMIState();
}

class _EMIState extends State<EMI> {
  int _value = 5; //Within the Dart File
  TextEditingController tc1 = TextEditingController();
  TextEditingController tc2 = TextEditingController();
  TextEditingController tc3 = TextEditingController();
  double emi = 0.0;
  double totalPayment = 0;
  double interestPayable = 0;
  Map<String, double> dataMap = {
    "Nothing": 100,
  };
  takeSliderValue(int value) {
    _value = value;
    // print("Received Value From Slider $value");
    // Tree Shaking, Not Good For Big Applications
    tc3.text = _value.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextBox tb = TextBox(
      label: "Tenure is",
      icon: Icons.money_outlined,
      tc: tc3,
    );
    tb.setFunction(takeSliderValue);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "EMI Calculator",
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextBox(
              label: "Amount",
              icon: Icons.monetization_on,
              tc: tc1,
            ),
            TextBox(
              label: "ROI",
              icon: Icons.money_off_rounded,
              tc: tc2,
            ),
            tb,
            MySlider(
              fn: takeSliderValue,
              value: _value,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: _compute,
                child: const Text(
                  "Compute",
                  style: TextStyle(color: Colors.black),
                )), //Pass function as an arguement to the constructor
            OutputBox(data: "Loan EMI is $emi"),
            OutputBox(
              data: "Total Payment is $totalPayment",
            ),
            OutputBox(data: "Total Interest Payable is $interestPayable"),
            MyChart(dataMap: dataMap),
          ],
        ),
      ),
    );
  }

  _compute() {
    int P = int.parse(tc1.text);
    double r = int.parse(tc2.text) / 12 / 100;
    int n = int.parse(tc3.text) * 12;
    double A = (P * r * pow((1 + r), n) / (pow((1 + r), n) - 1));
    emi = A.round().toDouble();
    totalPayment = (A * n).toDouble().roundToDouble();
    interestPayable = totalPayment - P;
    double percentInterest = ((interestPayable) / totalPayment) * 100;
    dataMap = {
      "Total Interest": percentInterest,
      "Principal Loan Amount": 100 - percentInterest,
    };
    setState(() {});
  }
}
//State mean data which is for view