import 'package:flutter/material.dart';
import 'package:frontend/views/home_screen.dart';

void main() {
  runApp(const Logrizon());
}

class Logrizon extends StatelessWidget {
  const Logrizon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          // surfaceTintColor: Colors.white, // ?
        ),
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.transparent),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF121212),
        appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey[900]),
      ),
      home: HomeScreen(),
    );
  }
}
