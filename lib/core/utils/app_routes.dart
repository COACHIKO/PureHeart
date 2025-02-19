import 'package:get/get.dart';
import 'package:pureheartapp/teacher_module/teacher_auth/teacher_login/view/teacher_login_view.dart';

import '../../add_money/add_money.dart';
import '../../main/view/main_view.dart';
import '../../request_status_feature/view/reqeuest_state_view.dart';
import '../../role_chose_feature/view/role_selection_view.dart';
import '../../splash/view/splash_view.dart';
import '../../student_module/student_auth/student_login/view/student_login_view.dart';
import '../../teacher_module/create_paper/view/create_paper.dart';
import '../../teacher_module/create_paper/view/papers.dart';
import '../../teacher_module/create_session/session.dart';
import '../../teacher_module/students_preview/view/student_preview.dart';
import '../services/shared_pref/shared_pref.dart';

class AppRoutes {
  static String splash = "/";
  static String signIn = "/signIn";
  static String studentLogin = "/StudentLogin";

  static String teacherLogin = "/TeacherLogin";
  static String roleSelection = "/roleSelection";
  static String main = "/main";
  static String studentPreview = "/studentPreview";
  static String teacherPreview = "/teacherPreview";
  static String createPaper = "/createPaper";
  static String notebookPage = "/notebookPage";
  static String createSession = "/createSession";
  static String addMoney = "/addMoney";
  static String reqeuestStateView = "/reqeuestStateView";

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashView()),
    GetPage(name: roleSelection, page: () => const RoleSelectionView()),
    GetPage(name: studentLogin, page: () => const StudentLoginView()),
    GetPage(name: teacherLogin, page: () => const TeacherLoginView()),
    GetPage(name: main, page: () => const MainView()),
    GetPage(name: studentPreview, page: () => const StudentPreviewView()),
    GetPage(name: teacherPreview, page: () => const TeacherPreviewView()),
    GetPage(name: createPaper, page: () => const CreatePaperView()),
    GetPage(name: notebookPage, page: () => NotebookPage()),
    GetPage(name: createSession, page: () => CreateSession()),
    GetPage(name: addMoney, page: () => AddMoney()),
    GetPage(name: reqeuestStateView, page: () => ReqeuestStateView()),
  ];

  static routePushReplacementUntil(String routeName) {
    Get.offNamedUntil(routeName, (route) => false);
  }

  static routePushReplacement(String routeName) {
    Get.offNamed(routeName);
  }

  static Future routePush(String routeName) async {
    await Get.toNamed(routeName);
  }

  static routePushArg(String routeName, Map<String, dynamic> arg) {
    Get.toNamed(routeName, arguments: arg);
  }

  static pop() {
    Get.back();
  }
}

String getInitialRoute() {
  bool? isAuthenticated =
      SharedPref.sharedPreferences.getString("token") != null;
  return isAuthenticated == true ? AppRoutes.main : AppRoutes.splash;
}
