import 'package:get/get.dart';

import '../../../providers/profile_provider.dart';
import '../controllers/timeline_details_controller.dart';

class TimelineDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimelineDetailsController>(
      () => TimelineDetailsController(),
    );
    Get.lazyPut<ProfileProvider>(
      () => ProfileProvider(),
    );
  }
}
