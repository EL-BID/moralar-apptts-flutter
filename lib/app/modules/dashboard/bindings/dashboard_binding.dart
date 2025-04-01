import 'package:get/get.dart';

import '../../../providers/dashboard_provider.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<DashboardProvider>(
      () => DashboardProvider(),
    );
  }
}
