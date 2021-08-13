import 'package:get/get.dart';

import '../controllers/answers_controller.dart';

class AnswersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnswersController>(
      () => AnswersController(),
    );
  }
}
