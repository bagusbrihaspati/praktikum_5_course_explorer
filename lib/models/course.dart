const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class Course {
  final String id;
  final String code;
  final String title;
  final int credits;
  final String category;
  final String level;
  final String description;
  final String status;

  Course({
    required this.id,
    required this.code,
    required this.title,
    required this.credits,
    required this.category,
    required this.level,
    required this.description,
    this.status = 'active',
  });

  // Factory untuk memetakan data Map/JSON ke objek model Course
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id']?.toString() ?? json['code'] as String,
      code: json['code'] as String,
      title: json['title'] as String,
      credits: json['credits'] is int
          ? json['credits'] as int
          : int.tryParse(json['credits'].toString()) ?? 0,
      category: json['category'] as String? ?? 'General',
      level: json['level'] as String? ?? 'Beginner',
      description: json['description'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'credits': credits,
      'category': category,
      'level': level,
      'description': description,
      'status': status,
    };
  }
}