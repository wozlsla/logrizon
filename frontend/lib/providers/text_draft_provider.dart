import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteDraftProvider = StateProvider<String>((ref) => '');
final dailyDraftProvider = StateProvider<String>((ref) => '');

/// 앱 전역에서 draft를 관리할 ProviderContainer
final draftContainer = ProviderContainer();

// final dailyDraftProvider = StateProvider<String>((ref) {
//   ref.keepAlive();
//   return '';
// });
