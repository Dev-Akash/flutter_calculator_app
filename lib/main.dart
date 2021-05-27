import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorHome());
}

class CalculatorHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Calculator')),
        ),
        body: Calc()
      ),
    );
  }
}

class Calc extends StatefulWidget {
  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFont = 38.0;
  double resultFont = 28.0;

  buttonPressed(text){
    if(text == "C"){
      setState(() {
        equation = "0";
        result = "0";
        resultFont = 28.0;
        equationFont = 38.0;
      });
    }
    else if(text == "⌫"){
      setState(() {
        if(equation != "0") {
          equation = equation.substring(0, equation.length-1);
          resultFont = 28.0;
          equationFont = 38.0;
        }
      });
    }
    else if(text == "="){
      try{
        Parser p = Parser();
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        Expression exp =  p.parse(expression);

        ContextModel cm = ContextModel();

        double res = exp.evaluate(EvaluationType.REAL, cm);
        setState(() {
          result = res.toString();
          resultFont = 38.0;
          equationFont = 28.0;
        });
      }
      catch(expression){
        setState(() {
          result = "Error";
          print(expression);
        });
      }
    }
    else{
      setState(() {
        resultFont = 28.0;
        equationFont = 38.0;
        if(equation == "0"){
          equation = text;
        }
        else{
          equation += text;
        }
      });
    }
  }

  createButton(color,String text){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: FlatButton(
        onPressed: () => buttonPressed(text),
        child: Text(text, style: TextStyle(fontSize: 28.0, color: Colors.white),),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: (text == '+' || text == '9' || text =='C') ? BorderRadius.only(topRight: Radius.circular(30)) :BorderRadius.circular(0.0),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.all(10.0),
                  child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 400),
                      style: TextStyle(fontSize: equationFont, fontWeight: FontWeight.w400, color: Colors.black),
                      child: Text(equation)
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.all(10.0),
                  child: Text(result, style: TextStyle(fontSize: resultFont, fontWeight: FontWeight.w400),),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(-10, -6),
                    blurRadius: 20,
                  )
                ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width* .75,
                  color: Colors.deepPurple,
                  child: Table(
                    children: [
                      TableRow(
                          children: [
                            createButton(Colors.red, 'C'),
                            createButton(Colors.deepPurple, '⌫'),
                            createButton(Colors.deepPurple, '%'),
                          ]
                      ),
                      TableRow(
                        children: [
                          createButton(Colors.blue, '7'),
                          createButton(Colors.blue, '8'),
                          createButton(Colors.blue, '9'),
                        ]
                      ),
                      TableRow(
                          children: [
                            createButton(Colors.blue, '4'),
                            createButton(Colors.blue, '5'),
                            createButton(Colors.blue, '6'),
                          ]
                      ),
                      TableRow(
                          children: [
                            createButton(Colors.blue, '1'),
                            createButton(Colors.blue, '2'),
                            createButton(Colors.blue, '3'),
                          ]
                      ),
                      TableRow(
                          children: [
                            createButton(Colors.blue, '00'),
                            createButton(Colors.blue, '0'),
                            createButton(Colors.blue, '.'),
                          ]
                      ),
                    ]
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .25,
                  child: Table(
                    children: [
                      TableRow(
                          children: [
                            createButton(Colors.deepPurple, '+'),
                          ]
                      ),
                      TableRow(
                          children: [
                            createButton(Colors.deepPurple, '-'),
                          ]
                      ),
                      TableRow(
                          children: [
                            createButton(Colors.deepPurple, '×'),
                          ]
                      ),
                      TableRow(
                          children: [
                            createButton(Colors.deepPurple, '÷'),
                          ]
                      ),
                      TableRow(
                          children: [
                            createButton(Colors.red, '='),
                          ]
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

