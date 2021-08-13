import 'package:get/get.dart';

import '../controllers/timeline_details_controller.dart';

class TimelineDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimelineDetailsController>(
      () => TimelineDetailsController(),
    );
  }
}
