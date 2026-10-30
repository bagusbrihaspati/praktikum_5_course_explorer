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

@override
  Future<Course> createCourse(Course course) async {
    // Siapkan payload yang hanya memuat kolom tabel database Supabase
    final payload = <String, dynamic>{
      'code': course.code,
      'title': course.title,
      'credits': course.credits,
      'description': course.description,
      // Map status atau gunakan nilai default 'planned' jika kosong
      'status': ['planned', 'active', 'done'].contains(course.status)
          ? course.status
          : 'planned',
    };

    final row = await supabase
        .from('courses')
        .insert(payload)
        .select()
        .single();

    return Course.fromJson(row);
  }
  
  @override
  Future<void> updateCourse(dynamic id, Course course) =>
      throw UnimplementedError();

  @override
  Future<void> deleteCourse(dynamic id) => throw UnimplementedError();
}