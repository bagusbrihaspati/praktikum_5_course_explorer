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
      title: 'Tahap 6 - Scrollable Content & Keyboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Tahap6Screen(),
    );
  }
}

class Tahap6Screen extends StatelessWidget {
  const Tahap6Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 6 - Scrollable Form'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // Menerapkan SingleChildScrollView sesuai instruksi modul
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Identitas Mahasiswa
            Text(
              '$studentId - $studentName',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24),

            // Form Sederhana yang Lebih Tinggi dari Layar
            const Text(
              'Form Profil Mahasiswa',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            const TextField(
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),

            const TextField(
              decoration: InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
            ),
            const SizedBox(height: 16),

            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),

            const TextField(
              decoration: InputDecoration(
                labelText: 'Program Studi',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.school),
              ),
            ),
            const SizedBox(height: 16),

            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Alamat / Bio',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
            ),
            const SizedBox(height: 16),

            const TextField(
              decoration: InputDecoration(
                labelText: 'Catatan Tambahan',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Simpan Profil'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}