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
    final payload = <String, dynamic>{
      'code': course.code,
      'title': course.title,
      'credits': course.credits,
      'description': course.description,
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
  Future<void> updateCourse(dynamic id, Course course) async {
    final payload = <String, dynamic>{
      'code': course.code,
      'title': course.title,
      'credits': course.credits,
      'description': course.description,
      'status': ['planned', 'active', 'done'].contains(course.status)
          ? course.status
          : 'planned',
    };

    await supabase
        .from('courses')
        .update(payload)
        .eq('id', id);
  }

@override
  Future<void> deleteCourse(dynamic id) async {
    await supabase
        .from('courses')
        .delete()
        .eq('id', id);
  }
}