import '../models/course.dart';
import '../services/course_api_service.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class CourseRepository {
  final CourseApiService _apiService;

  CourseRepository(this._apiService);

  Future<List<Course>> getCourses() async {
    return await _apiService.getCourses();
  }
  
  Future<Course> createCourse(Course course) async {
    return await _apiService.createCourse(course);
  }

  Future<void> updateCourse(dynamic id, Course course) async {
    await _apiService.updateCourse(id, course);
  }

  Future<void> deleteCourse(dynamic id) async {
    await _apiService.deleteCourse(id);
  }
}