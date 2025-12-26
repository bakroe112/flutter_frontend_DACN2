import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:job_portal_app/config/constants.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class UserService {
  // Upload ảnh đại diện
  Future<Map<String, dynamic>> uploadAvatar(
    int userId,
    String role,
    File avatarFile,
  ) async {
    try {
      final url = Uri.parse('${AppConfig.baseUrl}users/upload-avatar');

      final request = http.MultipartRequest('POST', url);
      request.fields['user_id'] = userId.toString();
      request.fields['role'] = role;
      
      // Read file bytes
      final bytes = await avatarFile.readAsBytes();
      final fileName = avatarFile.path.split('/').last;
      
      // Add file
      request.files.add(http.MultipartFile(
        'avatar',
        http.ByteStream.fromBytes(bytes),
        bytes.length,
        filename: fileName,
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['success']) {
          print('Avatar uploaded successfully: ${result['url']}');
        }
        return result;
      } else {
        return {
          'success': false,
          'message': 'Upload failed with status ${response.statusCode}: ${response.body}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}'
      };
    }
  }

  Future<void> downloadAndOpenFile(String url, String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final savePath = '${dir.path}/$fileName';
      final dio = Dio();
      await dio.download(url, savePath);
      final result = await OpenFile.open(savePath);
    } catch (e) {
      print('Download failed: $e');
    }
  }
}
