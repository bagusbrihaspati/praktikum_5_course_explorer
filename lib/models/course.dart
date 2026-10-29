const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class Course {
  final dynamic id;
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
    this.status = 'planned',
  });

  // Getter pembantu
  String get idString => id?.toString() ?? code;

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      // Konversi id langsung ke String agar aman dipakai di UI/Widget
      id: json['id']?.toString() ?? json['code']?.toString() ?? '',
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