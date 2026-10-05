import 'package:flutter/material.dart';

// Variabel Identitas Mahasiswa (Wajib)
const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

// Model Data Course
class Course {
  final String title;
  final String category;
  final String level;

  const Course({
    required this.title,
    required this.category,
    required this.level,
  });
}

// Data Dummy Course
const List<Course> dummyCourses = [
  Course(title: 'Pemrograman Flutter', category: 'Mobile', level: 'Beginner'),
  Course(title: 'Pengembangan Web Laravel', category: 'Web', level: 'Intermediate'),
  Course(title: 'Jaringan Komputer', category: 'Network', level: 'Advanced'),
  Course(title: 'Pengolahan Citra Digital', category: 'Multimedia', level: 'Intermediate'),
  Course(title: 'Kecerdasan Buatan', category: 'AI', level: 'Advanced'),
  Course(title: 'Desain UI/UX', category: 'Design', level: 'Beginner'),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahap 5 - GridView Responsif',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Tahap5Screen(),
    );
  }
}

class Tahap5Screen extends StatelessWidget {
  const Tahap5Screen({super.key});

  // Fungsi penentu jumlah kolom berdasarkan lebar layar (Sesuai Modul)
  int columnsFor(double width) {
    if (width < 600) return 1;
    if (width < 840) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 5 - GridView Responsif'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Identitas Mahasiswa (Tetap Terlihat)
                Card(
                  elevation: 2,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.person, size: 32),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mahasiswa: $studentName',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('NIM: $studentId'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // GridView Responsif
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columnsFor(constraints.maxWidth),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.2,
                    ),
                    itemCount: dummyCourses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(course: dummyCourses[index]);
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

// Widget Card untuk Course
class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              course.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Chip(
                  label: Text(
                    course.category,
                    style: const TextStyle(fontSize: 10),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 8),
                Text(
                  course.level,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}