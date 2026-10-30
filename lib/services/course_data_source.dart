import '../models/course.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

abstract class CourseDataSource {
  Future<List<Course>> getCourses();
  Future<Course> createCourse(Course course);
  Future<void> updateCourse(dynamic id, Course course);
  Future<void> deleteCourse(dynamic id);
}