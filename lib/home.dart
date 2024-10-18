import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

class Calc extends StatefulWidget {
  const Calc({super.key});

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  //--------------variable-------------------
  double first_num = 0.0;
  double second_num = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideinput = false;
  var outputsize = 32.0;
  //------------------------------------------
  onButtonclick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "del") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideinput = true;
        outputsize = 50;
      }
    } else {
      input = input + value;
      hideinput = false;
      outputsize = 32;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          children: [
            // input and output area
            Expanded(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideinput ? '' : input,
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        fontSize: outputsize,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )),
            Row(
              children: [
                button(
                    text: "AC",
                    tcolor: Colors.orange,
                    Buttoncolor: Color.fromARGB(255, 43, 36, 24)),
                button(text: "%", Buttoncolor: Color.fromARGB(255, 42, 70, 93)),
                button(
                    text: "del", Buttoncolor: Color.fromARGB(255, 42, 70, 93)),
                button(text: "/", Buttoncolor: Color.fromARGB(255, 42, 70, 93))
              ],
            ),
            Row(
              children: [
                button(text: "7"),
                button(text: "8"),
                button(text: "9"),
                button(text: "x", Buttoncolor: Color.fromARGB(255, 42, 70, 93))
              ],
            ),
            Row(
              children: [
                button(text: "4"),
                button(text: "5"),
                button(text: "6"),
                button(text: "-", Buttoncolor: Color.fromARGB(255, 42, 70, 93))
              ],
            ),
            Row(
              children: [
                button(text: "1"),
                button(text: "2"),
                button(text: "3"),
                button(text: "+", Buttoncolor: Color.fromARGB(255, 42, 70, 93))
              ],
            ),
            Row(
              children: [
                button(text: "00"),
                button(text: "0"),
                button(text: "."),
                button(
                    text: "=", tcolor: Colors.white, Buttoncolor: Colors.orange)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button(
      {text,
      tcolor = Colors.white,
      Buttoncolor = const Color.fromARGB(255, 44, 43, 43)}) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(9),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16), backgroundColor: Buttoncolor),
          onPressed: () => onButtonclick(text),
          child: Text(
            text,
            style: TextStyle(
                color: tcolor, fontSize: 23, fontWeight: FontWeight.bold),
          )),
    ));
  }
}
