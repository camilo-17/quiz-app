import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';
import '../models.dart';

class OptionsWidget extends StatelessWidget {
  final int index;
  final Options option;
  OptionsWidget({
    super.key,
    required this.index,
    required this.option,
  });

  Color backgroundContainerColor = Colors.white;
  Color textContainerColor = Colors.grey;
  Color? circleColor;
  IconData? iconContainer;

  @override
  Widget build(BuildContext context) {
    int newIndex = index + 1;
    return BlocBuilder<AppStateBloc, AppStateProps>(
        builder: (context, appSettingsProps) {
      if (appSettingsProps.selectedOption != null && option.isCorrect) {
        correctChoises();
      } else if (appSettingsProps.selectedOption != null &&
          option == appSettingsProps.selectedOption) {
        inCorrectChoises();
      }
      return GestureDetector(
        onTap: () => showCorrectOption(context, appSettingsProps, option),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: backgroundContainerColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$newIndex. ${option.statement}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textContainerColor),
                    ),
                    Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                          color: circleColor,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: textContainerColor)),
                      child: iconContainer == null
                          ? null
                          : Icon(
                              iconContainer,
                              color: Colors.white,
                            ),
                    )
                  ]),
            ),
          ),
        ),
      );
    });
  }

  void correctChoises() {
    backgroundContainerColor = const Color.fromARGB(255, 192, 237, 215);
    textContainerColor = Colors.green;
    circleColor = Colors.green;
    iconContainer = Icons.check;
  }

  void inCorrectChoises() {
    backgroundContainerColor = const Color.fromARGB(255, 225, 174, 174);
    textContainerColor = Colors.red;
    circleColor = Colors.red;
    iconContainer = Icons.cancel_sharp;
  }

  void showCorrectOption(
      BuildContext context, AppStateProps appStateProps, Options option) {
    var appStateBloc = context.read<AppStateBloc>();
    appStateProps.points.add(option.isCorrect);
    appStateProps.selectedOption = option;
    appStateBloc.add(const SetPointsEvent());
  }
}
