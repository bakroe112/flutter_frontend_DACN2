import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:job_portal_app/config/constants.dart';

class CandidateService {
  // Lấy thông tin candidate
  Future<Map<String, dynamic>> getCandidate(int userId) async {
    final url = Uri.parse('${AppConfig.baseUrl}candidates/detail');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'user_id': userId}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error'};
    }
  }

  // Cập nhật thông tin candidate
  Future<Map<String, dynamic>> updateCandidate(Map<String, dynamic> data) async {
    final url = Uri.parse('${AppConfig.baseUrl}candidates/update');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error'};
    }
  }

  // Lấy danh sách candidates
  Future<Map<String, dynamic>> getCandidateList(int userId) async {
    final url = Uri.parse('${AppConfig.baseUrl}candidates/list');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'user_id': userId}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error connecting to server'};
    }
  }
}
