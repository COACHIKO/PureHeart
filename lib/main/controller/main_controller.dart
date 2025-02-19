import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pureheartapp/core/services/shared_pref/shared_pref.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/app_routes.dart';
import '../../core/utils/network_helper.dart';
import '../../core/utils/text_styles.dart';
import '../../core/utils/variables.dart';
import '../../teacher_module/teacher_auth/teacher_login/model/student_response.dart';
import '../../teacher_module/teacher_auth/teacher_login/model/subject_response.dart';
import '../components/header_section.dart';
import '../view/main_view.dart';
import '../user_data_model.dart';

class MainController extends GetxController {
  NetworkAPICall apiCall = NetworkAPICall();
  RxBool showSideNumbers = false.obs;

  var selectedItemIndex = 0.obs;
  var currentImageIndex = 0.obs;
  var selectedIndex = 0.obs;
  RxInt selectedUnit = 0.obs;
  final CarouselSliderController carouselController =
      CarouselSliderController();
  var selectedGrade = ''.obs;
  late List<Subject> subjects = [];
  late RxList<StudentAd> studentAds = <StudentAd>[].obs;
  late RxList<TeacherAd> teacherAds = <TeacherAd>[].obs;
  RxInt selectedHour = 0.obs;
  RxList<Session> sessions = <Session>[].obs;
  RxInt totalBalance = 0.obs;

  // Add these properties for session management
  TextEditingController lessonTitleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  Rx<Subject?> selectedSubject = Rx<Subject?>(null);

  @override
  onInit() async {
    super.onInit();
    getUserData();
    await getSubjects();
    if (subjects.isNotEmpty) {
      await getStudents(subjects[0].id.toString());
    }
  }

  Future<void> getSubjects() async {
    try {
      var res = await apiCall.getDataAsGuest(Variables.GET_SUBJECTS);

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

  void showGradeDialog(
      BuildContext context, String stage, List<String> grades) {
    Get.dialog(
      useSafeArea: true,
      Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              children: grades
                  .map(
                    (grade) => ListTile(
                      title: Text(
                        grade,
                        style: TextStyles.primary616,
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        selectedGrade.value = "$stage - $grade";
                        Get.back();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getStudents(String subjectId) async {
    try {
      final bool studentUser = isStudent();
      final String endpoint =
          studentUser ? Variables.GET_TEACHERS : Variables.GET_STUDENTS;

      var res = await apiCall.getDataAsGuest(
          "$endpoint?subject_id=$subjectId&student_stage=3&student_price=400&unit_num=${selectedUnit.value}&time=${selectedHour.value}");

      if (res.statusCode == 200) {
        var utf8DecodedBody = utf8.decode(res.bodyBytes);
        var parsedJson = json.decode(utf8DecodedBody);

        if (studentUser) {
          TeacherAdsResponse teacherAdResponse =
              TeacherAdsResponse.fromJson(parsedJson);
          teacherAds.value = teacherAdResponse.data;
          print("Loaded ${teacherAds.length} teacher ads");
        } else {
          StudentAdsResponse studentAdResponse =
              StudentAdsResponse.fromJson(parsedJson);
          studentAds.value = studentAdResponse.data;
          print("Loaded ${studentAds.length} student ads");
        }

        update();
      } else {
        print("Error: API request failed with status code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching ads: $e");
      // Optionally clear the lists in case of error
      studentAds.clear();
      teacherAds.clear();
    }
  }

  Future<void> requestTransaction(int teacherId, int amount, int adId) async {
    try {
      var res = await apiCall.postData(Variables.REQUEST_TRANSACTION, {
        "student_id": SharedPref.preferences.getString("student_id"),
        "teacher_id": teacherId,
        "amount": amount
      });

      var parsedJson = json.decode(res.body);
      if (parsedJson['status'] == "success") {
        await acceptOffer(adId);
      } else {
        Get.snackbar(
          "خطأ",
          "أنت لا تملك النقاط الكافية",
        );
      }

      await getUserData();

      update();
    } catch (e) {
      print("Error fetching ads: $e");
    }
  }

  Future<void> acceptOffer(int adId) async {
    try {
      var res = await apiCall.postData(Variables.GET_ACCEPT_ADS, {
        "ad_id": adId,
        isStudent() ? "student_id" : "teacher_id": (isStudent()
            ? SharedPref.preferences.getString("student_id")
            : SharedPref.preferences.getString("teacher_id"))
      });
      print(res.body);

      if (res.statusCode == 200) {
        await getUserData();

        update();
      } else {
        print("Error: API request failed with status code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching ads: $e");
    }
  }

  Future<void> getUserData() async {
    try {
      String? id = isStudent()
          ? SharedPref.preferences.getString("student_id")
          : SharedPref.preferences.getString("teacher_id");
      var res = await apiCall.getData(
          "${Variables.GET_ACCEPT_ADS}?id=$id&isStudent=${isStudent() ? 1 : 0}");

      if (res.statusCode == 200) {
        var utf8DecodedBody = utf8.decode(res.bodyBytes);
        SessionResponse sessionResponse =
            SessionResponse.fromJson(utf8DecodedBody);
        sessions.value = sessionResponse.sessions;

        // Calculate total balance
        totalBalance.value =
            sessions.fold(0, (sum, session) => sum + session.balance);

        update();
      } else {
        print("Error: API request failed with status code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching sessions: $e");
      sessions.clear();
    }
  }

  Future<void> teacherPublishAd({TimeOfDay? time}) async {
    try {
      // Validation checks
      if (time == null) {
        Get.snackbar('خطأ', 'الرجاء اختيار الوقت');
        return;
      }

      if (selectedSubject.value == null) {
        Get.snackbar('خطأ', 'الرجاء اختيار المادة');
        return;
      }

      if (priceController.text.isEmpty) {
        Get.snackbar('خطأ', 'الرجاء إدخال السعر');
        return;
      }

      // Format time in 24-hour format (HH:mm)
      String formattedTime =
          "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

      // Debug prints
      print("Sending data to API:");
      print("Time: $formattedTime");
      print("Price: ${priceController.text}");
      print("Subject ID: ${selectedSubject.value?.id}");
      print("Selected Index: ${selectedItemIndex.value}");
      print(
          "Teacher Token: ${SharedPref.sharedPreferences.getString("token")}");

      final apiData = isStudent()
          ? {
              "student_token": SharedPref.sharedPreferences.getString("token"),
              "student_price": priceController.text,
              "subject_id": selectedSubject.value!.id,
              "unit_num": selectedItemIndex.value + 1,
              "time": formattedTime,
              "student_stage": 3
            }
          : {
              "teacher_token": SharedPref.sharedPreferences.getString("token"),
              "teacher_price": priceController.text,
              "subject_id": selectedSubject.value!.id,
              "unit_num": selectedItemIndex.value + 1,
              "time": formattedTime,
            };

      print("API Request Data: $apiData");

      var res = await apiCall.postData(
          isStudent() ? Variables.STUDENT_ADD_AD : Variables.GET_TEACHERS,
          apiData);

      print("API Response: ${res.body}");

      if (res.statusCode == 200) {
        Get.offAllNamed(AppRoutes.main);
      } else {
        Get.snackbar('خطأ', 'حدث خطأ أثناء إنشاء الجلسة');
      }
    } catch (e, stackTrace) {
      debugPrint("Error creating session: $e");
      debugPrint("Stack trace: $stackTrace");
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع');
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

  void updateSelectedHour(int hour) {
    selectedHour.value = hour;
    update();
  }

  @override
  void onClose() {
    lessonTitleController.dispose();
    priceController.dispose();
    super.onClose();
  }

  List<String> imagesList = [
    AppImages.edu,
  ];
}
