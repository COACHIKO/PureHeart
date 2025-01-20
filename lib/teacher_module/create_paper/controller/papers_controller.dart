import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotebookController extends GetxController {
  final PageController pageController = PageController();
  final pages = RxList<List<List<Point>>>([[]]);
  final currentStroke = <Point>[].obs;
  final isWriting = false.obs;
  final isErasing = false.obs;
  final currentPage = 0.obs;

  void addPage() {
    pages.add([]);
  }

  void onPointerDown(PointerDownEvent event) {
    isWriting.value = true;
    currentStroke.value = [
      Point(event.localPosition.dx, event.localPosition.dy,
          pressure: event.pressure)
    ];
  }

  void onPointerMove(PointerMoveEvent event) {
    currentStroke.add(
      Point(event.localPosition.dx, event.localPosition.dy,
          pressure: event.pressure),
    );
    currentStroke.refresh(); // Refresh the list to trigger updates
  }

  void onPointerUp(PointerUpEvent event) {
    if (currentStroke.isNotEmpty) {
      pages[currentPage.value].add(List.from(currentStroke));
      currentStroke.clear();
      isWriting.value = false;
    }
  }

  void goToPage(int pageIndex) {
    if (pageIndex >= 0 && pageIndex < pages.length) {
      currentPage.value = pageIndex;
      pageController.jumpToPage(pageIndex);
    }
  }

  void toggleEraseMode() {
    isErasing.value = !isErasing.value;
  }
}

class Point {
  final double x;
  final double y;
  final double pressure;

  Point(this.x, this.y, {this.pressure = 1.0});
}
