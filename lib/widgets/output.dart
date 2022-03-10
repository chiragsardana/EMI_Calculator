import 'package:flutter/material.dart';

class OutputBox extends StatelessWidget {
  String data;
  OutputBox({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        width: 300,
        child: Center(child: Text(data)),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.orangeAccent[200],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black)),
      ),
    );
  }
}
