import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import '../widgets/student_header_card.dart';

class CoursesSummary extends StatelessWidget {
  final int totalFavorites;
  final VoidCallback onClearAll;

  const CoursesSummary({
    super.key,
    required this.totalFavorites,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.blue.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Favorit Dipilih: $totalFavorites',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            TextButton.icon(
              onPressed: onClearAll,
              icon: const Icon(Icons.clear_all, size: 18),
              label: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  int _getCrossAxisCount(double width) {
    if (width < 600) return 1;
    if (width < 840) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Mata Kuliah')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final int columns = _getCrossAxisCount(constraints.maxWidth);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StudentHeaderCard(),
                const SizedBox(height: 12),
                CoursesSummary(
                  totalFavorites: courseProvider.totalFavorites,
                  onClearAll: () =>
                      context.read<CourseProvider>().clearAllFavorites(),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (courseProvider.isLoading) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 12),
                              Text('Memuat data mata kuliah dari JSON...'),
                            ],
                          ),
                        );
                      }

                      if (courseProvider.error != null) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline,
                                  color: Colors.red.shade700, size: 48),
                              const SizedBox(height: 8),
                              Text(
                                'Terjadi kesalahan:\n${courseProvider.error}',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.red.shade900),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton.icon(
                                onPressed: () =>
                                    context.read<CourseProvider>().loadCourses(),
                                icon: const Icon(Icons.refresh),
                                label: const Text('Coba Lagi'),
                              ),
                            ],
                          ),
                        );
                      }

                      final courses = courseProvider.courses;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Katalog Course (${courses.length} Item - Grid $columns Kolom):',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio:
                                    constraints.maxWidth < 600 ? 2.3 : 1.8,
                              ),
                              itemCount: courses.length,
                              itemBuilder: (context, index) {
                                return CourseCardWidget(course: courses[index]);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}