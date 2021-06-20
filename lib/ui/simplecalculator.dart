import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({ Key? key }) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equal = "0";
  String result = "0";
  String expression = "";
  double equalSize = 38;
  double resultSize = 48;

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
            height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
            color: buttonColor,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
              ),
              padding: EdgeInsets.all(16.0),
              onPressed: () => pressed(buttonText), 
              child: Text(buttonText, style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),),
            ),
          );
  }

  pressed(String text) {
    setState(() {
      switch (text) {
        case "C":
          equal = "0";
          result = "0";
          equalSize = 38;
          resultSize = 48;
          break;
        case "⋘":
          equalSize = 48;
          resultSize = 38;
          int length = equal.length;
          equal = equal.substring(0, length-1);
          if(equal == "") {
            equal = "0";
            equalSize = 38;
            resultSize = 48;
          };
          break;
        case "=":
          equalSize = 38;
          resultSize = 48;
          expression = equal;
          expression = expression.replaceAll("x", "*");
          expression = expression.replaceAll("÷", "/");
          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = "${exp.evaluate(EvaluationType.REAL, cm)}";
          }catch(e) {
            result = "Error";
          }
          break;
        default:
          equalSize = 48;
          resultSize = 38;
          if(equal == "0") {
            equal = text;
          }else {
            equal = equal + text;
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple Calculator"),),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equal, style: TextStyle(fontSize: equalSize)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultSize)),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("⋘", 1, Colors.blue),
                        buildButton("÷", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.black54),
                        buildButton("8", 1, Colors.black54),
                        buildButton("9", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.black54),
                        buildButton("5", 1, Colors.black54),
                        buildButton("6", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.black54),
                        buildButton("2", 1, Colors.black54),
                        buildButton("3", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.black54),
                        buildButton("0", 1, Colors.black54),
                        buildButton("00", 1, Colors.black54),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 2, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}