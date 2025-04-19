import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/common/utils/api.dart';
import 'package:http/http.dart' as http;

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List notes = [];

  Future<void> fetchNotes() async {
    final response = await http.get(notesUrl);

    if (response.statusCode == 200) {
      setState(() {
        notes = jsonDecode(utf8.decode(response.bodyBytes));
      });
    } else {
      print('노트 불러오기 실패: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          notes.isEmpty
              ? Center(child: Text('노트 없음'))
              : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return ListTile(
                    title: Text(note['title'] ?? ''),
                    subtitle: Text(note['contents'] ?? ''),
                  );
                },
              ),
    );
  }
}
