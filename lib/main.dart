import 'package:flutter/material.dart';

// Variabel Identitas Mahasiswa (Wajib)
const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

// List Data Course (Mata Kuliah)
final List<Map<String, dynamic>> courses = [
  {
    'title': 'Pemrograman Mobile',
    'code': 'PTI1501',
    'credits': 3,
    'status': 'Wajib',
  },
  {
    'title': 'Pengolahan Citra Digital',
    'code': 'PTI1502',
    'credits': 3,
    'status': 'Wajib',
  },
  {
    'title': 'Kecerdasan Buatan',
    'code': 'PTI1503',
    'credits': 3,
    'status': 'Pilihan',
  },
  {
    'title': 'Jaringan Komputer',
    'code': 'PTI1504',
    'credits': 3,
    'status': 'Wajib',
  },
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahap 8 - Passing Data to Detail',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// 1. HomePage - Menampilkan List Course
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Mata Kuliah'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: courses.length + 1, // +1 untuk Header Identitas Mahasiswa
        itemBuilder: (context, index) {
          // Item 0: Card Identitas Mahasiswa
          if (index == 0) {
            return Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 32),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Mahasiswa: $studentName',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('NIM: $studentId'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

          // Item 1..n: List Course
          final course = courses[index - 1];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${course['credits']} SKS'),
              ),
              title: Text(
                course['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Kode: ${course['code']} | Status: ${course['status']}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Passing Map course ke CourseDetailPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseDetailPage(course: course),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// 2. CourseDetailPage - Menerima Data Course via Constructor
class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course['title']),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Detail Mata Kuliah
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course['title'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.code, color: Colors.deepPurple),
                        const SizedBox(width: 8),
                        Text(
                          'Kode Mata Kuliah: ${course['code']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.credit_card, color: Colors.deepPurple),
                        const SizedBox(width: 8),
                        Text(
                          'SKS / Credits: ${course['credits']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.category, color: Colors.deepPurple),
                        const SizedBox(width: 8),
                        Text(
                          'Status: ${course['status']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Identitas Mahasiswa pada Halaman Detail (Sesuai Poin 34)
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  const Icon(Icons.badge_outlined),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Praktikan: $studentName ($studentId)',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Tombol Kembali
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Daftar Mata Kuliah'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}