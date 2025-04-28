import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/widgets/write_form.dart';
import 'package:frontend/config/api.dart';
import 'package:frontend/common/utils/logger.dart';
import 'package:frontend/providers/tab_provider.dart';
import 'package:frontend/providers/text_draft_provider.dart';
import 'package:frontend/views/note/gpt_service.dart';
import 'package:frontend/views/note/note_service.dart';

class NoteScreen extends ConsumerStatefulWidget {
  const NoteScreen({super.key});

  @override
  ConsumerState<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends ConsumerState<NoteScreen>
    with SingleTickerProviderStateMixin {
  late final TextEditingController noteController;
  late final TextEditingController dailyController;
  late TabController _tabController;
  final gptService = GptService();

  Future<void> submitNote() async {
    final currentTabIndex = ref.read(noteTabIndexProvider);
    final isNoteTab = currentTabIndex == 0;
    final contents =
        isNoteTab ? noteController.text.trim() : dailyController.text.trim();

    // 유효성 검사
    if (contents.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('유효하지 않은 값입니다.')));
      return;
    }

    // 예외 처리
    try {
      await NoteService.submitNote(
        url: notesUrl, // Uri 객체
        contents: contents,
      );

      if (!mounted) return;

      // 입력 필드, Provider 초기화 -> note/daily 분리 필요
      noteController.clear();
      dailyController.clear();
      ref.read(noteDraftProvider.notifier).state = '';
      ref.read(dailyDraftProvider.notifier).state = '';

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('등록되었습니다.')));
      Navigator.pop(context);
    } on HttpException catch (e) {
      // 서버가 400, 500 응답을 내려준 경우
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('문제가 발생했습니다. 잠시 후 다시 시도해주세요.')));
      logger.e('서버 에러', error: e.message);
    } catch (e) {
      // 서버 통신 자체 실패, 기타 예상치 못한 에러 (인터넷 끊김, 서버 다운, JSON 파싱 에러 등)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('문제가 발생했습니다. 잠시 후 다시 시도해주세요.')),
      );
      logger.e('통신 에러 또는 예외 발생', error: e);
    }
  }

  Future<void> _generateSentence() async {
    try {
      final sentence = await gptService.fetchGeneratedSentence();

      if (!mounted) {
        // draftContainer 먼저 업데이트 (mounted 관계 없음)
        draftContainer.read(dailyDraftProvider.notifier).state = '$sentence\n';
        return;
      }

      // 위젯 관련은 mounted 이후에만
      ref.read(dailyDraftProvider.notifier).state = '$sentence\n';
      dailyController.text = '$sentence\n';
    } catch (e) {
      logger.d('GPT 문장 생성 실패: $e');
    }
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();

    noteController = TextEditingController(text: ref.read(noteDraftProvider));

    // ProviderContainer에서 초기값 불러와서 Controller 생성
    dailyController = TextEditingController(
      text: draftContainer.read(dailyDraftProvider),
    );

    noteController.addListener(() {
      ref.read(noteDraftProvider.notifier).state = noteController.text;
    });

    dailyController.addListener(() {
      final text = dailyController.text;
      ref.read(dailyDraftProvider.notifier).state = text; // provider 업데이트
      draftContainer.read(dailyDraftProvider.notifier).state =
          text; // container 업데이트
    });

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: ref.read(noteTabIndexProvider), // default 0
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        ref.read(noteTabIndexProvider.notifier).state = _tabController.index;
      }
    });
  }

  @override
  void dispose() {
    noteController.dispose();
    dailyController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.black.withValues(alpha: 0.7),
        body: Center(
          child: GestureDetector(
            onTap: _onScaffoldTap,
            child: Container(
              width: 340, // 수정
              height: 450, // 수정
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.blue[600]?.withValues(alpha: 0.5),
                // color: Colors.teal[700]?.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.cyanAccent, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withValues(alpha: 0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.all(4),
                color: Color(0xFF209BC4).withValues(alpha: 0.4),
                // color: Color(0xff0095F6).withValues(alpha: 0.2), // verified bedge color
                // color: Colors.blue[600]?.withValues(alpha: 0.4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 0,
                  ),
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                        padding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey[400],
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.cyanAccent,
                          ),
                          insets: EdgeInsets.symmetric(
                            horizontal: -60.0, // 90
                          ),
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              'Note',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Daily',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      _GetButton(onGenerate: _generateSentence),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            WriteForm(
                              contentsController: noteController,
                              onSubmit: submitNote,
                            ),
                            WriteForm(
                              contentsController: dailyController,
                              onSubmit: submitNote,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GetButton extends ConsumerWidget {
  final VoidCallback onGenerate;

  const _GetButton({super.key, required this.onGenerate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTabIndex = ref.watch(noteTabIndexProvider);

    if (currentTabIndex != 1) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onGenerate,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '[GET]',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
