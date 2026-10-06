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
      title: 'Tahap 10 - NavigationBar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// Poin 40: StatefulWidget untuk mengelola selectedIndex navigasi utama
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // Poin 41: Daftar widget/halaman yang ditampilkan sesuai index
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
    return Scaffold(
      body: _pages[_selectedIndex],
      // Poin 39 & 40: NavigationBar Material 3
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
  }
}

// 1. HomeScreen Tab (Sudah Perbaikan Error)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda Utama'), // Perbaikan typo tanda petik
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poin 42: Identitas Mahasiswa di HomeScreen
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
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. CoursesScreen Tab (Daftar Mata Kuliah & Push ke Detail)
class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

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
              onTap: () async {
                final result = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseDetailPage(course: course),
                  ),
                );

                if (result == true && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Mata kuliah "${course['title']}" difavoritkan oleh $studentName!',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
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
            // Poin 42: Identitas Mahasiswa di ProfileScreen
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

// Halaman Detail Mata Kuliah (Dipanggil lewat Navigator.push dari CoursesScreen)
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