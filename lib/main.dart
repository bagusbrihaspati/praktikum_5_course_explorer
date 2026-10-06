import 'package:flutter/material.dart';

// Variabel Identitas Mahasiswa (Wajib)
const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

// List Data Course (Mata Kuliah) dengan tambahaan state 'isFavorite' (Poin 48)
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
      title: 'Tahap 12 - User Interaction & Feedback',
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
      const ProfileScreen(),
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
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
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
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
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
              'SEMANGAT BELAJAR BAGUS',
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. CoursesScreen Tab 
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
            clipBehavior: Clip.antiAlias, // Memastikan efek InkWell rapi di dalam Card
            // Poin 50: GestureDetector untuk gesture long press
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
              // Poin 47: InkWell untuk efek ripple saat tap
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
                      // Poin 48 & 49: Tombol Favorite dengan state boolean & icon berbeda
                      IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            // Toggle state favorite
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

// 3. ProfileScreen Tab
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            Text(
              studentName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'NIM: $studentId',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 32),
            const ListTile(
              leading: Icon(Icons.school),
              title: Text('Program Studi'),
              subtitle: Text('Pendidikan Teknik Informatika'),
            ),
            const ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Universitas'),
              subtitle: Text('Universitas Pendidikan Ganesha'),
            ),
          ],
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