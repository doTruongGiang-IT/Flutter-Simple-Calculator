import 'package:flutter/material.dart';
import 'simplecalculator.dart';

class Calculator extends StatelessWidget {
  const Calculator({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}