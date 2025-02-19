// ignore_for_file: constant_identifier_names

class Variables {
  // static const address = '192.168.1.2';
  static const address = '90mo.shop';
//90mo.shop
  static const baseUrl = "https://$address/pureHeart/api/";
  static const String STUDENT_REQUEST_ACCOUNT =
      "${baseUrl}auth/student_register_request.php";
  static const String TEACHER_REQUEST_ACCOUNT =
      "${baseUrl}auth/teacher_register_request.php";
  static const String LOGIN = "${baseUrl}auth/login.php";

  static const String GET_SUBJECTS = "${baseUrl}get_data/get_subjects.php";
  static const String GET_STUDENTS = "${baseUrl}ad_center/get_student_ads.php";
  static const String GET_TEACHERS = "${baseUrl}ad_center/get_teacher_ads.php";
  static const String GET_STAGES = "${baseUrl}get_data/get_school_steps.php";
  static const String REQUEST_TRANSACTION =
      "${baseUrl}transactions/request_transaction.php";
  static const String STUDENT_ADD_AD = "${baseUrl}ad_center/student_ad_add.php";
  static const String GET_TEACHERS_SUBJECTS =
      "${baseUrl}get_data/get_teacher_subjects.php";

  static const String GET_ACCEPT_ADS = "${baseUrl}get_data/get_offers.php";
}
