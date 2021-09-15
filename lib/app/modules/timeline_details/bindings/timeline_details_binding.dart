import 'package:get/get.dart';

import '../../../providers/profile_provider.dart';
import '../../timeline/controllers/timeline_controller.dart';
import '../controllers/timeline_details_controller.dart';

class TimelineDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimelineDetailsController>(
      () => TimelineDetailsController(),
    );
    Get.lazyPut<TimelineController>(
      () => TimelineController(),
    );
    Get.lazyPut<ProfileProvider>(
      () => ProfileProvider(),
    );
  }
}
