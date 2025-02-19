class SchoolStagesResponse {
  final String status;
  final List<SchoolStep> schoolSteps;

  SchoolStagesResponse({
    required this.status,
    required this.schoolSteps,
  });

  factory SchoolStagesResponse.fromJson(Map<String, dynamic> json) {
    return SchoolStagesResponse(
      status: json['status'],
      schoolSteps: (json['school_steps'] as List)
          .map((step) => SchoolStep.fromJson(step))
          .toList(),
    );
  }
}

class SchoolStep {
  final int id;
  final String stepName;

  SchoolStep({
    required this.id,
    required this.stepName,
  });

  factory SchoolStep.fromJson(Map<String, dynamic> json) {
    return SchoolStep(
      id: json['id'],
      stepName: json['step_name'],
    );
  }
}
