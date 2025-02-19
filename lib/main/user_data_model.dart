import 'dart:convert';

class SessionResponse {
  final String status;
  final List<Session> sessions;

  SessionResponse({required this.status, required this.sessions});

  factory SessionResponse.fromJson(String str) =>
      SessionResponse.fromMap(json.decode(str));

  factory SessionResponse.fromMap(Map<String, dynamic> json) => SessionResponse(
        status: json["status"],
        sessions:
            List<Session>.from(json["sessions"].map((x) => Session.fromMap(x))),
      );
}

class Session {
  final int id;
  final int adId;
  final int teacherId;
  final int studentId;
  final int balance;

  final int status;
  final String createdAt;
  final String teacherName;
  final String studentName;
  final int subjectId;
  final String subjectName;
  final AdDetails adDetails;

  Session({
    required this.id,
    required this.adId,
    required this.teacherId,
    required this.balance,
    required this.studentId,
    required this.status,
    required this.createdAt,
    required this.teacherName,
    required this.studentName,
    required this.subjectId,
    required this.subjectName,
    required this.adDetails,
  });

  factory Session.fromMap(Map<String, dynamic> json) => Session(
        id: json["id"],
        adId: json["ad_id"],
        teacherId: json["teacher_id"],
        studentId: json["student_id"],
        status: json["status"],
        createdAt: json["created_at"],
        teacherName: json["teacher_name"],
        balance: json["balance"],
        studentName: json["student_name"],
        subjectId: json["subject_id"],
        subjectName: json["subject_name"],
        adDetails: AdDetails.fromMap(json["ad_details"]),
      );
}

class AdDetails {
  final int id;
  final int? studentId;
  final int? teacherId;
  final int? studentStage;
  final int? studentPrice;
  final int? teacherPrice;
  final int subjectId;
  final int unitNum;
  final String time;
  final String createdAt;
  final int status;

  AdDetails({
    required this.id,
    this.studentId,
    this.teacherId,
    this.studentStage,
    this.studentPrice,
    this.teacherPrice,
    required this.subjectId,
    required this.unitNum,
    required this.time,
    required this.createdAt,
    required this.status,
  });

  factory AdDetails.fromMap(Map<String, dynamic> json) => AdDetails(
        id: json["id"],
        studentId: json["student_id"],
        teacherId: json["teacher_id"],
        studentStage: json["student_stage"],
        studentPrice: json["student_price"],
        teacherPrice: json["teacher_price"],
        subjectId: json["subject_id"],
        unitNum: json["unit_num"],
        time: json["time"],
        createdAt: json["created_at"],
        status: json["status"],
      );
}
