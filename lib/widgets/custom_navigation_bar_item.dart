// import 'package:flutter/material.dart';
// import '../core/utils/app_icons.dart';
// import '../core/utils/app_images.dart';
// import '../core/utils/app_routes.dart';
// import '../core/utils/app_theme.dart';
// import '../core/utils/gaps.dart';

// import '../core/utils/text_styles.dart';
// import 'image/image_widget.dart';
// import 'image/svg_image_widget.dart';

// class CustomNavigationBarItem extends StatelessWidget {
//   String? label;
//   int? index;
//   String? icon;
//   final VoidCallback? onTap;

//   CustomNavigationBarItem(
//       {super.key, this.label, this.index, this.icon, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgImageWidget(
//             image: icon,
//             fit: BoxFit.cover,
//           ),
//           verticalGap(7),
//           Text(
//             label.toString(),
//             style: const TextStyle(
//                 fontSize: 8,
//                 fontWeight: FontWeight.w400,
//                 color: AppTheme.white),
//           )
//         ],
//       ),
//     );
//   }
// }
