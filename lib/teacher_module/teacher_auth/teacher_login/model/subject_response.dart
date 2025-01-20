class Subject {
  final int id;
  final String name;
  final String icon;

  Subject({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
    );
  }
}

class SubjectsResponse {
  final String status;
  final List<Subject> subjects;

  SubjectsResponse({
    required this.status,
    required this.subjects,
  });

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) {
    var subjectsList = json['subjects'] as List;
    List<Subject> subjects =
        subjectsList.map((subject) => Subject.fromJson(subject)).toList();

    return SubjectsResponse(
      status: json['status'] as String,
      subjects: subjects,
    );
  }
}
