import 'package:get/get.dart';

import '../../../providers/timeline_provider.dart';
import '../controllers/timeline_controller.dart';

class TimelineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimelineController>(
      () => TimelineController(),
    );
    Get.lazyPut<TimelineProvider>(
      () => TimelineProvider(),
    );
  }
}
