import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/network_helper.dart';
import '../../teacher_auth/teacher_login/model/student_response.dart';

class StudentsPreviewController extends GetxController {
  NetworkAPICall apiCall = NetworkAPICall();

  late RxList<StudentAd> studentAds = <StudentAd>[].obs;
  RxMap<int, String> radioSelections = <int, String>{}.obs;

  void updateRadioSelection(int studentId, String selection) {
    radioSelections[studentId] = selection;
    update();
  }

  Future<void> createSession(data) async {
    try {
      var res = await apiCall.postData(
          "http://192.168.1.2/pureHeart/api/ad_center/offer.php", data);
      print(res.body);
      if (res.statusCode == 200) {
        Get.offAllNamed(AppRoutes.main);
      }
    } catch (e) {
      debugPrint("Error fetching subjects: $e");
    }
  }
}

class TeachersPreviewController extends GetxController {
  NetworkAPICall apiCall = NetworkAPICall();
  late RxList<TeacherAd> teacherAds = <TeacherAd>[].obs;
  RxMap<int, String> radioSelections = <int, String>{}.obs;

  void updateRadioSelection(int studentId, String selection) {
    radioSelections[studentId] = selection;
    update();
  }

  Future<void> createSession(data) async {
    try {
      var res = await apiCall.postData(
          "http://192.168.1.2/pureHeart/api/ad_center/offer.php", data);
      print(res.body);
      if (res.statusCode == 200) {
        Get.offAllNamed(AppRoutes.main);
      }
    } catch (e) {
      debugPrint("Error fetching subjects: $e");
    }
  }
}
