import 'package:get/get.dart';

import '../../../providers/quiz_provider.dart';
import '../controllers/answers_controller.dart';

class AnswersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnswersController>(
      () => AnswersController(),
    );
    Get.lazyPut<QuizProvider>(
      () => QuizProvider(),
    );
  }
}
