import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/config/api.dart';
import 'package:frontend/common/utils/logger.dart';
import 'package:frontend/core/router/router_const.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

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
    NoteFetchStatus newStatus;

    try {
      final response = await http.get(notesUrl);

      if (response.statusCode == 200) {
        newNotes = jsonDecode(utf8.decode(response.bodyBytes));
        newStatus = NoteFetchStatus.success;
      } else {
        newStatus = NoteFetchStatus.error;
        logger.e('노트 불러오기 실패: ${response.statusCode}');
        // print('노트 불러오기 실패: ${response.statusCode}');
      }
    } catch (e, stack) {
      newStatus = NoteFetchStatus.error;
      // print('예외 발생: $e');
      logger.d('예외 발생', error: e, stackTrace: stack);
      // logger.e('로거 e test', error: e, stackTrace: stack);
      // logger.d('로거 d test', stackTrace: stack);
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
        children: [
          Center(child: Text('백엔드 연결 중... (TEST)')),
          Center(
            child: IconButton(
              onPressed: () {
                // context.go(RouteURL.noteCreate);
              },
              icon: Icon(Icons.chevron_right),
            ),
          ),
        ],
      );
    } else {
      if (notes.isEmpty) {
        body = const Center(child: Text('노트 없음'));
      } else {
        body = ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return ListTile(
              title: Text(note['title'] ?? ''),
              subtitle: Text(note['contents'] ?? ''),
            );
          },
        );
      }
    }

    return Scaffold(body: body);
  }
}
