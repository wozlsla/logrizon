import 'package:flutter/material.dart';
import 'package:frontend/common/utils/logger.dart';
import 'package:frontend/views/note/note_service.dart';

enum NoteFetchStatus { loading, success, error }

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List notes = [];
  NoteFetchStatus status = NoteFetchStatus.loading; // 초기화

  Future<void> fetchNotes() async {
    List newNotes = [];
    NoteFetchStatus newStatus = NoteFetchStatus.loading;

    try {
      newNotes = await NoteService.fetchNotes();
      newStatus = NoteFetchStatus.success;
    } catch (e, stack) {
      logger.d('예외 발생', error: e, stackTrace: stack);
      newStatus = NoteFetchStatus.error;
    }

    setState(() {
      notes = newNotes;
      status = newStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (status == NoteFetchStatus.loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (status == NoteFetchStatus.error) {
      body = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: Text('서버 연결 중... (TEST)'))],
      );
    } else {
      if (notes.isEmpty) {
        body = const Center(child: Text('노트 없음'));
      } else {
        body = ListView.separated(
          separatorBuilder:
              (context, index) => Divider(thickness: 0.4, indent: 20.0),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return ListTile(
              title: Text(
                note['contents'] ?? '',
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            );
          },
        );
      }
    }

    return Scaffold(appBar: AppBar(title: Text('Notes')), body: body);
  }
}
