import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:portfolio/core/constants/globals.dart';
import 'package:portfolio/feature/emulator/presentation/widget/clean_app_bar.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'AC',
    '0',
    '.',
    '=',
  ];

  @override
  void initState() {
    Globals.isBackDisabled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const CleanAppBar(
        title: 'Calculator',
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Display
          Container(
            width: double.infinity,
            height: 120,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput.isEmpty ? ' ' : userInput,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          // Button grid
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.25,
                ),
                itemBuilder: (context, index) {
                  return _buildButton(buttonList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    final btnColor = _getBgColor(text);
    final txtColor = _getTextColor(text);

    return Material(
      color: btnColor,
      borderRadius: BorderRadius.circular(14),
      elevation: text == '=' ? 2 : 0,
      shadowColor: text == '=' ? Colors.teal.shade200 : Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          HapticFeedback.vibrate();
          setState(() {
            handleButtonPress(text);
          });
        },
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: txtColor,
              fontSize: 22,
              fontWeight: _isOperator(text) ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  handleButtonPress(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return;
      }
    }
    if (text == "=") {
      result = calculate();
      userInput = result;
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      return;
    }
    // Convert display × to *
    if (text == "×") {
      userInput = userInput + "*";
    } else {
      userInput = userInput + text;
    }
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }

  bool _isOperator(String text) {
    return ['/', '×', '+', '-', '=', 'C', 'AC', '(', ')'].contains(text);
  }

  Color _getBgColor(String text) {
    if (text == "AC" || text == "C") {
      return Colors.red.shade50;
    }
    if (text == "=") {
      return Colors.teal.shade600;
    }
    if (_isOperator(text)) {
      return Colors.blue.shade50;
    }
    return Colors.white;
  }

  Color _getTextColor(String text) {
    if (text == "AC" || text == "C") {
      return Colors.red.shade600;
    }
    if (text == "=") {
      return Colors.white;
    }
    if (_isOperator(text)) {
      return Colors.blue.shade700;
    }
    return Colors.black87;
  }

  @override
  void dispose() {
    Globals.isBackDisabled = true;
    super.dispose();
  }
}
