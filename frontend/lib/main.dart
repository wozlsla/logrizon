import 'package:flutter/material.dart';

void main() {
  runApp(const Logrizon());
}

class Logrizon extends StatelessWidget {
  const Logrizon({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(appBar: AppBar(title: Text("Logrizon"))),
    );
  }
}
