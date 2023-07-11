import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translate_this/bloc.dart';
import 'package:translate_this/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          useMaterial3: true),
      title: 'MyApp',
      home: BlocProvider(
        // child: const QuizScreen(name: 'Camilo'),
        child: WelcomeScreen(),
        create: (context) => AppStateBloc(AppStateProps([], false, null)),
      ),
    );
  }
}
