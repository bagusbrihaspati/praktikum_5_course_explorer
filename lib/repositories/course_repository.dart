import '../models/course.dart';
import '../services/course_service.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class CourseRepository {
  final CourseService service;

  // Menerima CourseService melalui constructor (Dependency Injection)
  CourseRepository(this.service);

  /// Mengambil daftar mata kuliah dari service data source
  Future<List<Course>> getCourses() {
    return service.loadCourses();
  }
}