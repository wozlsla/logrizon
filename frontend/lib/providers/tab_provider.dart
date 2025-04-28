import 'package:flutter_riverpod/flutter_riverpod.dart';

/// EntryPoint 바텀 탭 인덱스
final tabIndexProvider = StateProvider<int>((ref) => 0);

/// NoteScreen 내부 탭 인덱스 상태: 0 = Note, 1 = Daily
final noteTabIndexProvider = StateProvider<int>((ref) => 0);
