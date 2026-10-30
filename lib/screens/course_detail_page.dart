import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/student_header_card.dart';
import 'edit_course_page.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    // Amankan id ke String untuk pengecekan favorite
    final courseIdStr = course.id.toString();
    final isFav = context.watch<CourseProvider>().isFavorite(courseIdStr);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        // Tombol Edit Course (Instruksi No. 41)
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Course',
            onPressed: () async {
              final result = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) => EditCoursePage(course: course),
                ),
              );
              // Jika berhasil diedit, kembali ke katalog dan refresh list
              if (result == true && context.mounted) {
                Navigator.pop(context, true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentHeaderCard(),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Kode: ${course.code}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        Chip(
                          backgroundColor: Colors.blue.shade100,
                          label: Text(
                            '${course.credits} SKS',
                            style: TextStyle(color: Colors.blue.shade900),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Text(
                      'Kategori: ${course.category}',
                      style: TextStyle(color: Colors.blue.shade900),
                    ),
                    Text(
                      'Tingkat Kesulitan: ${course.level}',
                      style: TextStyle(color: Colors.blue.shade900),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Deskripsi Mata Kuliah:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.description,
                      style: TextStyle(color: Colors.blue.shade800),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<CourseProvider>().toggleFavorite(courseIdStr);
                    },
                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                    label: Text(
                        isFav ? 'Tersimpan di Favorit' : 'Tambah ke Favorit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFav
                          ? Colors.blue.shade200
                          : Colors.blue.shade600,
                      foregroundColor:
                          isFav ? Colors.blue.shade900 : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context, true),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue.shade800,
                    side: BorderSide(color: Colors.blue.shade600),
                  ),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Kembali'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}