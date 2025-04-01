import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_tts/app/providers/profile_provider.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/quiz_provider.dart';

class AnswersController extends GetxController {
  final _profileProvider = Get.find<ProfileProvider>();
  final _quizProvider = Get.find<QuizProvider>();
  final isLoading = false.obs;
  final title = 'Questionário ou Enquete'.obs;
  final multiplyResponses = [<bool>[]];
  final questionResponses = [<String>[]];
  String familyId = '';
  String quizId = '';
  final List<String?> ids = Get.arguments;

  final user = TTS(jobPost: '', name: '', cpf: '', email: '', id: '').obs;

  //Classes
  final answer = <AnswerDetails>[].obs;
  final quiz = QuizDetails(
          id: Get.arguments[0],
          questionViewModel: [],
          title: '',
          typeQuiz: 0,
          created: 0)
      .obs;

  Future<void> getAnswers() async {
    isLoading.value = true;
    try {
      answer.value = await _quizProvider.getAnswerDetails(quizId, familyId);
      isLoading.value = false;
      title.value = answer[0].title;
      getQuiz();
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

  List<bool> getCheckboxQuestionValue(String answersEncrypted) {
    return CheckboxUtil.getCheckboxQuestionValue(answersEncrypted);
  }

  List<String> getCheckboxAnswers(String answersEncrypted) {
    if (answersEncrypted.contains('{')) {
      return CheckboxUtil.getCheckboxAnswers(answersEncrypted);
    } else {
      return [answersEncrypted];
    }
  }

  Future<void> getQuiz() async {
    isLoading.value = true;
    try {
      quiz.value = await _quizProvider.getQuizDetails(quizId);
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

  Future<void> getInfo() async {
    isLoading.value = true;
    try {
      user.value = await _profileProvider.getInfo();
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
    getInfo();
    quizId = ids[0]!;
    familyId = ids[1]!;
    getAnswers();
  }

  @override
  void onClose() {}
}
