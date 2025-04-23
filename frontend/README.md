# frontend

A new Flutter project.
</br>

## Flows

```
main.dart
  └── Logrizon (App 클래스: 진입점)
        └── MaterialApp.router(routerConfig: ...)
              └── GoRouter(routerProvider)
                    └── StatefulShellRoute (탭 구조)
                          └── EntryPoint(navigationShell)
                                ├── didChangeDependencies()
                                │     └── navigationShell.currentIndex → tabIndexProvider에 동기화 (url)
                                ├── ref.watch(tabIndexProvider) ← 탭 상태 읽기
                                └── BottomNavigationBar(onTap: onTap)
                                        └── onTap(index)
                                              ├── ref.read(tabIndexProvider).state = index ← 탭 상태 업데이트
                                              └── navigationShell.goBranch(index) ← 실제 화면 전환
```

## Structure

```
.
├── main.dart
├── providers
├── route
├── common
│   ├── utils
│   │   └── api.dart
│   └── widgets
│       └── bottom_nav_bar.dart
└── views
    ├── entrypoint
    │   └── entrypoint.dart
    ├── home
    │   └── home_screen.dart
    └── note
        ├── note_list_screen.dart
        └── note_screen.dart
```
