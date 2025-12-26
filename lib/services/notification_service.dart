import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_portal_app/config/constants.dart';

class NotificationService {
  // Thêm thông báo mới
  Future<Map<String, dynamic>> addNotification(
    int userId,
    Map<String, dynamic> message,
  ) async {
    final url = Uri.parse(
      '${AppConfig.baseUrl}notifications/add',
    );

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'user_id': userId, 'message': message}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error'};
    }
  }

  // Lấy danh sách thông báo
  Future<Map<String, dynamic>> getNotificationList(int userId) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${AppConfig.baseUrl}notifications/list',
        ),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user_id': userId}),
      );
      return json.decode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Đánh dấu đã đọc
  Future<Map<String, dynamic>> markAsRead(int notificationId) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}notifications/mark-read'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'notification_id': notificationId}),
      );
      return json.decode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Đánh dấu tất cả đã đọc
  Future<Map<String, dynamic>> markAllAsRead(int userId) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}notifications/mark-all-read'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user_id': userId}),
      );
      return json.decode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
