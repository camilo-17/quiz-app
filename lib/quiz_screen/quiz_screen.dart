import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translate_this/bloc.dart';
import 'package:translate_this/models.dart';
import 'package:translate_this/quiz_screen/information_card.dart';
import 'package:translate_this/quiz_screen/podium_widget.dart';
import 'package:translate_this/quiz_screen/question_card_widget.dart';

import 'loader_widget.dart';

final List<Question> fakeQuestions = [
  Question(1, "¿Cuál es el río más largo del mundo? ", [
    Options("1", "Nilo", false),
    Options("2", "Amazonas", true),
    Options("3", "Misisipi", false),
    Options("4", "Ganges", false),
  ]),
  Question(2, "¿Cuál es el océano más grande del mundo? ", [
    Options("1", "océano Pacífico", true),
    Options("2", "océano Atlantico", false),
    Options("3", "océano Indico", false),
    Options("4", "océano Artico", false),
  ]),
  Question(1, "¿Quién es el autor de el Quijote?", [
    Options("1", "Gabriel García Márquez", false),
    Options("2", "Oscar Wilde", false),
    Options("3", "Miguel de Cervantes", true),
    Options("4", "Edgar Allan Poe", false),
  ]),
  Question(2, "¿En qué año comenzó la II Guerra Mundial? ", [
    Options("1", "1939", true),
    Options("2", "1918", false),
    Options("3", "1940", false),
    Options("4", "1942", false),
  ]),
  Question(1, "¿Cuál es el primero de la lista de los números primos?", [
    Options("1", "2", true),
    Options("2", "3", false),
    Options("3", "5", false),
    Options("4", "11", false),
  ]),
  Question(2, "¿Cuánto dura un partido de fútbol?", [
    Options("1", "100 minutos", false),
    Options("2", "90 minutos", true),
    Options("3", "110 minutos", false),
    Options("4", "230 minutos", false),
  ]),
];

class QuizScreen extends StatefulWidget {
  final String name;
  final BuildContext blocContext;

  static MaterialPageRoute<void> route(BuildContext context, String name) =>
      MaterialPageRoute(
        builder: (_) => QuizScreen(
          blocContext: context,
          name: name,
        ),
      );

  const QuizScreen({super.key, required this.name, required this.blocContext});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  bool showNextScreen = false;
  bool showNextScreenafterAnimation = false;
  late final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  )..addListener(() {
      if (controller.isCompleted) {
        if (showNextScreen) {
          showNextScreenafterAnimation = true;
        }
        setState(() {});
      }
    });

  late Animation<Offset> offsetAnimation = getOffset(true);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Animation<Offset> getOffset(bool isInit) {
    if (isInit) {
      controller.duration = const Duration(milliseconds: 300);
    } else {
      controller.duration = const Duration(seconds: 2);
    }
    return Tween<Offset>(
      begin: isInit ? const Offset(-1.5, 0.0) : Offset.zero,
      end: isInit ? Offset.zero : const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInExpo,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppStateBloc>(
      // Use existing BLoC instead of creating a new one
      create: (_) => BlocProvider.of<AppStateBloc>(widget.blocContext),
      child: BlocBuilder<AppStateBloc, AppStateProps>(
          builder: (context, appSettingsProps) {
        int indexToShow = 0;
        bool showQuestions = true;

        //Estado: cuando la app ya debe mostrar la siguiente pregunta;
        if (appSettingsProps.selectedOption == null) {
          indexToShow = appSettingsProps.points.length;
          showNextScreen = false;
        } else {
          //Estado: cuando el usuario ya respondio la pregunta
          //y se le muestra las respuestas correctas, luego se realiza la transicion
          //para que la pregunta salga de la pantalla
          indexToShow = appSettingsProps.points.length - 1;
          offsetAnimation = getOffset(false);
          controller.reset();
          controller.forward();
          showNextScreen = true;
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => sleep(const Duration(milliseconds: 500)));
        }
        if (fakeQuestions.length == appSettingsProps.points.length &&
            appSettingsProps.selectedOption == null) {
          showQuestions = false;
        }

        if (indexToShow == 0) {
          controller.forward();
        }

//Estado: cuando las respuestas correctas ya fueron mostradas se realiza la transicion a la siguiente pregunta
        if (showNextScreenafterAnimation) {
          var appStateBloc = context.read<AppStateBloc>();
          appSettingsProps.selectedOption = null;
          appStateBloc.add(const SetPointsEvent());
          offsetAnimation = getOffset(true);
          controller.reset();
          controller.forward();
          showNextScreenafterAnimation = false;
        }

        return Scaffold(
            appBar: AppBar(
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    "Skip",
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.deepPurple,
                    Colors.blueAccent,
                  ],
                )),
                padding: const EdgeInsets.all(15),
                child: DefaultTextStyle(
                    style: const TextStyle(color: Colors.white),
                    child: showQuestions
                        ? Column(
                            children: [
                              appSettingsProps.selectedOption == null
                                  ? LoaderWidget(
                                      start: controller.isCompleted,
                                      key: UniqueKey(),
                                    )
                                  : InformationCard(
                                      isCorrectQuestion: appSettingsProps
                                          .selectedOption!.isCorrect),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  " ${widget.name}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              Text(
                                "Pregunta ${indexToShow + 1}/${fakeQuestions.length}",
                                style: const TextStyle(fontSize: 35),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              SlideTransition(
                                position: offsetAnimation,
                                child: QuestionCardWidget(
                                    indexToShow: indexToShow,
                                    fakeQuestions: fakeQuestions),
                              )
                            ],
                          )
                        : PodiumWidget(points: appSettingsProps.points)),
              ),
            ));
      }),
    );
  }
}
