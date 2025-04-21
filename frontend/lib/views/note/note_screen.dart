import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/common/utils/api.dart';
import 'package:frontend/route/router_const.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final titleController = TextEditingController();
  final contentsController = TextEditingController();

  Future<void> submitNote() async {
    final response = await http.post(
      notesUrl, // iOS
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': titleController.text,
        'contents': contentsController.text,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('노트 등록 성공~~~')));
      context.go(RouteURL.noteList);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('에러: ${response.statusCode}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 100),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            TextField(
              controller: contentsController,
              decoration: InputDecoration(labelText: '내용'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitNote,
              child: Text('서버에 백엔드X. 누르지 말것!!'),
            ),
          ],
        ),
      ),
    );
  }
}
