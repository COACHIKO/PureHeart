import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/network_helper.dart';
import '../../core/utils/variables.dart';
import '../../teacher_module/teacher_auth/teacher_login/model/student_response.dart';
import '../../teacher_module/teacher_auth/teacher_login/model/subject_response.dart';
import '../view/main_view.dart';

class MainController extends GetxController {
  NetworkAPICall apiCall = NetworkAPICall();

  var selectedItemIndex = 0.obs;
  var currentImageIndex = 0.obs;
  final CarouselSliderController carouselController =
      CarouselSliderController();
  late List<Subject> subjects = [];
  late RxList<StudentAd> studentAds = <StudentAd>[].obs;
  late RxList<TeacherAd> teacherAds = <TeacherAd>[].obs;

  @override
  onInit() async {
    super.onInit();
    await getSubjects();
    if (subjects.isNotEmpty) {
      await getStudents(subjects[0].id.toString());
    }
  }

  Future<void> getSubjects() async {
    try {
      var res = await apiCall.getData(Variables.GET_SUBJECTS);

      if (res.statusCode == 200) {
        var parsedJson = json.decode(res.body);

        if (parsedJson is Map<String, dynamic>) {
          SubjectsResponse subjectsResponse =
              SubjectsResponse.fromJson(parsedJson);

          subjects = subjectsResponse.subjects;
          print(subjects.length);
          update();
        } else {
          print("Error: Unexpected response format");
        }
      } else {
        print(
            "Error: Unable to fetch subjects. Status Code: ${res.statusCode}");
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print("Error fetching subjects: $e");
    }
  }

  Future<void> getStudents(String subjectId) async {
    try {
      var res = await apiCall.getDataAsGuest(
          "${isStudent() ? Variables.GET_TEACHERS : Variables.GET_STUDENTS}?subject_id=$subjectId");

      if (res.statusCode == 200) {
        var utf8DecodedBody = utf8.decode(res.bodyBytes);
        var parsedJson = json.decode(utf8DecodedBody);

        if (isStudent()) {
          TeacherAdsResponse teacherAdResponse =
              TeacherAdsResponse.fromJson(parsedJson);
          teacherAds.value = teacherAdResponse.data;
          teacherAds.forEach((element) {
            print(element.teacherName);
            print(element.subjectName);
            print(element.description);
          });
        } else {
          StudentAdsResponse studentAdResponse =
              StudentAdsResponse.fromJson(parsedJson);
          studentAds.value = studentAdResponse.data;
        }

        update();
      } else {
        print(
            "Error: Unable to fetch students. Status Code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching students: $e");
    }
  }

  void changeImageIndex(int index) {
    currentImageIndex.value = index;
  }

  void changeSelectedItemIndex(int index) {
    selectedItemIndex.value = index;
    getStudents(subjects[index].id.toString());
    update();
  }

  List<String> imagesList = [
    AppImages.edu,
  ];
}
