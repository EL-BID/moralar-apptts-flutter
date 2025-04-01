import 'package:get/get.dart';

import '../../../providers/quiz_provider.dart';
import '../../../providers/scheduling_provider.dart';
import '../../aditionar_scheduling/controllers/aditionar_scheduling_controller.dart';
import '../../schedulings/controllers/schedulings_controller.dart';
import '../controllers/aditionar_scheduling_controller.dart';

class AditionarSchedulingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AditionarSchedulingController>(
      () => AditionarSchedulingController(),
    );
    Get.lazyPut<SchedulingsController>(
      () => SchedulingsController(),
    );
    Get.lazyPut<SchedulingProvider>(
      () => SchedulingProvider(),
    );
    Get.lazyPut<QuizProvider>(
      () => QuizProvider(),
    );
  }
}
