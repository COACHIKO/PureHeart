import 'package:get/get.dart';

import '../../main/controller/main_controller.dart';
import '../../splash/controller/splash_controller.dart';
import '../../student_module/student_auth/student_login/controller/student_login_controller.dart';
import '../../teacher_module/create_session/controller/session_controller.dart';
import '../../teacher_module/students_preview/controller/student_preview_controller.dart';
import '../../teacher_module/teacher_auth/teacher_login/controller/teacher_login_controller.dart';

class InitializingDependency implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => StudentLoginController(), fenix: true);
    Get.lazyPut(() => TeacherLoginController(), fenix: true);
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => StudentsPreviewController(), fenix: true);
    Get.lazyPut(() => TeachersPreviewController(), fenix: true);
    Get.lazyPut(() => SessionController(), fenix: true);
  }
}
