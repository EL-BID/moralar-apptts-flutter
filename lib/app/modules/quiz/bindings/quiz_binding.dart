import 'package:get/get.dart';
import 'package:moralar_tts/app/providers/hive_provider.dart';

import '../../../providers/quiz_provider.dart';
import '../../quizzes/controllers/quizzes_controller.dart';
import '../controllers/quiz_controller.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizController>(
      () => QuizController(),
    );
    Get.lazyPut<QuizzesController>(
      () => QuizzesController(),
    );
    Get.lazyPut<QuizProvider>(
      () => QuizProvider(),
    );
    Get.lazyPut<HiveProvider>(
      () => HiveProvider(),
    );
  }
}
