import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '0';
  dynamic opr = '';
  dynamic preOpr = '';

  Widget CalcButton(String buttonText, Color buttonColor, Color textColor) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          calculation(buttonText);
        });
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: buttonColor,
        padding: const EdgeInsets.all(20),
        fixedSize: const Size(85, 85),
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 29, color: textColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 5,
          right: 5,
          bottom: MediaQuery.of(context).viewPadding.bottom + 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Wrap Row with SingleChildScrollView to avoid overflow
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.topRight,
                      child: Text(
                        '$text',
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.visible,
                        style: const TextStyle(color: Colors.white, fontSize: 100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalcButton("AC", Colors.grey, Colors.black),
                CalcButton('+/-', Colors.grey, Colors.black),
                CalcButton('%', Colors.grey, Colors.black),
                CalcButton('/', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalcButton('7', Colors.grey.shade800, Colors.white),
                CalcButton('8', Colors.grey.shade800, Colors.white),
                CalcButton('9', Colors.grey.shade800, Colors.white),
                CalcButton('x', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalcButton('4', Colors.grey.shade800, Colors.white),
                CalcButton('5', Colors.grey.shade800, Colors.white),
                CalcButton('6', Colors.grey.shade800, Colors.white),
                CalcButton('-', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalcButton('1', Colors.grey.shade800, Colors.white),
                CalcButton('2', Colors.grey.shade800, Colors.white),
                CalcButton('3', Colors.grey.shade800, Colors.white),
                CalcButton('+', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      calculation('0');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.grey.shade800,
                    padding: EdgeInsets.zero,
                    fixedSize: const Size(185, 85),
                  ),
                  child: const Center(
                    child: Text(
                      '0',
                      style: TextStyle(fontSize: 29, color: Colors.white),
                    ),
                  ),
                ),
                CalcButton('.', Colors.grey.shade800, Colors.white),
                CalcButton('=', Colors.amber.shade700, Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void calculation(btnText) {
    if (btnText == 'AC' || btnText == 'C') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      if (result == '') return;

      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }

      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      if (result != '') {
        result = (double.parse(result) / 100).toString();
        finalResult = doesContainDecimal(result);
      }
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    if (numTwo == 0) return 'Error';
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return splitDecimal[0].toString();
      }
    }
    return result;
  }
}
