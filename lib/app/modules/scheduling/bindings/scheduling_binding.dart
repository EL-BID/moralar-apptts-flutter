import 'package:get/get.dart';

import '../../../providers/quiz_provider.dart';
import '../../../providers/scheduling_provider.dart';
import '../../rescheduling/controllers/rescheduling_controller.dart';
import '../../schedulings/controllers/schedulings_controller.dart';
import '../controllers/scheduling_controller.dart';

class SchedulingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReSchedulingController>(
      ReSchedulingController.new,
    );
    Get.lazyPut<SchedulingController>(
      SchedulingController.new,
    );
    Get.lazyPut<SchedulingsController>(
      SchedulingsController.new,
    );
    Get.lazyPut<SchedulingProvider>(
      SchedulingProvider.new,
    );
    Get.lazyPut<QuizProvider>(
      QuizProvider.new,
    );
  }
}
