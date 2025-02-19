import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/text_styles.dart';
import '../../main/controller/main_controller.dart';
import '../../main/user_data_model.dart';
import '../../widgets/image/image_widget.dart';

class ReqeuestStateView extends StatelessWidget {
  const ReqeuestStateView({super.key});

  Map<String, List<Session>> _groupSessions(List<Session> sessions) {
    Map<String, List<Session>> grouped = {};
    for (var session in sessions) {
      String key = '${session.subjectName}_${session.adDetails.unitNum}';
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(session);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find<MainController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('حالة الطلبات', style: TextStyles.white720),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              ImageWidget(image: AppImages.card, fit: BoxFit.cover),
              Positioned(
                right: 60.w,
                top: 25,
                bottom: 0,
                child: Center(
                  child: Obx(() {
                    final totalPrice = controller.sessions.fold<double>(
                      0,
                      (sum, session) => sum + session.adDetails.studentPrice!,
                    );
                    return Text(
                      '${totalPrice.toStringAsFixed(2)}  ',
                      style: TextStyles.white720.copyWith(
                        fontSize: 22.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Obx(() {
                final groupedSessions = _groupSessions(controller.sessions);
                return ListView.builder(
                  itemCount: groupedSessions.length,
                  itemBuilder: (context, index) {
                    String key = groupedSessions.keys.elementAt(index);
                    List<Session> sessions = groupedSessions[key]!;
                    return _buildGroupedSessionCard(sessions, controller);
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupedSessionCard(
      List<Session> sessions, MainController controller) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            color: Color(0xFF48426D),
            margin: EdgeInsets.symmetric(vertical: 8.0.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.5,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                    ),
                    itemCount: sessions.length,
                    itemBuilder: (context, index) {
                      return _buildSessionTile(sessions[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: Get.width * .08,
          child: ImageWidget(
            image: controller.subjects
                .firstWhere((subject) => subject.id == sessions[0].subjectId,
                    orElse: () => controller.subjects.first)
                .icon,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildSessionTile(Session session) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Main oval container
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF654883),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.r),
                bottom: Radius.circular(25.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                // Profile picture
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 23.r,
                    backgroundColor: Colors.grey[300],
                    child: ImageWidget(
                      image: AppImages.boy,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                // Student name
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    session.studentName,
                    style: TextStyles.white614.copyWith(
                      fontSize: 12.sp,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // Status indicator dot
          Positioned(
            child: Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getStatusColor(session.status),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      case 3:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStatusBadge(int status) {
    String statusText;
    Color statusColor;

    switch (status) {
      case 1:
        statusText = 'في الانتظار';
        statusColor = Colors.orange;
        break;
      case 2:
        statusText = 'مقبول';
        statusColor = Colors.green;
        break;
      case 3:
        statusText = 'مكتمل';
        statusColor = Colors.blue;
        break;
      default:
        statusText = 'غير معروف';
        statusColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: statusColor),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: statusColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
