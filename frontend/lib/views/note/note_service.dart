import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:frontend/config/api.dart';

class NoteService {
  /// 노트 리스트 불러오기 (GET)
  static Future<List<dynamic>> fetchNotes() async {
    try {
      final response = await http.get(notesUrl);

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(utf8.decode(response.bodyBytes));
          if (data is List) {
            return data;
          } else {
            throw Exception('서버 응답이 올바른 형식(List)이 아닙니다.');
          }
        } catch (e) {
          throw Exception('응답 파싱 실패: $e');
        }
      } else {
        // 서버 에러 (400,500)
        throw HttpException('노트 불러오기 실패: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      // 네트워크 통신 실패
      throw Exception('서버 연결 실패: $e');
    } catch (e) {
      // 기타 예상치 못한 에러
      throw Exception('알 수 없는 오류(fetchNotes): $e');
    }
  }

  /// 노트 등록 (POST)
  static Future<http.Response> submitNote({
    required Uri url,
    required String contents,
  }) async {
    try {
      final response = await http.post(
        notesUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'contents': contents}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw HttpException('노트 등록 실패: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('서버 연결 실패: $e');
    } catch (e) {
      throw Exception('알 수 없는 오류(submitNote): $e');
    }
  }
}

// /// HTTP 관련 에러를 구분하기 위한 커스텀 예외
// class HttpException implements Exception {
//   final String message;
//   HttpException(this.message);

//   @override
//   String toString() => "HttpException: $message";
// }
