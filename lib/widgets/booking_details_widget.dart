import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/gaps.dart';
import '../core/utils/text_styles.dart';
import 'image/svg_image_widget.dart';

class BookingDetailsWidget extends StatelessWidget {
  const BookingDetailsWidget(
      {super.key, this.bText, this.date, this.icon, this.time});
  final String? date, icon, time, bText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * .86,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgImageWidget(
            image: icon,
            width: 16,
            height: 18,
            fit: BoxFit.fill,
          ),
          horizontalGap(34),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date.toString(),
                style: TextStyles.secondary614,
              ),
              verticalGap(context.height * .0075),
              SizedBox(
                width: context.width * .57,
                child: Text(
                  time.toString(),
                  style: TextStyles.secondary410,
                ),
              ),
              verticalGap(context.height * .0075),
              Text(
                bText.toString(),
                style: TextStyles.primary512,
              ),
            ],
          )
        ],
      ),
    );
  }
}
