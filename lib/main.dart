import 'package:flutter/material.dart';

// Konstanta Identitas Mahasiswa (Spesifikasi: Nama & NIM terlihat pada UI)
const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

// Collection Data Course (Spesifikasi: Minimal 5 item dari collection / JSON statik)
final List<Map<String, dynamic>> initialCourses = [
  {
    'title': 'Pemrograman Mobile',
    'code': 'PTI1501',
    'credits': 3,
    'status': 'Wajib',
    'description':
        'Mempelajari pengembangan aplikasi perangkat bergerak menggunakan framework Flutter dan bahasa Dart.',
    'isFavorite': false,
  },
  {
    'title': 'Pengolahan Citra Digital',
    'code': 'PTI1502',
    'credits': 3,
    'status': 'Wajib',
    'description':
        'Membahas pemrosesan sinyal gambar, operasi titik, transformasi geometris, dan kuantisasi spasial.',
    'isFavorite': false,
  },
  {
    'title': 'Kecerdasan Buatan',
    'code': 'PTI1503',
    'credits': 3,
    'status': 'Pilihan',
    'description':
        'Konsep dasar AI, logika fuzzy Sugeno, agen cerdas, serta algoritma pencarian graf dan pohon keputusan.',
    'isFavorite': false,
  },
  {
    'title': 'Jaringan Komputer',
    'code': 'PTI1504',
    'credits': 3,
    'status': 'Wajib',
    'description':
        'Infrastruktur jaringan, konfigurasi OSPF/BGP, subnetting, DHCP Server, serta analisis cakupan sinyal Wi-Fi.',
    'isFavorite': false,
  },
  {
    'title': 'Pengembangan Aplikasi Web',
    'code': 'PTI1505',
    'credits': 3,
    'status': 'Wajib',
    'description':
        'Pengembangan aplikasi web modern full-stack menggunakan framework PHP/Laravel dan arsitektur REST API.',
    'isFavorite': false,
  },
];

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ResponsiveShell(),
    );
  }
}

// ==========================================
// RESPONSIVE SHELL
// ==========================================
// Spesifikasi: NavigationBar pada compact/medium, NavigationRail pada expanded
class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _selectedIndex = 0;
  late List<Map<String, dynamic>> _courseList;

  @override
  void initState() {
    super.initState();
    _courseList = List<Map<String, dynamic>>.from(
      initialCourses.map((item) => Map<String, dynamic>.from(item)),
    );
  }

  // Interaksi Favorite yang mengubah state
  void _toggleFavorite(int index) {
    setState(() {
      _courseList[index]['isFavorite'] =
          !(_courseList[index]['isFavorite'] ?? false);
    });

    final bool isFav = _courseList[index]['isFavorite'];
    
    // Spesifikasi: Terdapat minimal satu SnackBar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFav
              ? '"${_courseList[index]['title']}" ditambahkan ke favorit.'
              : '"${_courseList[index]['title']}" dihapus dari favorit.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(studentName: studentName, studentId: studentId),
      CoursesPage(
        courses: _courseList,
        onToggleFavorite: _toggleFavorite,
      ),
      ProfilePage(studentName: studentName, studentId: studentId),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint Material 3:
        // Compact & Medium (< 840px) -> NavigationBar di bawah
        // Expanded (>= 840px) -> NavigationRail di samping
        final bool isExpanded = constraints.maxWidth >= 840;

        return Scaffold(
          appBar: AppBar(
            // Spesifikasi: AppBar dengan judul Course Explorer
            title: const Text('Course Explorer'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            elevation: 2,
          ),
          body: isExpanded
              ? Row(
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
                          icon: Icon(Icons.person_outlined),
                          selectedIcon: Icon(Icons.person),
                          label: Text('Profile'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(child: pages[_selectedIndex]),
                  ],
                )
              : pages[_selectedIndex],
          bottomNavigationBar: isExpanded
              ? null
              : NavigationBar(
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
                      icon: Icon(Icons.person_outlined),
                      selectedIcon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
        );
      },
    );
  }
}

// ==========================================
// REUSABLE WIDGET 1: StudentHeaderCard
// ==========================================
// Spesifikasi: Minimal dua bagian UI dipisahkan menjadi reusable widget
class StudentHeaderCard extends StatelessWidget {
  final String studentName;
  final String studentId;

  const StudentHeaderCard({
    super.key,
    required this.studentName,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.person, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studentName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NIM: $studentId',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// REUSABLE WIDGET 2: CourseItemCard
// ==========================================
class CourseItemCard extends StatelessWidget {
  final Map<String, dynamic> course;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTap;

  const CourseItemCard({
    super.key,
    required this.course,
    required this.onToggleFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFav = course['isFavorite'] ?? false;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: () {
          // Spesifikasi: Dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(course['title'] ?? ''),
              content: Text(
                '• Kode: ${course['code']}\n'
                '• Beban: ${course['credits']} SKS\n'
                '• Kategori: ${course['status']}\n\n'
                'Mahasiswa: $studentName ($studentId)',
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  '${course['credits']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      course['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${course['code']} • ${course['status']}',
                      style: TextStyle(
                        fontSize: 12,
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
                onPressed: onToggleFavorite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 1. HOME PAGE
// ==========================================
class HomePage extends StatelessWidget {
  final String studentName;
  final String studentId;

  const HomePage({
    super.key,
    required this.studentName,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    // Spesifikasi: UI dapat di-scroll
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StudentHeaderCard(
            studentName: studentName,
            studentId: studentId,
          ),
          const SizedBox(height: 20),
          const Text(
            'Tentang Aplikasi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Course Explorer merupakan aplikasi integrasi praktikum yang dirancang '
            'secara adaptif untuk menampilkan daftar mata kuliah, detail informasi, '
            'serta formulir feedback interaktif.',
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 16),
          const Card(
            child: ListTile(
              leading: Icon(Icons.explore, color: Colors.indigo),
              title: Text('Eksplorasi Mata Kuliah'),
              subtitle: Text('Buka tab "Courses" untuk melihat katalog.'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.feedback, color: Colors.indigo),
              title: Text('Kirim Feedback & Profil'),
              subtitle: Text('Buka tab "Profile" untuk mengisi form masukan.'),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. COURSES PAGE (List & Grid Layout)
// ==========================================
class CoursesPage extends StatelessWidget {
  final List<Map<String, dynamic>> courses;
  final Function(int) onToggleFavorite;

  const CoursesPage({
    super.key,
    required this.courses,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Spesifikasi: Compact layout menggunakan 1 kolom/list; medium/expanded menggunakan grid
        final bool isGrid = constraints.maxWidth >= 600;

        if (isGrid) {
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return CourseItemCard(
                course: courses[index],
                onToggleFavorite: () => onToggleFavorite(index),
                onTap: () => _navigateToDetail(context, courses[index], index),
              );
            },
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: CourseItemCard(
                  course: courses[index],
                  onToggleFavorite: () => onToggleFavorite(index),
                  onTap: () => _navigateToDetail(context, courses[index], index),
                ),
              );
            },
          );
        }
      },
    );
  }

  void _navigateToDetail(
      BuildContext context, Map<String, dynamic> course, int index) async {
    // Spesifikasi: Course item dapat ditekan & data dikirim via constructor ke CourseDetailPage
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CourseDetailPage(course: course),
      ),
    );

    if (result == true) {
      onToggleFavorite(index);
    }
  }
}

// ==========================================
// COURSE DETAIL PAGE
// ==========================================
// Spesifikasi: Data course dikirim melalui constructor ke halaman detail
class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFav = course['isFavorite'] ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(course['title'] ?? 'Detail Mata Kuliah'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(course['code'] ?? ''),
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .secondaryContainer,
                        ),
                        Chip(
                          label: Text('${course['credits']} SKS'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      course['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 24),
                    const Text(
                      'Deskripsi Mata Kuliah:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course['description'] ?? 'Tidak ada deskripsi.',
                      style: const TextStyle(fontSize: 14, height: 1.4),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Status Sifat: ${course['status']}',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context, true),
                icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                label: Text(
                  isFav
                      ? 'Batalkan Favorit'
                      : 'Favoritkan Mata Kuliah Ini',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. PROFILE PAGE & FEEDBACK FORM
// ==========================================
class ProfilePage extends StatefulWidget {
  final String studentName;
  final String studentId;

  const ProfilePage({
    super.key,
    required this.studentName,
    required this.studentId,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _nimController;
  final TextEditingController _commentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.studentName);
    _nimController = TextEditingController(text: widget.studentId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    // Spesifikasi: Form validation
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Spesifikasi: Dialog Konfirmasi
    showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Feedback'),
          content: Text(
            'Kirimkan komentar ini atas nama ${_nameController.text} (${_nimController.text})?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    ).then((confirmed) async {
      if (confirmed == true) {
        setState(() {
          _isLoading = true;
        });

        await Future.delayed(const Duration(seconds: 2));

        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });

        _commentController.clear();

        // Spesifikasi: SnackBar notification
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Umpan balik dari ${widget.studentName} (${widget.studentId}) berhasil dikirim!',
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StudentHeaderCard(
            studentName: widget.studentName,
            studentId: widget.studentId,
          ),
          const SizedBox(height: 24),
          const Text(
            'Form Feedback Pengguna',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // Form Feedback Sederhana
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  enabled: !_isLoading,
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
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nimController,
                  enabled: !_isLoading,
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
                const SizedBox(height: 12),
                TextFormField(
                  controller: _commentController,
                  enabled: !_isLoading,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Komentar / Masukan',
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                    ),
                    child: _isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('Mengirim...'),
                            ],
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.send),
                              SizedBox(width: 8),
                              Text('Kirim Feedback'),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}