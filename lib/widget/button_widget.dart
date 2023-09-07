import 'package:calculator/res/color.dart';
import 'package:calculator/res/dimens.dart';
import 'package:calculator/utils/math_utils.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final VoidCallback onClickedLong;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    required this.onClickedLong,
  }) : super(key: key);

  Color _getBackgroundTextColor(String buttonText) {
    switch (buttonText) {
      case '+':
      case '-':
      case '⨯':
      case '÷':
      case '=':
        return ColorResources.textSecondary;
      case 'AC':
      case '<':
        return ColorResources.textPrimary;
      default:
        return ColorResources.textPrimaryLight;
    }
  }

  Color _getTextColor(String buttonText) {
    switch (buttonText) {
      case 'AC':
      case '<':
        return Colors.white;
      default:
        return ColorResources.defaultFontColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double fontSize = MathUtils.isOperator(text, hasEquals: true) ? Dimens.fontSizeDefault : Dimens.fontSizeSmall;
    final style = TextStyle(
      color: _getTextColor(text),
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );

    return Expanded(
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.all(Dimens.paddingSmall),
        child: ElevatedButton(
          onPressed: onClicked,
          onLongPress: onClickedLong,
          style: ElevatedButton.styleFrom(
            backgroundColor: _getBackgroundTextColor(text),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.buttonCircular),
            ),
          ),
          child: text == '<'
              ? const Icon(Icons.backspace_outlined, color: Colors.white)
              : Text(text, style: style),
        ),
      ),
    );
  }
}
