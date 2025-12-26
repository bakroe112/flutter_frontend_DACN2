import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_portal_app/config/constants.dart';

class AIService {
  // Chat với AI tư vấn nghề nghiệp
  Future<Map<String, dynamic>> chatWithAI(
    String message, {
    int candidateId = 0,
    List<Map<String, dynamic>>? chatHistory,
  }) async {
    final url = Uri.parse('${AppConfig.baseUrl}chatbot/career');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'message': message,
        'chat_history': chatHistory ?? [],
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error'};
    }
  }
}
