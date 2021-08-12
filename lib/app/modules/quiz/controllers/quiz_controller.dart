import 'package:get/get.dart';

class QuizController extends GetxController {
  //TODO: Implement QuizController

  final count = 0.obs;
  final indexAnswer = 0.obs;

  late List<String> answers = [];

  @override
  void onInit() {
    super.onInit();
    answers = [
      'Resposta 1',
      'Resposta 2',
      'Resposta 3',
      'Resposta 4',
    ];
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  void handleQuestionValueChange(int? value) {
    indexAnswer.value = value!;
  }

  void handleSuspenseList(String? value) {
    int index = 0;

    for (final answer in answers) {
      if (answer == value) {
        indexAnswer.value = index;
        return;
      }
      index++;
    }
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
