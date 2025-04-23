import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/tab_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/common/widgets/bottom_nav_bar.dart';

class EntryPoint extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const EntryPoint({super.key, required this.navigationShell});

  @override
  ConsumerState<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends ConsumerState<EntryPoint> {
  // 라우터 상태와 Provider 상태를 동기화 (현재 탭 인덱스를 Provider에 반영)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // URL로 접근한 경우에도 탭 인덱스를 현재 shell index로 동기화 (초기값 0)
    ref.read(tabIndexProvider.notifier).state =
        widget.navigationShell.currentIndex;
  }

  void onTap(int index) {
    // 이미 현재 선택된 탭을 또 누르면 goBranch()를 호출 X
    if (index == widget.navigationShell.currentIndex) return;

    // 탭 상태 업데이트 (index: icon)
    ref.read(tabIndexProvider.notifier).state = index;
    // 화면 전환
    widget.navigationShell.goBranch(index, initialLocation: false);
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(tabIndexProvider);

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex, // from tabIndexProvider
        onTap: onTap, // index: icon
      ),
    );
  }
}
