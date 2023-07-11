import 'package:flutter/material.dart';
import 'package:translate_this/quiz_screen/quiz_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  void _handleItemPressed(BuildContext context, String name) {
    Navigator.of(context).push(QuizScreen.route(context, name));
  }

  TextEditingController nameText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.deepPurple,
              Colors.blueAccent,
            ],
          )),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  "Vamos a comenzar",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: const Text(
                    "Por favor digita tu nombre",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                TextField(
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  decoration: const InputDecoration(),
                  controller: nameText,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  // height: 44.0,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                          colors: [Colors.greenAccent, Colors.green])),
                  child: ElevatedButton(
                    onPressed: () {
                      _handleItemPressed(context, nameText.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Text(
                      'Comenzar',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
