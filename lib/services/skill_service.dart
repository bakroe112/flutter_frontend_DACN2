import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:job_portal_app/config/constants.dart';
import 'package:job_portal_app/models/skill.dart';

class SkillService {
  // Lấy danh sách kỹ năng của user
  Future<List<Skill>> getUserSkills(int userId) async {
    final url = Uri.parse('${AppConfig.baseUrl}skills/user');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'user_id': userId}),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result['success']) {
        return (result['skill_list'] as List)
            .map((skill) => Skill.fromJson(skill))
            .toList();
      }
    }
    return [];
  }

  // Cập nhật kỹ năng
  Future<Map<String, dynamic>> updateUserSkills(
    int userId,
    List<String> skillList,
  ) async {
    final url = Uri.parse('${AppConfig.baseUrl}skills/update');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'user_id': userId, 'skill_list': skillList}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error'};
    }
  }
}
