import 'package:flutter/material.dart';
import '../models/course.dart';
import '../repositories/course_repository.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  List<Course> courses = [];
  bool isLoading = false;
  String? error;
  
  void triggerSimulatedError(String message) {
    error = message; 
    notifyListeners();
  }

  final Set<String> _favorites = {};
  Set<String> get favorites => Set.unmodifiable(_favorites);
  int get totalFavorites => _favorites.length;
  bool isFavorite(String id) => _favorites.contains(id);

  void toggleFavorite(String id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    notifyListeners();
  }

  void clearAllFavorites() {
    _favorites.clear();
    notifyListeners();
  }

  /// Mengambil data mata kuliah secara asinkron dengan penanganan loading & error
  Future<void> loadCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      // Menambahkan delay visual kecil agar transisi loading terlihat jelas di UI
      await Future.delayed(const Duration(milliseconds: 500));
      courses = await repository.getCourses();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}