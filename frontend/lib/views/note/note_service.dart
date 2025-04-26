import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frontend/config/api.dart';

class NoteService {
  /// 노트 리스트 불러오기 (GET)
  static Future<List<dynamic>> fetchNotes() async {
    final response = await http.get(notesUrl);
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to fetch notes (${response.statusCode})');
    }
  }

  /// 노트 등록 (POST)
  static Future<http.Response> submitNote({
    required Uri url,

    required String contents,
  }) async {
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'contents': contents}),
    );
  }
}
