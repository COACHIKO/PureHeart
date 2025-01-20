import 'package:get/get.dart';

import '../../core/utils/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    Future.delayed(
      const Duration(seconds: 3),
      () => AppRoutes.routePushReplacement(AppRoutes.roleSelection),
    );

    super.onReady();
  }
}
