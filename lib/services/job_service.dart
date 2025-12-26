import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_portal_app/config/constants.dart';
import 'package:job_portal_app/models/job.dart';

class JobService {
  // Lấy danh sách job nổi bật
  Future<Map<String, dynamic>> getFeaturedJobs(int userId) async {
    final url = Uri.parse('${AppConfig.baseUrl}jobs/featured');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'user_id': userId}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success']) {
        final jobList = (data['data'] as List)
            .map((jobJson) => Job.fromJson(jobJson))
            .toList();

        return {'success': true, 'data': jobList};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Error'};
      }
    } else {
      return {'success': false, 'message': 'Error'};
    }
  }

  // Lấy danh sách job mới nhất
  Future<Map<String, dynamic>> getLatestJob() async {
    final url = Uri.parse('${AppConfig.baseUrl}jobs/latest');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success']) {
        final jobList = (data['data'] as List)
            .map((jobJson) => Job.fromJson(jobJson))
            .toList();

        return {'success': true, 'data': jobList};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Error'};
      }
    } else {
      return {'success': false, 'message': 'Error'};
    }
  }

  // Lấy danh sách job đã lưu
  Future<Map<String, dynamic>> getSavedJobs(int userId) async {
    final url = Uri.parse('${AppConfig.baseUrl}jobs/saved');

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

  // Lấy danh sách job của một recruiter
  Future<Map<String, dynamic>> getRecruiterJobs(
      int userId,
      int recruiterId,
      ) async {
    final url = Uri.parse('${AppConfig.baseUrl}jobs/recruiter-jobs');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'user_id': userId, 'recruiter_id': recruiterId}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error connecting to server'};
    }
  }

  // Lấy chi tiết job
  Future<Map<String, dynamic>> getDetailJob(int userId, int jobId) async {
    final url = Uri.parse('${AppConfig.baseUrl}jobs/detail');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'user_id': userId, 'job_id': jobId}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error connecting to server'};
    }
  }

  // Lấy tùy chọn bộ lọc
  Future<Map<String, dynamic>> getFilterOptions() async {
    final url = Uri.parse('${AppConfig.baseUrl}jobs/filter-options');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Server error'};
    }
  }

  // Tìm kiếm job
  Future<Map<String, dynamic>> searchJobs({
    required int userId,
    String? keyword,
    String? companyName,
    String? location,
    int? fieldId,
    String? jobType,
    String? workplaceType,
  }) async {
    final url = Uri.parse('${AppConfig.baseUrl}jobs/search');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'user_id': userId,
        'keyword': keyword ?? '',
        'company_name': companyName ?? '',
        'location': location ?? '',
        'field_id': fieldId ?? '',
        'job_type': jobType ?? '',
        'workplace_type': workplaceType ?? '',
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error connecting to server'};
    }
  }

  // Lấy danh sách job (cho recruiter)
  Future<Map<String, dynamic>> getJobList(int userId, String? jobStatus) async {
    final url = Uri.parse('${AppConfig.baseUrl}jobs/list');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'user_id': userId,
        if (jobStatus != null && jobStatus.isNotEmpty) 'job_status': jobStatus,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error connecting to server'};
    }
  }

  // Tạo job mới
  Future<Map<String, dynamic>> createJob(
    int recruiterId,
    String title,
    String salary,
    String jobType,
    String workplaceType,
    String experience,
    int vacancyCount,
    int fieldId,
    String jobDescription,
    String requirements,
    String interest,
    String workLocation,
    String workingTime,
    String deadline,
  ) async {
    final url = Uri.parse('${AppConfig.baseUrl}jobs/create');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'recruiter_id': recruiterId,
        'title': title,
        'salary': salary,
        'job_type': jobType,
        'workplace_type': workplaceType,
        'experience': experience,
        'vacancy_count': vacancyCount,
        'field_id': fieldId,
        'job_description': jobDescription,
        'requirements': requirements,
        'interest': interest,
        'work_location': workLocation,
        'working_time': workingTime,
        'deadline': deadline,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error'};
    }
  }

  // Cập nhật job
  Future<Map<String, dynamic>> updateJob(
    int jobId,
    int recruiterId,
    String title,
    String salary,
    String jobType,
    String workplaceType,
    String experience,
    int vacancyCount,
    int fieldId,
    String jobDescription,
    String requirements,
    String interest,
    String workLocation,
    String workingTime,
    String deadline,
    String jobStatus,
  ) async {
    final url = Uri.parse('${AppConfig.baseUrl}jobs/update');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'job_id': jobId,
        'recruiter_id': recruiterId,
        'title': title,
        'salary': salary,
        'job_type': jobType,
        'workplace_type': workplaceType,
        'experience': experience,
        'vacancy_count': vacancyCount,
        'field_id': fieldId,
        'job_description': jobDescription,
        'requirements': requirements,
        'interest': interest,
        'work_location': workLocation,
        'working_time': workingTime,
        'deadline': deadline,
        'job_status': jobStatus,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error'};
    }
  }

  // Xóa job
  Future<Map<String, dynamic>> deleteJob(int jobId, int recruiterId) async {
    final url = Uri.parse('${AppConfig.baseUrl}jobs/delete');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'job_id': jobId, 'recruiter_id': recruiterId}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error connecting to server'};
    }
  }

  // Toggle lưu/bỏ lưu job
  Future<Map<String, dynamic>> toggleSaveJob(int userId, int jobId) async {
    final url = Uri.parse('${AppConfig.baseUrl}jobs/toggle-saved');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId, 'job_id': jobId}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Error connecting to server'};
    }
  }
}
