import 'package:get/get.dart';
import 'package:pureheartapp/core/utils/app_routes.dart';

class RoleSelectionController extends GetxController {
  var selectedRole = "".obs;

  void selectRole(String role) {
    selectedRole.value = role;
    if (role == "student") {
      Get.toNamed(AppRoutes.studentLogin);
    } else {
      Get.toNamed(AppRoutes.teacherLogin);
    }
  }
}
