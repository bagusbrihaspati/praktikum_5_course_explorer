import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/student_header_card.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class DebuggingLabPage extends StatefulWidget {
  const DebuggingLabPage({super.key});

  @override
  State<DebuggingLabPage> createState() => _DebuggingLabPageState();
}

class _DebuggingLabPageState extends State<DebuggingLabPage> {
  bool _isNavigating = false;
  String _debugLog = 'Belum ada pengujian yang dijalankan.';

  // Kasus D: Penanganan asinkron dengan guard if (mounted)
  void _safeNavigate() async {
    if (_isNavigating) return;
    setState(() {
      _isNavigating = true;
      _debugLog = 'Menjalankan navigasi aman dengan proteksi double-tap...';
    });

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

    // Kasus D: Wajib cek mounted sebelum setState setelah async
    if (mounted) {
      setState(() {
        _isNavigating = false;
        _debugLog = 'Kembali dari navigasi. State diperbarui aman karena widget masih mounted.';
      });
    }
  }

  // Kasus B: Demonstrasi pemanggilan Provider di luar context yang valid
  void _testProviderContextError() {
    try {
      // Memanggil Provider dari context dialog root yang terisolasi atau simulasi tanpa tipe
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text('Uji Kasus B', style: TextStyle(color: Colors.blue.shade900)),
            content: const Text(
              'Pada Kasus B, jika context berada di atas ChangeNotifierProvider, Flutter melempar ProviderNotFoundException.\n\nKonteks di dalam aplikasi ini sudah berada di bawah root Provider sehingga aman.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Tutup'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      setState(() {
        _debugLog = 'Error tertangkap: $e';
      });
    }
  }


// Kasus C: Uji memicu error state pada Provider
  void _triggerSimulatedError() {
    context.read<CourseProvider>().triggerSimulatedError(
      'Simulasi kegagalan membaca data REST API.',
    );
    setState(() {
      _debugLog = 'Kasus C: Error state berhasil dipicu ke CourseProvider. Cek halaman Courses!';
    });
  }

  // Pemulihan Kasus C
  void _resetError() {
    context.read<CourseProvider>().loadCourses();
    setState(() {
      _debugLog = 'Data berhasil dimuat ulang normal dari JSON.';
    });
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

            // Kartu Status Log Debugging
            Card(
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.terminal, color: Colors.blue.shade900),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _debugLog,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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
              'Eksperimen Kasus Debugging (Tahap 15):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),

            // Tombol Kasus C: Simulasi Error State
            ElevatedButton.icon(
              onPressed: _triggerSimulatedError,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.warning_amber),
              label: const Text('Kasus C: Picu Error State Provider'),
            ),
            const SizedBox(height: 8),

            // Tombol Pulihkan Kasus C
            OutlinedButton.icon(
              onPressed: _resetError,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue.shade800,
                side: BorderSide(color: Colors.blue.shade600),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Pulihkan Data Normal (loadCourses)'),
            ),
            const SizedBox(height: 16),

            // Tombol Kasus B & D
            ElevatedButton.icon(
              onPressed: _safeNavigate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.shield_outlined),
              label: Text(
                _isNavigating
                    ? 'Memproses Navigasi...'
                    : 'Kasus D: Uji Guard if (mounted)',
              ),
            ),
            const SizedBox(height: 8),

            ElevatedButton.icon(
              onPressed: _testProviderContextError,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                foregroundColor: Colors.blue.shade900,
              ),
              icon: const Icon(Icons.account_tree_outlined),
              label: const Text('Kasus B: Analisis Context Provider'),
            ),
          ],
        ),
      ),
    );
  }
}