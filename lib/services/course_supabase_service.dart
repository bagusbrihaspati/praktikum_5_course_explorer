import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course.dart';
import 'course_data_source.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class CourseSupabaseService implements CourseDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    final data = await supabase
        .from('courses')
        .select()
        .order('id');

    return (data as List)
        .map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // Sementara agar kelas tetap dapat dikompilasi (Instruksi 71)
  @override
  Future<Course> createCourse(Course course) => throw UnimplementedError();

  @override
  Future<void> updateCourse(dynamic id, Course course) =>
      throw UnimplementedError();

  @override
  Future<void> deleteCourse(dynamic id) => throw UnimplementedError();
}