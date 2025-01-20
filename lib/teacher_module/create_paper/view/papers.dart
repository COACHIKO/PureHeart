import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../controller/papers_controller.dart';

class NotebookPage extends StatelessWidget {
  NotebookPage({super.key});

  final NotebookController controller = Get.put(NotebookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leadingWidth: 100,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(Icons.arrow_back_ios_new, () {
              Navigator.pop(context);
            }),
            _buildIconButton(Icons.add, controller.addPage),
          ],
        ),
        actions: [
          Obx(() => Row(
                children: [
                  IconButton(
                    onPressed: () =>
                        controller.goToPage(controller.currentPage.value - 1),
                    icon: const Icon(Icons.chevron_left, color: Colors.white),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${controller.currentPage.value + 1} / ${controller.pages.length}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        controller.goToPage(controller.currentPage.value + 1),
                    icon: const Icon(Icons.chevron_right, color: Colors.white),
                  ),
                ],
              )),
        ],
      ),
      body: Listener(
        onPointerDown: controller.onPointerDown,
        onPointerMove: controller.onPointerMove,
        onPointerUp: controller.onPointerUp,
        child: Obx(() => PageView.builder(
              controller: controller.pageController,
              physics: controller.isWriting.value
                  ? const NeverScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemCount: controller.pages.length,
              onPageChanged: (index) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  controller.currentPage.value = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: CustomPaint(
                      painter: DrawingPainter(
                        strokes: controller.pages[index],
                        currentStroke: controller.currentStroke,
                        isErasing: controller.isErasing.value,
                      ),
                      child: Container(),
                    ),
                  ),
                );
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: controller.toggleEraseMode,
        child: Obx(() => Icon(
              controller.isErasing.value ? Icons.brush : Icons.delete,
            )),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      alignment: Alignment.center,
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 16, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<List<Point>> strokes;
  final List<Point> currentStroke;
  final bool isErasing;

  DrawingPainter({
    required this.strokes,
    required this.currentStroke,
    required this.isErasing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isErasing ? Colors.white : Colors.black
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    for (var stroke in strokes) {
      for (int i = 0; i < stroke.length - 1; i++) {
        canvas.drawLine(
          Offset(stroke[i].x, stroke[i].y),
          Offset(stroke[i + 1].x, stroke[i + 1].y),
          paint,
        );
      }
    }

    for (int i = 0; i < currentStroke.length - 1; i++) {
      canvas.drawLine(
        Offset(currentStroke[i].x, currentStroke[i].y),
        Offset(currentStroke[i + 1].x, currentStroke[i + 1].y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
