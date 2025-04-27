import 'dart:convert';

import 'package:frontend/config/api.dart';
import 'package:http/http.dart' as http;

class GptService {
  Future<String> fetchGeneratedSentence() async {
    try {
      final response = await http.post(
        generateSentenceUrl,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // final Map<String, dynamic> data = jsonDecode(response.body);
        final Map<String, dynamic> data = jsonDecode(
          utf8.decode(response.bodyBytes),
        ); // utf8 디코딩
        return data['sentence'] ?? '문장 가져오기 실패..';
      } else {
        throw Exception('서버 응답 오류: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('문장 가져오기 실패: $e');
    }
  }
}
