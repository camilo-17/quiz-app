import 'dart:async';

import 'package:flutter/material.dart';

class PodiumWidget extends StatefulWidget {
  final List<bool> points;

  const PodiumWidget({super.key, required this.points});

  @override
  State<PodiumWidget> createState() => _PodiumWidgetState();
}

class _PodiumWidgetState extends State<PodiumWidget> {
  @override
  double height = 0.0;
  int finalPoints = 0;
  @override
  void initState() {
    finalPoints = widget.points.map((e) => e).toList().length * 100;
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        height = 400;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: double.infinity,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$finalPoints puntos",
                style: const TextStyle(color: Colors.black, fontSize: 30),
              ),
              Image.network(
                  "https://images.emojiterra.com/google/noto-emoji/unicode-15/color/512px/1f3c6.png")
            ],
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Row(
              children: [
                Column(
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/avatar1.png',
                      width: 100,
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      margin: const EdgeInsets.only(top: 10),
                      width: 75,
                      height: height,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: const Text(
                        "2",
                        style: TextStyle(color: Colors.black, fontSize: 60),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Spacer(),
                    Text(
                      "Ganador",
                      style: TextStyle(fontSize: 25, color: Colors.amber[700]),
                    ),
                    Image.asset(
                      'assets/avatar2.png',
                      width: 100,
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      margin: const EdgeInsets.only(top: 10),
                      width: 75,
                      height: height + 100,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: const Text(
                        "1",
                        style: TextStyle(color: Colors.black, fontSize: 60),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/avatar3.png',
                      width: 100,
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      margin: const EdgeInsets.only(top: 10),
                      width: 75,
                      height: height,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: const Text(
                        "3",
                        style: TextStyle(color: Colors.black, fontSize: 60),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
