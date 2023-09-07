import 'package:calculator/res/color.dart';
import 'package:calculator/res/dimens.dart';
import 'package:calculator/state/calculator_notifier.dart';
import 'package:calculator/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  final String title;

  const MainPage({super.key, required this.title});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  late CalculatorNotifier calculator;

  Widget _buildResult() {
    return Consumer(
      builder: (context, watch, child) {
        final state = watch.watch(calculatorProvider);
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                state.equation,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey, fontSize: 36, height: 1),
              ),
              const SizedBox(height: 24),
              Text(
                state.result,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtons() {
    return Container(
      padding: const EdgeInsets.all(Dimens.paddingPage),
      decoration: const BoxDecoration(color: ColorResources.background),
      child: Column(
        children: <Widget>[
          _buildButtonRow('AC', '<', '', '÷'),
          _buildButtonRow('7', '8', '9', '⨯'),
          _buildButtonRow('4', '5', '6', '-'),
          _buildButtonRow('1', '2', '3', '+'),
          _buildButtonRow('0', '.', '', '='),
        ],
      ),
    );
  }

  Widget _buildButtonRow(
    String first,
    String second,
    String third,
    String fourth,
  ) {
    List<String> row = [first, second, third, fourth];

    return Expanded(
      child: Row(
        children: row
            .map((text) => ButtonWidget(
                  text: text,
                  onClicked: () => _onClickedButton(text),
                  onClickedLong: () => _onLongClickedButton(text),
                ))
            .toList(),
      ),
    );
  }

  void _onClickedButton(String buttonText) {
    switch (buttonText) {
      case 'AC':
        calculator.reset();
        break;
      case '=':
        calculator.equals();
        break;
      case '<':
        calculator.delete();
        break;
      default:
        calculator.append(buttonText);
        break;
    }
  }

  void _onLongClickedButton(String text) {
    if (text == '<') {
      calculator.reset();
    }
  }

  @override
  void initState() {
    super.initState();

    calculator = ref.read(calculatorProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.buttonPrimary,
        title: Container(
          margin: const EdgeInsets.only(left: 8),
          child: Text(widget.title),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: _buildResult()),
            Expanded(flex: 2, child: _buildButtons()),
          ],
        ),
      ),
    );
  }
}
