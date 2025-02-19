import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pureheartapp/core/utils/app_images.dart';
import 'package:pureheartapp/widgets/image/image_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../core/utils/app_icons.dart';
import '../core/utils/gaps.dart';
import '../core/utils/text_styles.dart';
import '../widgets/image/svg_image_widget.dart';

class AddMoney extends StatelessWidget {
  const AddMoney({super.key});

  void _showQrDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              width: 268.0,
              height: 268.0,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(23.0),
                border: Border.all(color: Colors.white),
              ),
              child: Center(
                child: QrImageView(
                  data: "login",
                  size: 200,
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: Colors.white,
                  ),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Text(
                //       "👋",
                //       style: TextStyle(fontSize: 22.sp),
                //     ),
                //     horizontalGap(5),
                //     Column(
                //       children: [
                //         horizontalGap(5),
                //         Text(
                //           isStudent()
                //               ? SharedPref.sharedPreferences
                //                   .getString("student_name")!
                //               : SharedPref.sharedPreferences
                //                   .getString("teacher_name")!,
                //           style: TextStyles.white614,
                //         ),
                //         Container(
                //           color: Color(0xFF0030FF),
                //           height: 15.h,
                //           width: 80.w,
                //           child: Center(
                //             child: Text(
                //                 "المعرف:  ${isStudent() ? SharedPref.sharedPreferences.getString("student_id")!.toString() : SharedPref.sharedPreferences.getString("teacher_id")!.toString()}"),
                //           ),
                //         )
                //       ],
                //     ),
                //     horizontalGap(5),
                //     CircleAvatar(
                //       radius: context.width * .05,
                //       child: ImageWidget(
                //         image: AppImages.boy,
                //       ),
                //     ),
                //   ],
                // ),
                verticalGap(150),
                SvgImageWidget(
                  image: AppIcons.wallet,
                  width: 180,
                  height: 180,
                ),
                // ImageWidget(
                //   image: AppImages.wallet,
                //   width: 180,
                //   height: 180,
                // ),
                Text(
                  "1000 دينار",
                  style: TextStyles.white614
                      .copyWith(fontSize: 22.sp, color: Colors.white),
                ),
                verticalGap(20),
                verticalGap(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () => _showQrDialog(context),
                        child: Column(
                          children: [
                            verticalGap(10),
                            ImageWidget(
                              image: AppImages.withdraw,
                              width: 120,
                              height: 120,
                            ),
                            Text(
                              "سحب",
                              style: TextStyles.white824.copyWith(fontSize: 35),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () => _showQrDialog(context),
                        child: Column(
                          children: [
                            ImageWidget(
                              image: AppImages.pay,
                              width: 120,
                              height: 120,
                            ),
                            Text(
                              "دفع",
                              style: TextStyles.white824.copyWith(fontSize: 35),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
