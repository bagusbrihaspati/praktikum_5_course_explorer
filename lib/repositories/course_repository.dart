import '../models/course.dart';
import '../services/course_data_source.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class CourseRepository {
  final CourseDataSource dataSource;

  CourseRepository(this.dataSource);

  Future<List<Course>> getCourses() => dataSource.getCourses();

  Future<Course> createCourse(Course course) =>
      dataSource.createCourse(course);

  Future<void> updateCourse(dynamic id, Course course) =>
      dataSource.updateCourse(id, course);

  Future<void> deleteCourse(dynamic id) =>
      dataSource.deleteCourse(id);
}