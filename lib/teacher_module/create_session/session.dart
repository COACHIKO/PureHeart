import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pureheartapp/widgets/image/svg_image_widget.dart';
import '../../core/services/shared_pref/shared_pref.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/app_theme.dart';
import '../../core/utils/gaps.dart';
import '../../core/utils/text_styles.dart';
import '../../main/components/header_section.dart';
import '../../main/controller/main_controller.dart';
import '../../main/view/main_view.dart';
import '../../student_module/student_auth/student_login/view/student_login_view.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/image/image_widget.dart';
import 'controller/session_controller.dart';

class CreateSession extends StatefulWidget {
  const CreateSession({super.key});

  @override
  _CreateSessionState createState() => _CreateSessionState();
}

class _CreateSessionState extends State<CreateSession> {
  TimeOfDay? pickedTime;
  final controller = Get.find<MainController>();
  String selectedPrice = '0';

  @override
  void initState() {
    super.initState();
    controller.priceController.text = selectedPrice;
  }

  Future<void> _showPriceDialog() async {
    String? newPrice = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController priceController = TextEditingController();
        return AlertDialog(
          title: Text('تحديد السعر', style: TextStyles.black714),
          content: TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'أدخل السعر',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                if (priceController.text.isNotEmpty) {
                  Navigator.pop(context, priceController.text);
                }
              },
              child: Text('موافق'),
            ),
          ],
        );
      },
    );

    if (newPrice != null && newPrice.isNotEmpty) {
      setState(() {
        selectedPrice = newPrice;
        controller.priceController.text = newPrice;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildSessionDetails(),
              _buildSideNumbersToggle(),
              _buildSubjectList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SvgImageWidget(
                image: AppIcons.wallet,
                width: 40.w,
                height: 40.h,
              ),
              Text(
                "المحفظة",
                style: TextStyles.white614
                    .copyWith(fontSize: 12.sp, color: Colors.white),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "22",
                style: TextStyles.white614
                    .copyWith(fontSize: 22.sp, color: Colors.white),
              ),
              Text(
                "التقييم",
                style: TextStyles.white614
                    .copyWith(fontSize: 12.sp, color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isStudent()
                        ? SharedPref.sharedPreferences
                            .getString("student_name")!
                        : SharedPref.sharedPreferences
                            .getString("teacher_name")!,
                    style: TextStyles.white614,
                  ),
                  Container(
                    color: Color(0xFF0030FF),
                    height: 15.h,
                    width: 80.w,
                    child: Center(
                      child: Text(
                        "المعرف:  ${isStudent() ? SharedPref.sharedPreferences.getString("student_id")!.toString() : SharedPref.sharedPreferences.getString("teacher_id")!.toString()}",
                      ),
                    ),
                  ),
                ],
              ),
              horizontalGap(5),
              CircleAvatar(
                radius: 20.w,
                child: ImageWidget(
                  image: AppImages.boy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSessionDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: context.width * 0.7,
                height: 390.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                            color: Colors.black,
                          ),
                          child: ImageWidget(
                            fit: BoxFit.fill,
                            image: AppImages.doctor,
                            width: double.infinity,
                            height: 219.h,
                          ),
                        ),
                        Positioned(
                          top: 10.h,
                          left: 10.w,
                          child: Text(
                            "4.6",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalGap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                        alwaysUse24HourFormat: true,
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                setState(() {});
                              },
                              child: ImageWidget(
                                image: AppImages.time,
                                width: 60.w,
                                height: 60.h,
                              ),
                            ),
                            verticalGap(5),
                            Text(
                              pickedTime == null
                                  ? "00:00"
                                  : "${pickedTime!.hour.toString().padLeft(2, '0')}:${pickedTime!.minute.toString().padLeft(2, '0')}",
                              style:
                                  TextStyles.black714.copyWith(fontSize: 12.sp),
                            ),
                          ],
                        ),
                        Container(
                          width: 1.w,
                          height: 70.h,
                          color: Colors.black,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: _showPriceDialog,
                              child: ImageWidget(
                                image: AppImages.dollar,
                                width: 60.w,
                                height: 60.h,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "دينار",
                                  style: TextStyles.black714
                                      .copyWith(fontSize: 12.sp),
                                ),
                                Text(
                                  " $selectedPrice",
                                  style: TextStyles.black714
                                      .copyWith(fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    verticalGap(20),
                    ButtonWidget(
                      height: 40.h,
                      width: 250.w,
                      tColor: Colors.black,
                      stringText: "نشر",
                      color: Color(0xFFB8E945),
                      onPressFunction: () async {
                        controller.priceController.text = selectedPrice;
                        await controller.teacherPublishAd(time: pickedTime);
                      },
                    ),
                  ],
                ),
              ),
              horizontalGap(10.w),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (controller.showSideNumbers.value)
                        Container(
                          height: 260.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            border: Border.all(color: Colors.orange),
                          ),
                          child: ListView.builder(
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.changeSelectedItemIndex(index);
                                },
                                child: Obx(
                                  () => Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyles.white614.copyWith(
                                            fontSize: 22.sp,
                                            color: controller.selectedItemIndex
                                                        .value ==
                                                    index
                                                ? Colors.orange
                                                : Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      if (index < 14)
                                        Divider(
                                          color: Colors.orange,
                                          thickness: 1,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      if (!controller.showSideNumbers.value)
                        horizontalGap(40.w),
                    ],
                  )),
            ],
          ),
          verticalGap(10.h),
        ],
      ),
    );
  }

  Widget _buildSideNumbersToggle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              _showStageDialog();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(() {
                return Text(
                  controller.selectedGrade.value.isNotEmpty
                      ? controller.selectedGrade.value
                      : "المرحلة الدراسية",
                  style: TextStyles.white614.copyWith(
                    fontSize: 14.sp,
                    color: Colors.orange.shade700,
                  ),
                );
              }),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.showSideNumbers.value =
                  !controller.showSideNumbers.value;
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "الفصل",
                style: TextStyles.white614.copyWith(
                  fontSize: 14.sp,
                  color: Colors.orange.shade700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showStageDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row for displaying the selected grade or prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => Text(
                      controller.selectedGrade.value.isNotEmpty
                          ? "الصف: ${controller.selectedGrade.value}"
                          : "اختر المرحلة الدراسية",
                      style: TextStyles.black714,
                    ),
                  ),
                  SizedBox(width: 5.w),
                ],
              ),
              SizedBox(height: 20.h), // Spacer between rows

              // Row for the StageBox widgets
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // StageBox for "اعدادى"
                  Flexible(
                    child: StageBox(
                      name: "اعدادى",
                      onTap: () => controller.showGradeDialog(
                        context,
                        "اعدادى",
                        ["الرابع", "الخامس", "السادس"],
                      ),
                    ),
                  ),

                  SizedBox(width: 8.w), // Spacer between StageBox widgets

                  // StageBox for "متوسط"
                  Flexible(
                    child: StageBox(
                      name: "متوسط",
                      onTap: () => controller.showGradeDialog(
                        context,
                        "متوسط",
                        ["الأول", "الثاني", "الثالث"],
                      ),
                    ),
                  ),

                  SizedBox(width: 8.w), // Spacer between StageBox widgets

                  // StageBox for "ابتدائى"
                  Flexible(
                    child: StageBox(
                      name: "ابتدائى",
                      onTap: () => controller.showGradeDialog(
                        context,
                        "ابتدائى",
                        [
                          "الأول",
                          "الثاني",
                          "الثالث",
                          "الرابع",
                          "الخامس",
                          "السادس",
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectList() {
    return FutureBuilder<void>(
      future: controller.getSubjects(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return SizedBox(
            width: context.width * 0.9,
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.subjects.length,
              itemBuilder: (context, index) {
                final subject = controller.subjects[index];
                return GestureDetector(
                  onTap: () {
                    controller.selectedSubject.value = subject;
                    controller.changeSelectedItemIndex(index);
                  },
                  child: Obx(
                    () => Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40.w,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 35.w,
                              backgroundColor:
                                  controller.selectedItemIndex.value == index
                                      ? Colors.orange
                                      : Colors.white,
                              child: CircleAvatar(
                                radius: 30.w,
                                backgroundColor: Colors.black,
                                child: ImageWidget(
                                  image: subject.icon,
                                ),
                              ),
                            ),
                          ),
                          verticalGap(5),
                          Text(
                            subject.name,
                            style: TextStyles.white409.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 9.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
