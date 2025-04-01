import 'package:get/get.dart';

import '../controllers/rescheduling_controller.dart';

class ReSchedulingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReSchedulingController>(
      ReSchedulingController.new,
    );
  }
}
