import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class CourseApiService {
  final String baseUrl;

  CourseApiService(this.baseUrl);

  Future<List<Course>> getCourses() async {
    final url = baseUrl.endsWith('/posts') || baseUrl.endsWith('/courses')
    ? baseUrl
    : '$baseUrl/courses';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil course: HTTP ${response.statusCode}');
    }

    final List data = jsonDecode(response.body) as List;
    return data
        .map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Course> createCourse(Course course) async {
    final url = baseUrl.endsWith('/posts') || baseUrl.endsWith('/courses')
        ? baseUrl
        : '$baseUrl/courses';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Course.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    throw Exception('Gagal membuat course: HTTP ${response.statusCode}');
  }

  Future<void> updateCourse(dynamic id, Course course) async {
    // Endpoint REST API PUT: sesuaikan dengan struktur URL (misal: /posts/1 atau /courses/1)
    final root = baseUrl.endsWith('/posts') || baseUrl.endsWith('/courses')
        ? baseUrl
        : '$baseUrl/courses';
    final url = '$root/$id';

    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Gagal memperbarui course: HTTP ${response.statusCode}');
    }
  }

  Future<void> deleteCourse(dynamic id) async {
    final root = baseUrl.endsWith('/posts') || baseUrl.endsWith('/courses')
        ? baseUrl
        : '$baseUrl/courses';
    final url = '$root/$id';

    final response = await http.delete(Uri.parse(url));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Gagal menghapus course: HTTP ${response.statusCode}');
    }
  }
}