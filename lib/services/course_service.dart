import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/course.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class CourseService {
  /// Membaca file JSON asset dan mengembalikannya sebagai List<Course>
  Future<List<Course>> loadCourses() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/student_data.json',
      );
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      final list = data['courses'] as List<dynamic>;

      return list
          .map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Gagal membaca data mata kuliah dari JSON: $e');
    }
  }
}