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
}