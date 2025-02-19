class StudentAd {
  final int id;
  final int studentId;
  final int studentStage;
  final int studentPrice;
  final int subjectId;
  final String time;
  final int status;
  final String studentName;
  final int studentRate;
  final String subjectName;
  final String studentStepName;
  final DateTime createdAt;

  StudentAd({
    required this.id,
    required this.studentId,
    required this.studentStage,
    required this.studentPrice,
    required this.subjectId,
    required this.time,
    required this.status,
    required this.studentName,
    required this.studentRate,
    required this.subjectName,
    required this.studentStepName,
    required this.createdAt,
  });

  factory StudentAd.fromJson(Map<String, dynamic> json) {
    return StudentAd(
      id: json['id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      studentStage: json['student_stage'] ?? 0,
      studentPrice: json['student_price'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
      time: json['time'] ?? '',
      status: json['status'] ?? 0,
      studentName: json['student_name'] ?? '',
      studentRate: json['student_rate'] ?? 0,
      subjectName: json['subject_name'] ?? '',
      studentStepName: json['student_step_name'] ?? '',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'student_stage': studentStage,
      'student_price': studentPrice,
      'subject_id': subjectId,
      'time': time,
      'status': status,
      'student_name': studentName,
      'student_rate': studentRate,
      'subject_name': subjectName,
      'student_step_name': studentStepName,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get timeSincePost {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return "منذ لحظات";
    } else if (difference.inMinutes < 60) {
      return "منذ ${difference.inMinutes} دقائق";
    } else if (difference.inHours < 24) {
      return "منذ ${difference.inHours} ساعات";
    } else if (difference.inDays < 7) {
      return "منذ ${difference.inDays} أيام";
    } else {
      return "منذ أكثر من أسبوع";
    }
  }
}

class StudentAdsResponse {
  final String status;
  final String message;
  final List<StudentAd> data;

  StudentAdsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StudentAdsResponse.fromJson(Map<String, dynamic> json) {
    return StudentAdsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((item) => StudentAd.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((ad) => ad.toJson()).toList(),
    };
  }
}

class TeacherAd {
  final int adId;
  final int teacherId;
  final int teacherPrice;
  final String description;
  final DateTime date;
  final int status;
  final DateTime createdAt;
  final String teacherName;
  final String subjectName;

  TeacherAd({
    required this.adId,
    required this.teacherId,
    required this.teacherPrice,
    required this.description,
    required this.date,
    required this.status,
    required this.createdAt,
    required this.teacherName,
    required this.subjectName,
  });

  // Factory constructor
  factory TeacherAd.fromJson(Map<String, dynamic> json) {
    return TeacherAd(
      adId: json['id'] ?? 0,
      teacherId: json['teacher_id'] ?? 0,
      teacherPrice: json['teacher_price'] ?? 0,
      description: json['description'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 0,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      teacherName: json['teacher_name'] ?? '',
      subjectName: json['subject_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': adId,
      'teacher_id': teacherId,
      'teacher_price': teacherPrice,
      'description': description,
      'date': date.toIso8601String(),
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'teacher_name': teacherName,
      'subject_name': subjectName,
    };
  }

  String get timeSincePost {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return "منذ لحظات";
    } else if (difference.inMinutes < 60) {
      return "منذ ${difference.inMinutes} دقائق";
    } else if (difference.inHours < 24) {
      return "منذ ${difference.inHours} ساعات";
    } else if (difference.inDays < 7) {
      return "منذ ${difference.inDays} أيام";
    } else {
      return "منذ أكثر من أسبوع";
    }
  }
}

class TeacherAdsResponse {
  final String status;
  final String message;
  final List<TeacherAd> data;

  TeacherAdsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  // Factory constructor to create an instance of TeacherAdsResponse from JSON
  factory TeacherAdsResponse.fromJson(Map<String, dynamic> json) {
    return TeacherAdsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((item) => TeacherAd.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // Method to convert an instance of TeacherAdsResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((ad) => ad.toJson()).toList(),
    };
  }
}
