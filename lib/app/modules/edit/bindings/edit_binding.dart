import 'package:get/get.dart';

import '../../../providers/profile_provider.dart';
import '../../timeline/controllers/timeline_controller.dart';
import '../controllers/edit_controller.dart';

class EditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditController>(
      () => EditController(),
    );
    Get.lazyPut<TimelineController>(
      () => TimelineController(),
    );
    Get.lazyPut<ProfileProvider>(
      () => ProfileProvider(),
    );
  }
}
