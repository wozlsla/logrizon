import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/utils/logger.dart';
import 'package:frontend/config/env_config.dart';
import 'package:frontend/core/router/router.dart';
import 'package:go_router/go_router.dart';

void main() async {
  // URL과 내부 라우팅 동작 동기화 설정
  // GoRouter의 내부 API 동작(go()/push() 등)을 브라우저 URL에 반영
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // 환경 설정 (SECRET_KEY, API_URL 등)
  // await dotenv.load();
  await EnvConfig.loadEnv();

  // logger.i('디버깅 중');

  // 앱의 진입점 !! (FlutterEngine과 연결)
  runApp(
    // 전역에 Riverpod 상태관리 시스템을 적용점 (.watch(), .read() 하는 모든 Provider는 이 Scope 안에서 동작)
    ProviderScope(child: Logrizon()),
  );
}

class Logrizon extends ConsumerWidget {
  const Logrizon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // GoRouter를 사용하는 버전의 MaterialApp
    return MaterialApp.router(
      routerConfig: ref.watch(
        routerProvider, // GoRouter를 반환하는 Provider
      ), // routerConfig 기반으로 라우팅 (GoRouter용)
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.cyanAccent, // Color(0xFF209BC4)
          selectionColor: Colors.cyanAccent.withValues(alpha: 0.45),
        ),
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
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.cyanAccent,
          selectionColor: Colors.cyanAccent.withValues(alpha: 0.45),
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey[900]),
      ),
    );
  }
}
