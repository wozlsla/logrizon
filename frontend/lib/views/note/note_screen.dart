import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/widgets/write_form.dart';
import 'package:frontend/config/api.dart';
import 'package:frontend/common/utils/logger.dart';
import 'package:frontend/providers/tab_provider.dart';
import 'package:frontend/views/note/note_service.dart';

class NoteScreen extends ConsumerStatefulWidget {
  const NoteScreen({super.key});

  @override
  ConsumerState<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends ConsumerState<NoteScreen> {
  final noteController = TextEditingController();
  final dailyController = TextEditingController();

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

    // http 예외 처리
    try {
      final response = await NoteService.submitNote(
        url: notesUrl, // Uri 객체
        contents: contents,
      );

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('등록되었습니다.')));
        // context.go(RouteURL.noteList);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('에러: ${response.statusCode}')));
      }
    } catch (e) {
      logger.e('http 예외 발생', error: e);
    }
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    noteController.dispose();
    dailyController.dispose();
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
              // padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.blue[600]?.withValues(alpha: 0.5),
                // color: Colors.teal[700]?.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
                // border: Border.all(color: Colors.cyanAccent, width: 2),
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
                margin: EdgeInsets.all(10),
                color: Colors.blue[600]?.withValues(alpha: 0.4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 0,
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          onTap: (index) {
                            ref.read(noteTabIndexProvider.notifier).state =
                                index;
                          },
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
                              // width: 1.0,
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
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Daily',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            // Tab(text: 'Daily'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
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
      ),
    );
  }
}
