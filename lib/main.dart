
import 'package:lab_3/widgets/calculator_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_3/constants/app_constants.dart';


void main() {
  runApp(MaterialApp(
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key, required this.history});
  final String history;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5FF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Container(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                          backgroundColor: MaterialStatePropertyAll<Color>(primary),
                        ),
                        child: Icon(
                          Icons.access_time_outlined,
                          color: secondary,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                          backgroundColor: MaterialStatePropertyAll<Color>(primary),
                        ),
                        child: Text(
                          '<',
                          style: TextStyle(
                            color: secondary,
                            fontSize: 30
                          ),
                        ),
                        onPressed: () {
                          _CalculatorAppState.historyBig = '';
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left:280, right: 20),
                        child: Text(
                          history,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      )
    );
  }
}


class _CalculatorAppState extends State<CalculatorApp> {
  int firstNum = 0;
  int secondNum = 0;
  String history = '';
  String textToDisplay = '';
  String res = '';
  String operation = '';
  static String historyBig = '';
  void writeHistory() {
    history = firstNum.toString() + operation.toString() + secondNum.toString();
  }
  void writePartialHistory() {
    history = firstNum.toString() + operation.toString();
  }
  void btnOnClick(String btnVal) {
    //print(btnVal);
    if (btnVal == 'C') {
      textToDisplay = '';
      firstNum = 0;
      secondNum = 0;
      res = '';
    } else if (btnVal == 'AC') {
      textToDisplay = '';
      firstNum = 0;
      secondNum = 0;
      res = '';
      history = '';
    } else if (btnVal == '+/-') {
      if (textToDisplay[0] != '-') {
        res = '-$textToDisplay';
      } else {
        res = textToDisplay.substring(1);
      }
    } else if (btnVal == '<') {
      res = textToDisplay.substring(0, textToDisplay.length - 1);
    } else if ( btnVal == '+' || btnVal == '-' || btnVal == 'X' || btnVal == '/') {
      firstNum = int.parse(textToDisplay);
      res = '';
      operation = btnVal;
      writePartialHistory();
    } else if (btnVal == '=') {
      secondNum = int.parse(textToDisplay);
      if (operation == '+') {
        res = (firstNum + secondNum).toString();
        writeHistory();
      }
      if (operation == '-') {
        res = (firstNum - secondNum).toString();
        writeHistory();
      }
      if (operation == 'X') {
        res = (firstNum * secondNum).toString();
        writeHistory();
      }
      if (operation == '/') {
        res = (firstNum / secondNum).toString();
        writeHistory();
      }
      historyBig += "\n";
      historyBig += history.toString();
      historyBig += "\n";
      historyBig += "=" + res.toString();
    } else {
      res = int.parse(textToDisplay + btnVal).toString();
    }

    setState(() {
      textToDisplay = res;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: Scaffold(
        backgroundColor: Color(0xFFF5F5FF),
        body: Column(
        children: <Widget> [
          Expanded(child:
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(80),
                    child: Text(
                      'Calculator',
                      style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              fontSize: 24,
                              color: Color(0xFF252C32),
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 40,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll<Color>(primary),
                ),
                child: Icon(
                  Icons.access_time_outlined,
                  color: secondary,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HistoryPage(history: historyBig)),
                  );
                },
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Text(
                      history,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                            fontSize: 24,
                            color: info,
                        ),
                      ),
                    ),
                  ),
                  alignment: Alignment(1.0, 1.0),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      textToDisplay,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 48,
                          color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  alignment: Alignment(1.0, 1.0),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalculatorButton(text: 'AC',
                  fillColor: primary,
                  textColor: danger,
                  textSize: 28,
                  callback: btnOnClick,
                  ),
                  CalculatorButton(text: 'C',
                    fillColor: primary,
                    textColor: danger,
                    textSize: 28,
                    callback: btnOnClick,
                  ),
                  CalculatorButton(text: '<',
                    fillColor: primary,
                    textColor: secondary,
                    textSize: 28,
                    callback: btnOnClick,
                  ),
                  CalculatorButton(text: '/',
                    fillColor: primary,
                    textColor: secondary,
                    textSize: 28,
                    callback: btnOnClick,
                  ),
                ],
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton(text: '7',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '8',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '9',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: 'X',
                      fillColor: primary,
                      textColor: secondary,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton(text: '4',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '5',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '6',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '-',
                      fillColor: primary,
                      textColor: secondary,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton(text: '1',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '2',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '3',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '+',
                      fillColor: primary,
                      textColor: secondary,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton(text: '+/-',
                      fillColor: primary,
                      textColor: secondary,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '0',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '00',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '=',
                      fillColor: secondary,
                      textColor: primary,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                  ],
                ),
              ],
            )
          )
        ]
        )
      )
    );
  }
}
