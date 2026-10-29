const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class Course {
  final dynamic id; // int? dari REST API atau String dari project sebelumnya
  final String code;
  final String title;
  final int credits;
  final String category;
  final String level;
  final String description;
  final String status;

  Course({
    this.id,
    required this.code,
    required this.title,
    required this.credits,
    this.category = 'General',
    this.level = 'Beginner',
    this.description = '',
    this.status = 'planned', // Nilai default 'planned' sesuai instruksi nomor 19
  });

  // Getter bantu jika membutuhkan id bertipe int murni
  int? get numericId {
    if (id is int) return id as int;
    if (id is String) return int.tryParse(id as String);
    return null;
  }

  // Factory constructor konversi JSON Map ke objek Course
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      code: (json['code'] as String?) ?? 'MOB${json['id'] ?? 0}',
      title: (json['title'] as String?) ?? 'Untitled Course',
      credits: json['credits'] is int
          ? json['credits'] as int
          : int.tryParse(json['credits']?.toString() ?? '') ?? 2,
      category: json['category'] as String? ?? 'General',
      level: json['level'] as String? ?? 'Beginner',
      description: json['description'] as String? ?? (json['body'] as String?) ?? '',
      status: (json['status'] as String?) ?? 'planned',
    );
  }

  // Method serialisasi dari Course ke Map JSON sesuai instruksi nomor 18
  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'code': code,
        'title': title,
        'credits': credits,
        'category': category,
        'level': level,
        'description': description,
        'status': status,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}