import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

class InformationCard extends StatelessWidget {
  final bool isCorrectQuestion;
  const InformationCard({super.key, required this.isCorrectQuestion});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppStateBloc, AppStateProps>(
        builder: (context, appSettingsProps) {
      return Container(
        width: double.infinity,
        height: 43,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              isCorrectQuestion ? "Bien hecho!" : "No es la opción correcta",
              // textAlign: TextAlign.center,
              style: TextStyle(
                  color: isCorrectQuestion ? Colors.green : Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Icon(
                isCorrectQuestion ? Icons.check_circle : Icons.cancel_outlined,
                color: isCorrectQuestion ? Colors.green : Colors.red,
              ),
            )
          ],
        ),
      );
    });
  }
}
