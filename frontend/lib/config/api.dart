import 'package:frontend/config/env_config.dart';

final notesUrl = Uri.parse('${EnvConfig.apiUrl}/notes/'); // iOS

final generateSentenceUrl = Uri.parse(
  '${EnvConfig.fastApiUrl}/generate-sentence',
);
