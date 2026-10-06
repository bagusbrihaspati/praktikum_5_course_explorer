import 'package:flutter/material.dart';

// Variabel Identitas Mahasiswa (Wajib)
const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

// List Data Course (Mata Kuliah) dengan state 'isFavorite'
final List<Map<String, dynamic>> courses = [
  {
    'title': 'Pemrograman Mobile',
    'code': 'PTI1501',
    'credits': 3,
    'status': 'Wajib',
    'isFavorite': false,
  },
  {
    'title': 'Pengolahan Citra Digital',
    'code': 'PTI1502',
    'credits': 3,
    'status': 'Wajib',
    'isFavorite': false,
  },
  {
    'title': 'Kecerdasan Buatan',
    'code': 'PTI1503',
    'credits': 3,
    'status': 'Pilihan',
    'isFavorite': false,
  },
  {
    'title': 'Jaringan Komputer',
    'code': 'PTI1504',
    'credits': 3,
    'status': 'Wajib',
    'isFavorite': false,
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
      title: 'Tahap 13 - Form Input dan Validasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// Shell utama aplikasi dengan Adaptive Navigation Pattern
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      const CoursesScreen(),
      const FeedbackFormScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 840) {
          // Layout Compact menggunakan NavigationBar
          return Scaffold(
            body: _pages[_selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.school_outlined),
                  selectedIcon: Icon(Icons.school),
                  label: 'Courses',
                ),
                NavigationDestination(
                  icon: Icon(Icons.feedback_outlined),
                  selectedIcon: Icon(Icons.feedback),
                  label: 'Feedback',
                ),
              ],
            ),
          );
        } else {
          // Layout Expanded menggunakan NavigationRail
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.school_outlined),
                      selectedIcon: Icon(Icons.school),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.feedback_outlined),
                      selectedIcon: Icon(Icons.feedback),
                      label: Text('Feedback'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: _pages[_selectedIndex],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

// 1. HomeScreen Tab
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda Utama'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.school, size: 36, color: Colors.deepPurple),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selamat Datang!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Praktikan: $studentName'),
                          Text('NIM: $studentId'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'SEMANGAT BELAJAR BAGUS):\n',
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. CoursesScreen Tab (Tahap 12: InkWell, GestureDetector, & Favorite)
class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Mata Kuliah'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          final bool isFav = course['isFavorite'] ?? false;

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12.0),
            clipBehavior: Clip.antiAlias,
            child: GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(course['title']),
                    content: Text(
                      'Informasi Singkat:\n'
                      '• Kode: ${course['code']}\n'
                      '• Beban SKS: ${course['credits']} SKS\n'
                      '• Kategori: ${course['status']}\n\n'
                      'Diperiksa oleh $studentName ($studentId)',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
              child: InkWell(
                onTap: () async {
                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CourseDetailPage(course: course),
                    ),
                  );

                  if (result == true) {
                    setState(() {
                      course['isFavorite'] = true;
                    });
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Mata kuliah "${course['title']}" difavoritkan oleh $studentName!',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Text('${course['credits']} SKS'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Kode: ${course['code']} | Status: ${course['status']}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            course['isFavorite'] = !isFav;
                          });
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                course['isFavorite']
                                    ? '"${course['title']}" ditambahkan ke Favorit.'
                                    : '"${course['title']}" dihapus dari Favorit.',
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 3. FeedbackFormScreen Tab (Tahap 13: Poin 51-54 - Form Input & Validasi)
class FeedbackFormScreen extends StatefulWidget {
  const FeedbackFormScreen({super.key});

  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  // GlobalKey untuk mengontrol dan menguji validasi FormState (Materi Tahap 13)
  final _formKey = GlobalKey<FormState>();

  // TextEditingController dengan nilai awal dari konstanta identitas (Poin 52)
  late final TextEditingController _nameController;
  late final TextEditingController _nimController;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: studentName);
    _nimController = TextEditingController(text: studentId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  // Poin 54: Fungsi submit dengan validasi sebelum menampilkan hasil
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Feedback Terkirim'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: ${_nameController.text}'),
              const SizedBox(height: 4),
              Text('NIM: ${_nimController.text}'),
              const SizedBox(height: 12),
              const Text(
                'Komentar:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_commentController.text),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _commentController.clear();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Feedback Praktikum'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // Poin 51: Menggunakan Form + GlobalKey<FormState>
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Beri Feedback Aplikasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Field Nama (Terisi default)
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Field NIM (Terisi default)
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'NIM wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Field Komentar (Poin 53: Wajib minimal 5 karakter)
              TextFormField(
                controller: _commentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Komentar / Feedback',
                  hintText: 'Tuliskan tanggapan Anda (min. 5 karakter)...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.comment),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Komentar wajib diisi';
                  }
                  if (value.trim().length < 5) {
                    return 'Komentar minimal 5 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Tombol Submit
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.send),
                  label: const Text('Kirim Feedback'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman Detail Mata Kuliah
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
                    Text('Kode Mata Kuliah: ${course['code']}'),
                    const SizedBox(height: 8),
                    Text('SKS / Credits: ${course['credits']}'),
                    const SizedBox(height: 8),
                    Text('Status: ${course['status']}'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context, true),
                icon: const Icon(Icons.favorite),
                label: const Text('Favoritkan Mata Kuliah'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}