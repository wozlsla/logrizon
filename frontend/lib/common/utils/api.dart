import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:8000/api/v1';

final notesUrl = Uri.parse('$baseUrl/notes/');
