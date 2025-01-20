import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/gaps.dart';
import 'image/svg_image_widget.dart';

class TabbarWidget extends StatelessWidget {
  TabbarWidget({this.image, this.name, this.onTap, super.key});
  String? image, name;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Column(
          children: [
            SvgImageWidget(
              image: image,
              height: 24,
              fit: BoxFit.fill,
            ),
            verticalGap(5),
            Text(
              name.toString().tr,
              // overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
