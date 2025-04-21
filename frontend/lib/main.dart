import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/route/router.dart';
import 'package:go_router/go_router.dart';

void main() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;

  await dotenv.load();
  runApp(ProviderScope(child: Logrizon()));
}

class Logrizon extends ConsumerWidget {
  const Logrizon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
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
    );
  }
}
