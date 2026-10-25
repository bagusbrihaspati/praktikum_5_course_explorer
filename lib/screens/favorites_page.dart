import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import '../widgets/student_header_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();
    // Menyaring daftar course yang ID-nya ada di kumpulan favorites
    final favoriteCourses = courseProvider.courses
        .where((course) => courseProvider.isFavorite(course.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mata Kuliah Favorit'),
        actions: [
          if (favoriteCourses.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Kosongkan Favorit',
              onPressed: () => context.read<CourseProvider>().clearAllFavorites(),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentHeaderCard(),
            const SizedBox(height: 16),
            Text(
              'Daftar Tersimpan (${favoriteCourses.length} Mata Kuliah):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: favoriteCourses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 64,
                            color: Colors.blue.shade300,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Belum ada mata kuliah favorit.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tambahkan dari katalog Courses atau Detail Page.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: favoriteCourses.length,
                      itemBuilder: (context, index) {
                        final course = favoriteCourses[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: CourseCardWidget(course: course),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}