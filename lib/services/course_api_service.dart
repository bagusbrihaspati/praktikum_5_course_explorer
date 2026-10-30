import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';
import 'course_data_source.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class CourseApiService implements CourseDataSource {
  final String baseUrl;

  CourseApiService(this.baseUrl);

  @override
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

  @override
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

  @override
  Future<void> updateCourse(dynamic id, Course course) async {
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

  @override
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