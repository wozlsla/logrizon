import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/utils/logger.dart';
import 'package:frontend/route/router.dart';
import 'package:go_router/go_router.dart';

void main() async {
  // URL과 내부 라우팅 동작 동기화 설정
  // GoRouter의 내부 API 동작(go()/push() 등)을 브라우저 URL에 반영
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // 환경 설정 (SECRET_KEY, API_URL 등)
  await dotenv.load();

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
