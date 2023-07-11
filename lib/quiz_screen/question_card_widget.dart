import 'package:flutter/material.dart';

import '../models.dart';
import 'options_widget.dart';

class QuestionCardWidget extends StatelessWidget {
  final int indexToShow;
  final List<Question> fakeQuestions;
  const QuestionCardWidget(
      {super.key, required this.indexToShow, required this.fakeQuestions});

  List<Widget> getOptions(Question question) {
    List<Widget> widgetList = question.options.asMap().entries.map((entry) {
      int idx = entry.key;
      Options val = entry.value;
      return OptionsWidget(
        index: idx,
        option: val,
        key: UniqueKey(),
      );
    }).toList();

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.black, fontSize: 20),
        child: Column(
          children: [
            Text(fakeQuestions[indexToShow].questionText),
            ...getOptions(fakeQuestions[indexToShow])
          ],
        ),
      ),
    );
  }
}
