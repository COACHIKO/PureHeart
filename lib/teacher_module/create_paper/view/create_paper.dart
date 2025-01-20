import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pureheartapp/core/utils/app_routes.dart';
import 'package:pureheartapp/core/utils/app_theme.dart';
import 'package:pureheartapp/core/utils/gaps.dart';

import '../../../core/services/shared_pref/shared_pref.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/text_styles.dart';
import '../../../widgets/image/image_widget.dart';

class CreatePaperView extends StatelessWidget {
  const CreatePaperView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Stack(
          children: [
            Positioned(
              top: context.height * .07,
              right: 24,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          horizontalGap(5),
                          Text(
                            SharedPref.sharedPreferences
                                .getString("teacher_name")!,
                            style: TextStyles.white614,
                          ),
                          Container(
                            color: Color(0xFF0030FF),
                            height: 15.h,
                            width: 80.w,
                            child: Center(
                              child: Text(
                                  "المعرف:  ${SharedPref.sharedPreferences.getString("teacher_id")!.toString()}"),
                            ),
                          )
                        ],
                      ),
                      horizontalGap(5),
                      CircleAvatar(
                        radius: context.width * .05,
                        child: ImageWidget(
                          image: AppImages.boy,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: context.height * .07,
              left: 24,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                iconSize: 24,
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppTheme.white,
                ),
              ),
            ),
            Positioned(
              top: context.height * .24,
              child: Container(
                width: context.width,
                height: context.height * .75,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: AppTheme.white,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                      0, context.height * .02, 0, context.height * .1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      verticalGap(context.height * .028),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 144,
                            width: 100,
                            decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                border: Border.all(
                                  width: 4,
                                  color: AppTheme.secondaryColor,
                                )),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                  color: AppTheme.white,
                                )),
                                Text(
                                  'ورق + pdf',
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 144,
                            width: 100,
                            decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                border: Border.all(
                                  width: 4,
                                  color: AppTheme.secondaryColor,
                                )),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                  color: AppTheme.white,
                                )),
                                Text(
                                  "ورق بياني",
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 144,
                            width: 100,
                            decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                border: Border.all(
                                  width: 4,
                                  color: AppTheme.primaryColor,
                                )),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                  color: AppTheme.white,
                                )),
                                Text(
                                  "ورق",
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalGap(context.height * .3),
                      MaterialButton(
                          minWidth: 170.w,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(25),
                                  right: Radius.circular(25))),
                          color: Color(0xFFE9A458),
                          onPressed: () {
                            Get.toNamed(AppRoutes.notebookPage);
                          },
                          child: Text(
                            "إنشاء",
                            style: TextStyles.black714,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class NotebookPage extends StatefulWidget {
//   const NotebookPage({super.key});

//   @override
//   State<NotebookPage> createState() => _NotebookPageState();
// }

// class _NotebookPageState extends State<NotebookPage> {
//   final PageController _pageController = PageController();
//   final List<List<List<Point>>> _pages = [[]]; // List of strokes per page
//   List<Point> _currentStroke = [];
//   bool _isWriting = false;
//   bool _isErasing = false;
//   int _currentPage = 0;

//   void _addPage() {
//     setState(() {
//       _pages.add([]);
//     });
//   }

//   void _onPointerDown(PointerDownEvent event) {
//     setState(() {
//       _isWriting = true;
//       _currentStroke = [
//         Point(event.localPosition.dx, event.localPosition.dy,
//             pressure: event.pressure)
//       ];
//     });
//   }

//   void _onPointerMove(PointerMoveEvent event) {
//     setState(() {
//       _currentStroke.add(
//         Point(event.localPosition.dx, event.localPosition.dy,
//             pressure: event.pressure),
//       );
//     });
//   }

//   void _onPointerUp(PointerUpEvent event) {
//     if (_currentStroke.isNotEmpty) {
//       setState(() {
//         _pages[_currentPage].add(List.from(_currentStroke));
//         _currentStroke = [];
//         _isWriting = false;
//       });
//     }
//   }

//   void _goToPage(int pageIndex) {
//     if (pageIndex >= 0 && pageIndex < _pages.length) {
//       setState(() {
//         _currentPage = pageIndex;
//         _pageController.jumpToPage(pageIndex);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         elevation: 0,
//         leadingWidth: 100,
//         leading: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildIconButton(Icons.arrow_back_ios_new, () {
//               Navigator.pop(context);
//             }),
//             _buildIconButton(Icons.add, _addPage),
//           ],
//         ),
//         actions: [
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () => _goToPage(_currentPage - 1),
//                 icon: const Icon(Icons.chevron_left, color: Colors.white),
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   "${_currentPage + 1} / ${_pages.length}",
//                   style: const TextStyle(color: Colors.black),
//                 ),
//               ),
//               IconButton(
//                 onPressed: () => _goToPage(_currentPage + 1),
//                 icon: const Icon(Icons.chevron_right, color: Colors.white),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Listener(
//         onPointerDown: _onPointerDown,
//         onPointerMove: _onPointerMove,
//         onPointerUp: _onPointerUp,
//         child: PageView.builder(
//           controller: _pageController,
//           physics: _isWriting
//               ? const NeverScrollableScrollPhysics()
//               : const AlwaysScrollableScrollPhysics(),
//           itemCount: _pages.length,
//           onPageChanged: (index) {
//             SchedulerBinding.instance.addPostFrameCallback((_) {
//               setState(() {
//                 _currentPage = index;
//               });
//             });
//           },
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       blurRadius: 10,
//                       spreadRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: CustomPaint(
//                   painter: DrawingPainter(
//                     strokes: _pages[index],
//                     currentStroke: _currentStroke,
//                     isErasing: _isErasing,
//                   ),
//                   child: Container(),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blue,
//         onPressed: () {
//           setState(() {
//             _isErasing = !_isErasing;
//           });
//         },
//         child: Icon(
//           _isErasing ? Icons.brush : Icons.delete,
//         ),
//       ),
//     );
//   }

//   Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
//     return Container(
//       alignment: Alignment.center,
//       height: 25,
//       width: 25,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.white),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: IconButton(
//         padding: EdgeInsets.zero,
//         icon: Icon(icon, size: 16, color: Colors.white),
//         onPressed: onPressed,
//       ),
//     );
//   }
// }

// class DrawingPainter extends CustomPainter {
//   final List<List<Point>> strokes;
//   final List<Point> currentStroke;
//   final bool isErasing;

//   DrawingPainter({
//     required this.strokes,
//     required this.currentStroke,
//     required this.isErasing,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = isErasing ? Colors.white : Colors.black
//       ..strokeWidth = 3.0
//       ..strokeCap = StrokeCap.round;

//     for (var stroke in strokes) {
//       for (int i = 0; i < stroke.length - 1; i++) {
//         canvas.drawLine(
//           Offset(stroke[i].x, stroke[i].y),
//           Offset(stroke[i + 1].x, stroke[i + 1].y),
//           paint,
//         );
//       }
//     }

//     for (int i = 0; i < currentStroke.length - 1; i++) {
//       canvas.drawLine(
//         Offset(currentStroke[i].x, currentStroke[i].y),
//         Offset(currentStroke[i + 1].x, currentStroke[i + 1].y),
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(DrawingPainter oldDelegate) => true;
// }

// class Point {
//   final double x;
//   final double y;
//   final double pressure;

//   Point(this.x, this.y, {this.pressure = 1.0});
// }
