import 'package:flutter/material.dart';

// Variabel Identitas Mahasiswa (Wajib)
const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahap 7 - Navigation Push & Pop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// 1. HomePage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Identitas Mahasiswa
            Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
            ),
            const SizedBox(height: 24),

            // Tombol Navigasi ke DetailPage
            ElevatedButton.icon(
              onPressed: () {
                // Menggunakan Navigator.push() untuk berpindah ke DetailPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailPage(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Buka Detail'),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. DetailPage
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Identitas Mahasiswa tetap ditampilkan
            Text(
              'Detail untuk: $studentName ($studentId)',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Hallo bagus',
            ),
            const SizedBox(height: 24),

            // Tombol Kembali Kustom
            OutlinedButton.icon(
              onPressed: () {
                // Menggunakan Navigator.pop() untuk kembali ke HomePage
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali (Pop)'),
            ),
          ],
        ),
      ),
    );
  }
}