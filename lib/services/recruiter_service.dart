import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:job_portal_app/config/constants.dart';
import 'package:job_portal_app/models/recruiter.dart';

class RecruiterService {

  // Lấy danh sách tất cả recruiters
  Future<List<Recruiter>> getAllRecruiters() async {
    final url = Uri.parse(
      '${AppConfig.baseUrl}recruiters/all',
    );

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success']) {
        return (result['data'] as List)
            .map((recruiter) => Recruiter.fromJson(recruiter))
            .toList();
      }
    }
    return [];
  }

  // Lấy thông tin recruiter
  Future<Map<String, dynamic>> getRecruiter(int userId) async {
    final url = Uri.parse('${AppConfig.baseUrl}recruiters/detail');

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

  // Cập nhật thông tin recruiter
  Future<Map<String, dynamic>> updateRecruiter(
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse(
      '${AppConfig.baseUrl}recruiters/update',
    );

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
}
