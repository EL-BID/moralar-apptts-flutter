import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/quiz_provider.dart';

class QuizzesController extends GetxController {
  final _quizProvider = Get.find<QuizProvider>();
  final isLoading = false.obs;

  //Classes
  final quizzes = <Quiz>[].obs;

  Future<void> getQuiz() async {
    isLoading.value = true;
    try {
      quizzes.value = await _quizProvider.getQuiz();
      isLoading.value = false;
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    getQuiz();
  }
}
