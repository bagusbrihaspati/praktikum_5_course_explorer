import 'package:flutter/material.dart';

// Identitas Mahasiswa
const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

void main() {
  runApp(const DebuggingChallengeApp());
}

class DebuggingChallengeApp extends StatelessWidget {
  const DebuggingChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahap 16 - Debugging Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const DebuggingChallengeShell(),
    );
  }
}

class DebuggingChallengeShell extends StatefulWidget {
  const DebuggingChallengeShell({super.key});

  @override
  State<DebuggingChallengeShell> createState() =>
      _DebuggingChallengeShellState();
}

class _DebuggingChallengeShellState extends State<DebuggingChallengeShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    CaseAPage(),
    CaseBPage(),
    CaseCPage(),
    CaseDPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 16: Debugging Challenge'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Mahasiswa: $studentName ($studentId)',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.looks_one),
            label: 'Kasus A',
          ),
          NavigationDestination(
            icon: Icon(Icons.looks_two),
            label: 'Kasus B',
          ),
          NavigationDestination(
            icon: Icon(Icons.looks_3),
            label: 'Kasus C',
          ),
          NavigationDestination(
            icon: Icon(Icons.looks_4),
            label: 'Kasus D',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// KASUS A: RenderFlex Overflow pada Row dengan Teks Panjang
// =============================================================================
class CaseAPage extends StatefulWidget {
  const CaseAPage({super.key});

  @override
  State<CaseAPage> createState() => _CaseAPageState();
}

class _CaseAPageState extends State<CaseAPage> {
  bool _isFixed = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: const Text('Tampilkan Solusi Terperbaiki'),
            value: _isFixed,
            onChanged: (val) => setState(() => _isFixed = val),
          ),
          const Divider(),
          const SizedBox(height: 12),
          const Text(
            'Demonstrasi Kasus A:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.amber.shade100,
            child: Row(
              children: [
                const Icon(Icons.info, color: Colors.indigo),
                const SizedBox(width: 8),
                if (_isFixed)
                  Expanded(
                    child: Text(
                      '$studentId - $studentName - Ini adalah teks informasi yang sangat panjang dan akan menyebabkan error RenderFlex overflow jika tidak dibungkus dengan Expanded atau Flexible.',
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
                else
                  Text(
                    '$studentId - $studentName - Ini adalah teks informasi yang sangat panjang dan akan menyebabkan error RenderFlex overflow jika tidak dibungkus dengan Expanded atau Flexible.',
                    style: const TextStyle(fontSize: 14),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// KASUS B: Vertical Viewport Was Given Unbounded Height
// =============================================================================
class CaseBPage extends StatefulWidget {
  const CaseBPage({super.key});

  @override
  State<CaseBPage> createState() => _CaseBPageState();
}

class _CaseBPageState extends State<CaseBPage> {
  bool _isFixed = true;

  final List<String> _items = List.generate(
    10,
    (index) => 'Mata Kuliah Modul ${index + 1} - $studentId',
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: const Text('Tampilkan Solusi Terperbaiki'),
            value: _isFixed,
            onChanged: (val) => setState(() => _isFixed = val),
          ),
          const Divider(),
          const Text(
            'Daftar Modul Pembelajaran:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (_isFixed)
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.book),
                      title: Text(_items[index]),
                    ),
                  );
                },
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.warning, color: Colors.orange),
                    title: Text('${_items[index]} (Tanpa Expanded)'),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

// =============================================================================
// KASUS C: Keyboard Overflow
// =============================================================================
class CaseCPage extends StatelessWidget {
  const CaseCPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.indigo.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Formulir Umpan Balik Kuantitatif\nMahasiswa: $studentName ($studentId)',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 150),
          const Text(
            'Masukan Peserta:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Catatan Pertemuan',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.edit),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Saran Pengembangan Mobile',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.comment),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Formulir berhasil dikirim!')),
                );
              },
              child: const Text('Kirim Form'),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// KASUS D: Navigasi Ganda (Multiple Route Push)
// =============================================================================
class CaseDPage extends StatefulWidget {
  const CaseDPage({super.key});

  @override
  State<CaseDPage> createState() => _CaseDPageState();
}

class _CaseDPageState extends State<CaseDPage> {
  bool _isNavigating = false;

  void _openDetailPage() async {
    if (_isNavigating) return;

    setState(() {
      _isNavigating = true;
    });

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DetailDummyPage(),
      ),
    );

    if (mounted) {
      setState(() {
        _isNavigating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Uji Pencegahan Navigasi Ganda\n$studentName ($studentId)',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _isNavigating ? null : _openDetailPage,
              icon: _isNavigating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.open_in_new),
              label: Text(_isNavigating ? 'Membuka...' : 'Buka Halaman Detail'),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// DETAIL PAGE DUMMY (Untuk Pengetesan Kasus D)
// =============================================================================
class DetailDummyPage extends StatelessWidget {
  const DetailDummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Detail'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 64, color: Colors.green),
              const SizedBox(height: 16),
              Text(
                'Halaman Detail Berhasil Dibatasi (Single Route)\nMahasiswa: $studentName ($studentId)',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}