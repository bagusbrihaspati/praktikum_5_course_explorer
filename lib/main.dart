import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_state.dart';
import 'models/course.dart';
import 'services/course_service.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Pengujian CourseService (Tahap 9)
  final courseService = CourseService();
  try {
    final loadedCourses = await courseService.loadCourses();
    debugPrint(
      '[$studentId - $studentName] Berhasil memuat ${loadedCourses.length} course dari JSON!',
    );
  } catch (e) {
    debugPrint('Error pengujian service: $e');
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer - $studentId',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue.shade700,
          secondary: Colors.blueAccent,
          primaryContainer: Colors.blue.shade50,
          onPrimaryContainer: Colors.blue.shade900,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFA1E7FF),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const MainAdaptiveShell(),
    );
  }
}

// Dummy Courses menggunakan Model Course & factory fromJson (Tahap 8)
final List<Course> dummyCourses = [
  Course.fromJson({
    'id': '1',
    'code': 'MOB04',
    'title': 'Pemrograman Flutter',
    'credits': 3,
    'category': 'Mobile',
    'level': 'Beginner',
    'description':
        'Mempelajari dasar-dasar UI Flutter, Widget, Layouting, State Management, dan Navigasi.',
    'status': 'done',
  }),
  Course(
    id: '2',
    code: 'WEB02',
    title: 'Pengembangan Web Laravel',
    credits: 3,
    category: 'Web',
    level: 'Intermediate',
    description:
        'Membangun aplikasi web modern menggunakan Framework PHP Laravel dan RESTful API.',
    status: 'done',
  ),
  Course(
    id: '3',
    code: 'NET01',
    title: 'Jaringan Komputer',
    credits: 3,
    category: 'Network',
    level: 'Advanced',
    description:
        'Konfigurasi IP Addressing, Routing OSPF/BGP, VLAN, dan analisis heatmap Wi-Fi.',
    status: 'done',
  ),
  Course(
    id: '4',
    code: 'MUL03',
    title: 'Pengolahan Citra Digital',
    credits: 2,
    category: 'Multimedia',
    level: 'Intermediate',
    description:
        'Pembelajaran operasi piksel, transformasi geometris, kuantisasi, dan ruang warna YCbCr.',
    status: 'active',
  ),
  Course(
    id: '5',
    code: 'AI01',
    title: 'Kecerdasan Buatan',
    credits: 3,
    category: 'AI',
    level: 'Advanced',
    description:
        'Studi Inferensi Logika Fuzzy Sugeno, Teori Keputusan, Bayes, dan algoritma DFS/BFS.',
    status: 'active',
  ),
  Course(
    id: '6',
    code: 'DES01',
    title: 'Desain UI/UX',
    credits: 2,
    category: 'Design',
    level: 'Beginner',
    description:
        'Prinsip Design Thinking, pembuatan wireframe, prototyping, dan analisis kegunaan sistem.',
    status: 'active',
  ),
];

class MainAdaptiveShell extends StatefulWidget {
  const MainAdaptiveShell({super.key});

  @override
  State<MainAdaptiveShell> createState() => _MainAdaptiveShellState();
}

class _MainAdaptiveShellState extends State<MainAdaptiveShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    CoursesPage(),
    ProfileFeedbackPage(),
    DebuggingLabPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isExpanded = constraints.maxWidth >= 840;

        if (!isExpanded) {
          return Scaffold(
            body: SafeArea(child: _pages[_selectedIndex]),
            bottomNavigationBar: NavigationBar(
              backgroundColor: Colors.blue.shade50,
              indicatorColor: Colors.blue.shade200,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined, color: Colors.blue.shade900),
                  selectedIcon: Icon(Icons.home, color: Colors.blue.shade900),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.school_outlined, color: Colors.blue.shade900),
                  selectedIcon: Icon(Icons.school, color: Colors.blue.shade900),
                  label: 'Courses',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outlined, color: Colors.blue.shade900),
                  selectedIcon: Icon(Icons.person, color: Colors.blue.shade900),
                  label: 'Profile',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bug_report_outlined, color: Colors.blue.shade900),
                  selectedIcon: Icon(Icons.bug_report, color: Colors.blue.shade900),
                  label: 'Debug Lab',
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  backgroundColor: Colors.blue.shade50,
                  indicatorColor: Colors.blue.shade200,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  labelType: NavigationRailLabelType.all,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.shade700,
                      child: const Icon(Icons.menu_book, color: Colors.white),
                    ),
                  ),
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
                    NavigationRailDestination(
                      icon: Icon(Icons.bug_report_outlined),
                      selectedIcon: Icon(Icons.bug_report),
                      label: Text('Debug Lab'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _pages[_selectedIndex]),
              ],
            ),
          );
        }
      },
    );
  }
}

class StudentHeaderCard extends StatefulWidget {
  const StudentHeaderCard({super.key});

  @override
  State<StudentHeaderCard> createState() => _StudentHeaderCardState();
}

class _StudentHeaderCardState extends State<StudentHeaderCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.blue.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blue.shade700,
                  child: const Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'NIM: $studentId | Class: PTI 5A',
                        style: TextStyle(color: Colors.blue.shade800),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.blue.shade900,
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ],
            ),
            if (_isExpanded) ...[
              const Divider(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Status: Mahasiswa Aktif PTI Undiksha\nFokus: Pemrograman Mobile, UI/UX & Rekayasa Web',
                  style: TextStyle(fontSize: 12, color: Colors.blue.shade900),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    final List<String> skills = [
      'Flutter',
      'Dart',
      'Laravel',
      'PHP',
      'UI/UX Design',
      'Computer Network',
      'Digital Image Processing',
      'Git & GitHub'
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Course Explorer - Home')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentHeaderCard(),
            const SizedBox(height: 16),
            Card(
              elevation: 1,
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
                    Text(
                      'Informasi Lingkungan Layar (MediaQuery):',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                        'Width: ${size.width.toStringAsFixed(0)} px | Height: ${size.height.toStringAsFixed(0)} px'),
                    Text('Orientation: ${orientation.name}'),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(
                        size.width < 600
                            ? 'Mode: Compact (< 600px)'
                            : 'Mode: Wide (>= 600px)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      backgroundColor: size.width < 600
                          ? Colors.blue.shade100
                          : Colors.lightBlue.shade100,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Demo Proportion Flex Layout (2 : 1):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Flex 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Flex 1',
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Keterampilan Utama (Wrap Widget):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: skills.map((skill) {
                return Chip(
                  backgroundColor: Colors.blue.shade50,
                  side: BorderSide(color: Colors.blue.shade200),
                  avatar: Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Colors.blue.shade700,
                  ),
                  label: Text(
                    skill,
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CoursesSummary extends StatelessWidget {
  final int totalFavorites;
  final VoidCallback onClearAll;

  const CoursesSummary({
    super.key,
    required this.totalFavorites,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.blue.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Favorit Dipilih: $totalFavorites',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            TextButton.icon(
              onPressed: onClearAll,
              icon: const Icon(Icons.clear_all, size: 18),
              label: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  int _getCrossAxisCount(double width) {
    if (width < 600) return 1;
    if (width < 840) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Mata Kuliah')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final int columns = _getCrossAxisCount(constraints.maxWidth);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StudentHeaderCard(),
                const SizedBox(height: 12),
                Consumer<CourseState>(
                  builder: (context, courseState, child) {
                    return CoursesSummary(
                      totalFavorites: courseState.totalFavorites,
                      onClearAll: () =>
                          context.read<CourseState>().clearAllFavorites(),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  'Katalog Course (${dummyCourses.length} Item - Grid $columns Kolom):',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: constraints.maxWidth < 600 ? 2.3 : 1.8,
                    ),
                    itemCount: dummyCourses.length,
                    itemBuilder: (context, index) {
                      final course = dummyCourses[index];
                      return CourseCardWidget(course: course);
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

class CourseCardWidget extends StatelessWidget {
  final Course course;

  const CourseCardWidget({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<CourseState>().isFavorite(course.id);

    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.blue.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailPage(course: course),
            ),
          );
        },
        child: GestureDetector(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  course.title,
                  style: TextStyle(color: Colors.blue.shade900),
                ),
                content: Text(
                  'Kode: ${course.code}\nKategori: ${course.category}\nSKS: ${course.credits} SKS',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      backgroundColor: Colors.blue.shade100,
                      label: Text(
                        course.code,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                    IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav
                            ? Colors.blue.shade700
                            : Colors.blue.shade300,
                      ),
                      onPressed: () {
                        context.read<CourseState>().toggleFavorite(course.id);
                      },
                    ),
                  ],
                ),
                Text(
                  course.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                Text(
                  '${course.credits} SKS | Level: ${course.level}',
                  style: TextStyle(color: Colors.blue.shade700, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<CourseState>().isFavorite(course.id);

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
                      context.read<CourseState>().toggleFavorite(course.id);
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

class ProfileFeedbackPage extends StatefulWidget {
  const ProfileFeedbackPage({super.key});

  @override
  State<ProfileFeedbackPage> createState() => _ProfileFeedbackPageState();
}

class _ProfileFeedbackPageState extends State<ProfileFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _idController;
  final TextEditingController _commentsController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: studentName);
    _idController = TextEditingController(text: studentId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  void _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      final bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Konfirmasi Pengiriman',
            style: TextStyle(color: Colors.blue.shade900),
          ),
          content: Text(
            'Apakah Anda yakin ingin mengirim feedback atas nama ${_nameController.text}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
              ),
              child: const Text('Kirim'),
            ),
          ],
        ),
      );

      if (confirm == true) {
        setState(() => _isLoading = true);

        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          setState(() => _isLoading = false);
          _commentsController.clear();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Terima kasih! Feedback dari ${_nameController.text} ($studentId) berhasil dikirim.',
              ),
              backgroundColor: Colors.blue.shade800,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil & Form Umpan Balik')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentHeaderCard(),
            const SizedBox(height: 16),
            Card(
              elevation: 1,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Formulir Evaluasi Course Explorer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nama Mahasiswa',
                          prefixIcon:
                              Icon(Icons.person, color: Colors.blue.shade700),
                          border: const OutlineInputBorder(),
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
                        controller: _idController,
                        decoration: InputDecoration(
                          labelText: 'NIM Mahasiswa',
                          prefixIcon:
                              Icon(Icons.badge, color: Colors.blue.shade700),
                          border: const OutlineInputBorder(),
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
                        controller: _commentsController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Komentar / Feedback Praktikum',
                          prefixIcon:
                              Icon(Icons.feedback, color: Colors.blue.shade700),
                          border: const OutlineInputBorder(),
                          hintText: 'Tuliskan masukan minimal 5 karakter...',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().length < 5) {
                            return 'Komentar wajib terisi minimal 5 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submitFeedback,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                          ),
                          child: _isLoading
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text('Mengirim...'),
                                  ],
                                )
                              : const Text('Kirim Feedback'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DebuggingLabPage extends StatefulWidget {
  const DebuggingLabPage({super.key});

  @override
  State<DebuggingLabPage> createState() => _DebuggingLabPageState();
}

class _DebuggingLabPageState extends State<DebuggingLabPage> {
  bool _isNavigating = false;

  void _safeNavigate() async {
    if (_isNavigating) return;
    setState(() => _isNavigating = true);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Demo Anti-Double Push')),
          body: const Center(
            child: Text('Halaman berhasil dibuka dengan aman!'),
          ),
        ),
      ),
    );

    if (mounted) {
      setState(() => _isNavigating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debugging Challenge Lab')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentHeaderCard(),
            const SizedBox(height: 16),
            Text(
              '1. Solusi Row Text Overflow (Expanded Wrapper):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '$studentId - $studentName - Teks yang sangat panjang ini tidak akan memicu RenderFlex Overflow karena telah dibungkus dengan widget Expanded secara tepat.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '2. Solusi Unbounded ListView dalam Column:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                        leading: Icon(
                          Icons.check_circle,
                          size: 18,
                          color: Colors.blue.shade700,
                        ),
                        title: Text(
                          'Item Terisolasi ${index + 1}',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '3. Solusi Mencegah Navigasi Ganda (Double Push Guard):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _isNavigating ? null : _safeNavigate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.touch_app),
              label: Text(
                _isNavigating
                    ? 'Sedang Membuka...'
                    : 'Uji Proteksi Double Tap Navigation',
              ),
            ),
          ],
        ),
      ),
    );
  }
}