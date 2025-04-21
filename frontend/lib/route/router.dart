import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/route/router_const.dart';
import 'package:frontend/views/entrypoint/entrypoint.dart';
import 'package:frontend/views/home/home_screen.dart';
import 'package:frontend/views/note/note_list_screen.dart';
import 'package:frontend/views/note/note_screen.dart';
import 'package:frontend/views/note/temp_screen.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteURL.home,
    routes: [
      StatefulShellRoute.indexedStack(
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
                path: RouteURL.noteList,
                builder: (context, state) => NoteListScreen(),
                routes: [
                  GoRoute(
                    path: 'create',
                    name: RouteName.noteCreate,
                    builder: (context, state) => NoteScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteURL.temp,
                builder: (context, state) => TempScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
