import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/student_header_card.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<CourseProvider>().isFavorite(course.id);

    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
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
                      context.read<CourseProvider>().toggleFavorite(course.id);
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