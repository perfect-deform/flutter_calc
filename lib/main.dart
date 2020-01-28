import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(MaterialApp(home: Calc()));

class Calc extends StatefulWidget {
  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  String inputField = '0';
  String historyField = '';
  String sign = '';
  double resultField;
  bool counted = false;

  bool isDigit(String s, int idx) =>
      "0".compareTo(s[idx]) <= 0 && "9".compareTo(s[idx]) >= 0;

  void action(String signInsert) {
    setState(() {
      if (historyField.length != 0 && inputField != '0') {
        if ('.'.compareTo(inputField[inputField.length - 1]) == 0) {
          inputField = inputField.substring(0, inputField.length - 1);
          historyField = historyField.substring(0, historyField.length - 1);
        }
        if (isDigit(historyField, historyField.length - 1) == true) {
          if (historyField.contains('+') ||
              historyField.contains('-') ||
              historyField.contains('*') ||
              historyField.contains('/')) {
            if (historyField
                    .replaceAll('-', '+')
                    .replaceAll('*', '+')
                    .replaceAll('/', '+')
                    .split('+')
                    .length >
                1) {
              if ('-'.compareTo(sign) == 0 && counted == false) {
                resultField = resultField - double.parse('$inputField');
                counted = true;
                if (resultField % 1 == 0) {
                  inputField = resultField.toStringAsFixed(0);
                } else {
                  resultField = double.parse(resultField.toStringAsFixed(9));
                  inputField = resultField.toString();
                }
              } else if ('+'.compareTo(sign) == 0 && counted == false) {
                resultField = resultField + double.parse('$inputField');
                counted = true;
                if (resultField % 1 == 0) {
                  inputField = resultField.toStringAsFixed(0);
                } else {
                  resultField = double.parse(resultField.toStringAsFixed(9));
                  inputField = resultField.toString();
                }
              } else if ('*'.compareTo(sign) == 0 && counted == false) {
                resultField = resultField * double.parse('$inputField');
                counted = true;
                if (resultField % 1 == 0) {
                  inputField = resultField.toStringAsFixed(0);
                } else {
                  resultField = double.parse(resultField.toStringAsFixed(9));
                  inputField = resultField.toString();
                }
              } else if ('/'.compareTo(sign) == 0 && counted == false) {
                resultField = resultField / double.parse('$inputField');
                counted = true;
                if (resultField % 1 == 0) {
                  inputField = resultField.toStringAsFixed(0);
                } else {
                  resultField = double.parse(resultField.toStringAsFixed(9));
                  inputField = resultField.toString();
                }
              }
            }
          }
          historyField += signInsert;
          sign = signInsert;
        } else if (isDigit(historyField, historyField.length - 1) == false) {
          if ('/'.compareTo(sign) == 0 &&
              counted == false &&
              inputField == '0') {
            inputField = 'Деление на ноль не поддерживается';
          }
        }
        if (signInsert.compareTo(historyField[historyField.length - 1]) != 0) {
          historyField =
              historyField.substring(0, historyField.length - 1) + signInsert;
          sign = signInsert;
        }
        if (resultField == null) {
          resultField = double.parse('$inputField');
        }
      }
    });
  }

  Widget _button(String number) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: MaterialButton(
          color: Color(0xFF737373),
          child: AutoSizeText(
            number,
            style: TextStyle(
              color: Color(0xFFD9D9D9),
              fontSize: (32.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            setState(() {
              if (counted == true) {
                counted = false;
              }
              if (inputField == '0' ||
                  (isDigit(historyField, historyField.length - 1) == false &&
                      '.'.compareTo(historyField[historyField.length - 1]) !=
                          0)) {
                inputField = number;
                if (inputField != '0') {
                  historyField += number;
                }
              } else if (inputField.length < 16) {
                inputField += number;
                /*if(!inputField.contains('.')){
                  inputField = inputField.replaceAll(',', '');
                  inputField = inputField.replaceAll(new RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
                  historyField = historyField.replaceAll(new RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
                }*/
                historyField += number;
              }
            });
          },
        ),
      ),
    );
  }

  Widget _button2(String number) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: MaterialButton(
            color: Color(0xFF262626),
            child: AutoSizeText(
              number,
              style: TextStyle(
                color: Color(0xFFD9D9D9),
                fontSize: (32.0),
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              action(number);
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Калькулятор'),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.5),
                color: Color(0xFFD9D9D9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: AutoSizeText(
                        '$historyField',
                        style: TextStyle(
                          fontSize: 32.0,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
                color: Color(0xFFD9D9D9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: AutoSizeText(
                        '$inputField',
                        style: TextStyle(
                          fontSize: 32.0,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: MaterialButton(
                          color: Color(0xFF262626),
                          child: AutoSizeText(
                            'C',
                            style: TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: (32.0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              inputField = '0';
                              resultField = null;
                              sign = '';
                              historyField = '';
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                        color: Color(0XFF262626),
                        child: Icon(
                          Icons.backspace,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            if (historyField.length != 0) {
                              if (inputField ==
                                  'Деление на ноль не поддерживается') {
                                inputField = '0';
                              } else {
                                if (inputField.length > 1) {
                                  inputField = inputField.substring(
                                      0, inputField.length - 1);
                                  historyField = historyField.substring(
                                      0, historyField.length - 1);
                                } else {
                                  inputField = '0';
                                  if (isDigit(historyField,
                                          historyField.length - 1) ==
                                      true) {
                                    historyField = historyField.substring(
                                        0, historyField.length - 1);
                                  }
                                }
                              }
                            }
                            print(resultField.toString());
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: MaterialButton(
                          color: Color(0xFF262626),
                          child: AutoSizeText(
                            '%',
                            style: TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: (32.0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (sign == '*' && counted == false) {
                                historyField = historyField.substring(
                                    0, historyField.length - inputField.length);
                                historyField +=
                                    (double.parse('$inputField') / 100)
                                        .toString();
                                resultField = resultField *
                                    (double.parse('$inputField') / 100);
                                counted = true;
                                if (resultField % 1 == 0) {
                                  inputField = resultField.toStringAsFixed(0);
                                } else {
                                  resultField = double.parse(
                                      resultField.toStringAsFixed(9));
                                  inputField = resultField.toString();
                                }
                              } else if (sign == '-' && counted == false) {
                                historyField = historyField.substring(
                                    0, historyField.length - inputField.length);
                                if (resultField *
                                        (double.parse('$inputField') / 100) %
                                        1 ==
                                    0) {
                                  historyField += (resultField *
                                          (double.parse('$inputField') / 100))
                                      .toStringAsFixed(0);
                                } else {
                                  historyField += (resultField *
                                          (double.parse('$inputField') / 100))
                                      .toStringAsFixed(9);
                                }
                                resultField = resultField -
                                    resultField *
                                        (double.parse('$inputField') / 100);
                                counted = true;
                                if (resultField % 1 == 0) {
                                  inputField = resultField.toStringAsFixed(0);
                                } else {
                                  resultField = double.parse(
                                      resultField.toStringAsFixed(9));
                                  inputField = resultField.toString();
                                }
                              } else if (sign == '+' && counted == false) {
                                historyField = historyField.substring(
                                    0, historyField.length - inputField.length);
                                if (resultField *
                                        (double.parse('$inputField') / 100) %
                                        1 ==
                                    0) {
                                  historyField += (resultField *
                                          (double.parse('$inputField') / 100))
                                      .toStringAsFixed(0);
                                } else {
                                  historyField += (resultField *
                                          (double.parse('$inputField') / 100))
                                      .toStringAsFixed(9);
                                }
                                resultField = resultField +
                                    resultField *
                                        (double.parse('$inputField') / 100);
                                counted = true;
                                if (resultField % 1 == 0) {
                                  inputField = resultField.toStringAsFixed(0);
                                } else {
                                  resultField = double.parse(
                                      resultField.toStringAsFixed(9));
                                  inputField = resultField.toString();
                                }
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    _button2('/'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _button('7'),
                    _button('8'),
                    _button('9'),
                    _button2('*'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _button('4'),
                    _button('5'),
                    _button('6'),
                    _button2('-'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _button('1'),
                    _button('2'),
                    _button('3'),
                    _button2('+'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: MaterialButton(
                          color: Color(0xFF262626),
                          child: AutoSizeText(
                            '000',
                            style: TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: (32.0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (inputField != '0') {
                                if (isDigit(historyField,
                                            historyField.length - 1) ==
                                        true ||
                                    '.'.compareTo(historyField[
                                            historyField.length - 1]) ==
                                        0) {
                                  inputField += '000';
                                  historyField += '000';
                                }
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    _button('0'),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: MaterialButton(
                          color: Color(0xFF262626),
                          child: AutoSizeText(
                            '.',
                            style: TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: (32.0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (!inputField.contains('.') &&
                                  inputField != '0' &&
                                  isDigit(historyField,
                                          historyField.length - 1) ==
                                      true) {
                                inputField += '.';
                                historyField += '.';
                              } else if (inputField == '0') {
                                inputField += '.';
                                historyField += '0.';
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: MaterialButton(
                          color: Color(0xFF262626),
                          child: AutoSizeText(
                            '=',
                            style: TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: (32.0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if ('.'.compareTo(
                                      inputField[inputField.length - 1]) ==
                                  0) {
                                inputField = inputField.substring(
                                    0, inputField.length - 1);
                                historyField = historyField.substring(
                                    0, historyField.length - 1);
                              }
                              if (isDigit(
                                      historyField, historyField.length - 1) ==
                                  true) {
                                if (historyField.contains('+') ||
                                    historyField.contains('-') ||
                                    historyField.contains('*') ||
                                    historyField.contains('/')) {
                                  if (historyField
                                          .replaceAll('-', '+')
                                          .replaceAll('*', '+')
                                          .replaceAll('/', '+')
                                          .split('+')
                                          .length >
                                      1) {
                                    if ('-'.compareTo(sign) == 0 &&
                                        counted == false) {
                                      resultField = resultField -
                                          double.parse('$inputField');
                                      counted = true;
                                      if (resultField % 1 == 0) {
                                        inputField =
                                            resultField.toStringAsFixed(0);
                                      } else {
                                        resultField = double.parse(
                                            resultField.toStringAsFixed(9));
                                        inputField = resultField.toString();
                                      }
                                    } else if ('+'.compareTo(sign) == 0 &&
                                        counted == false) {
                                      resultField = resultField +
                                          double.parse('$inputField');
                                      counted = true;
                                      if (resultField % 1 == 0) {
                                        inputField =
                                            resultField.toStringAsFixed(0);
                                      } else {
                                        resultField = double.parse(
                                            resultField.toStringAsFixed(9));
                                        inputField = resultField.toString();
                                      }
                                    } else if ('*'.compareTo(sign) == 0 &&
                                        counted == false) {
                                      resultField = resultField *
                                          double.parse('$inputField');
                                      counted = true;
                                      if (resultField % 1 == 0) {
                                        inputField =
                                            resultField.toStringAsFixed(0);
                                      } else {
                                        resultField = double.parse(
                                            resultField.toStringAsFixed(9));
                                        inputField = resultField.toString();
                                      }
                                    } else if ('/'.compareTo(sign) == 0 &&
                                        counted == false &&
                                        inputField != '0') {
                                      resultField = resultField /
                                          double.parse('$inputField');
                                      counted = true;
                                      if (resultField % 1 == 0) {
                                        inputField =
                                            resultField.toStringAsFixed(0);
                                      } else {
                                        resultField = double.parse(
                                            resultField.toStringAsFixed(9));
                                        inputField = resultField.toString();
                                      }
                                    }
                                  }
                                }
                              } else if (isDigit(
                                      historyField, historyField.length - 1) ==
                                  false) {
                                if ('/'.compareTo(sign) == 0 &&
                                    counted == false &&
                                    inputField == '0') {
                                  inputField =
                                      'Деление на ноль не поддерживается';
                                } else if ('*'.compareTo(sign) == 0 &&
                                    counted == false &&
                                    inputField == '0') {
                                  historyField += '0';
                                  inputField = '0';
                                  resultField = 0;
                                } else if ('-'.compareTo(sign) == 0 &&
                                    counted == false &&
                                    inputField == '0') {
                                  historyField += '0';
                                  if (resultField % 1 == 0) {
                                    inputField = resultField.toStringAsFixed(0);
                                  } else {
                                    resultField = double.parse(
                                        resultField.toStringAsFixed(9));
                                    inputField = resultField.toString();
                                  }
                                } else if ('+'.compareTo(sign) == 0 &&
                                    counted == false &&
                                    inputField == '0') {
                                  historyField += '0';
                                  if (resultField % 1 == 0) {
                                    inputField = resultField.toStringAsFixed(0);
                                  } else {
                                    resultField = double.parse(
                                        resultField.toStringAsFixed(9));
                                    inputField = resultField.toString();
                                  }
                                }
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
