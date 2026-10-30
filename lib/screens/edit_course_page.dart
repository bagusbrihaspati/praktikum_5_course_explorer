import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class EditCoursePage extends StatefulWidget {
  final Course course;

  const EditCoursePage({super.key, required this.course});

  @override
  State<EditCoursePage> createState() => _EditCoursePageState();
}

class _EditCoursePageState extends State<EditCoursePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _codeController;
  late final TextEditingController _titleController;
  late final TextEditingController _creditsController;
  late final TextEditingController _descController;
  late String _status;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Instruksi 42: Isi form edit dengan data lama
    _codeController = TextEditingController(text: widget.course.code);
    _titleController = TextEditingController(text: widget.course.title);
    _creditsController =
        TextEditingController(text: widget.course.credits.toString());
    _descController = TextEditingController(text: widget.course.description);
    _status = widget.course.status.isNotEmpty ? widget.course.status : 'planned';
  }

  @override
  void dispose() {
    _codeController.dispose();
    _titleController.dispose();
    _creditsController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submitUpdate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final updatedCourse = Course(
      id: widget.course.id,
      code: widget.course.code, // Tetap menggunakan code asli
      title: _titleController.text.trim(),
      credits: int.parse(_creditsController.text.trim()),
      description: _descController.text.trim(),
      status: _status,
    );

    final provider = context.read<CourseProvider>();
    // Instruksi 43 & 44: Kirim perubahan via provider
    final success = await provider.updateCourse(widget.course.id, updatedCourse);

    // Instruksi 44: Guard mounted pasca await
    if (!mounted) return;

    setState(() => _isSaving = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course berhasil diperbarui!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true); // Kembali dengan status berhasil
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui course: ${provider.error}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Colors.blue.shade50,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.blue.shade200),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Mahasiswa: $studentName ($studentId)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Instruksi 42: Field code dibuat read-only
              TextFormField(
                controller: _codeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Kode Mata Kuliah (Terkunci / Read-Only)',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Nama / Judul Mata Kuliah',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.book),
                ),
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Judul wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _creditsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah SKS',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_score),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'SKS wajib diisi';
                  if (int.tryParse(val.trim()) == null) return 'SKS harus angka';
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _descController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Singkat',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(
                  labelText: 'Status Course',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag),
                ),
                items: const [
                  DropdownMenuItem(value: 'planned', child: Text('Planned')),
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'done', child: Text('Done')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _status = val);
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: _isSaving ? null : _submitUpdate,
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(_isSaving ? 'Menyimpan...' : 'Perbarui Course'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}