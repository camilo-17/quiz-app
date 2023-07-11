import 'package:flutter/material.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  bool startAnimation = false;
  TextEditingController toTranslateText = TextEditingController();
  String currentTranslation = "";

  @override
  void initState() {
    super.initState();
    // Timer.periodic(const Duration(seconds: 2), (timer) {
    //   setState(() {
    //     startAnimation = !startAnimation;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          // const Text("Que deseas traducir"),
          TextField(
            controller: toTranslateText,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Que deseas traducir"),
          ),
          Container(
              margin: const EdgeInsets.only(top: 15),
              child: FilledButton(
                  onPressed: () {
                    goToTranslate();
                  },
                  child: const Text("Traducir"))),
          AnimatedAlign(
            alignment: startAnimation ? Alignment.topLeft : Alignment.topCenter,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(15),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Text(currentTranslation),
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.edit_road),
          )
        ],
      ),
    );
  }

  void goToTranslate() {
    // var textToTranslate = toTranslateText.text;
    // var translation = ApiClient().translate(textToTranslate);

    setState(() {
      // currentTranslation = translation;
    });
  }
}
