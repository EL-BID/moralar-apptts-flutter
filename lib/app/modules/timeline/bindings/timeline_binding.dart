import 'package:get/get.dart';
import 'package:moralar_tts/app/providers/hive_provider.dart';

import '../../../providers/profile_provider.dart';
import '../controllers/timeline_controller.dart';

class TimelineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimelineController>(
      () => TimelineController(),
    );
    Get.lazyPut<ProfileProvider>(
      () => ProfileProvider(),
    );
    Get.lazyPut<HiveProvider>(
          () => HiveProvider(),
    );
  }
}
