import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/router/router_const.dart';
import 'package:frontend/views/entrypoint/entrypoint.dart';
import 'package:frontend/views/home/home_screen.dart';
import 'package:frontend/views/profile/profile_screen.dart';
import 'package:go_router/go_router.dart';

// Flutter의 라우팅 -> Navigator (Key로 식별)
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

// main의 routerConfig에 반환되는 provider
final routerProvider = Provider((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey, // 키 등록
    initialLocation: RouteURL.home,
    routes: [
      // Tab 기반 앱에 최적화된 라우팅 구조 (Stack에 유지 - dispose 안 됨)
      StatefulShellRoute.indexedStack(
        // navigationShell: 각 탭과 연결된 라우터 제어 객체
        builder: (context, state, navigationShell) {
          return EntryPoint(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteURL.home,
                builder: (context, state) => HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/noop', // 쓰지 않는 경로
                builder: (context, state) => const SizedBox.shrink(), // 빈 화면
                // path: RouteURL.noteCreate,
                // builder: (context, state) => NoteScreen(),
                // routes: [
                //   // 서브 라우팅 (Nested Route) - 같은 탭 내 하위 화면 구성
                //   GoRoute(
                //     path: 'create',
                //     name: RouteName.noteList,
                //     builder: (context, state) => NoteListScreen(),
                //   ),
                // ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteURL.profile,
                builder: (context, state) => ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
