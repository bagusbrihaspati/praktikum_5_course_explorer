import 'package:flutter/material.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class CourseState extends ChangeNotifier {
  final Set<String> _favorites = {};

  Set<String> get favorites => Set.unmodifiable(_favorites);

  int get totalFavorites => _favorites.length;

  bool isFavorite(String id) => _favorites.contains(id);

  /// Method untuk mengubah status favorit
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
}