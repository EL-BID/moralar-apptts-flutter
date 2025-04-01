import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_tts/app/providers/hive_provider.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/quiz_provider.dart';
import '../../../routes/app_pages.dart';

class QuizController extends GetxController {
  final _quizProvider = Get.find<QuizProvider>();
  final _hiveProvider = Get.find<HiveProvider>();
  final isLoading = false.obs;
  final hasPageView = false.obs;
  final List<String?> ids = Get.arguments;
  String questionId = '';
  String userId = '';
  final PageController pageController = PageController();

  //Criação da tela
  final indexAnswer = <int>[].obs;
  final valueAnswer = [<bool>[].obs];

  //Classes
  final quiz = QuizDetails(
    id: Get.arguments[0],
    questionViewModel: [],
    title: '',
    typeQuiz: 0,
    created: 0
  ).obs;
  final answers = <Answer>[];

  Future<void> getQuizDetails() async {
    isLoading.value = true;
    if(await hasNetwork()){
      try {
        quiz.value = await _quizProvider.getQuizDetails(questionId);
        _hiveProvider.saveQuizDetails(quiz.value);
        await createAnswers(quiz.value.questionViewModel);
        hasPageView.value = true;
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
    }else {
      final result = await _hiveProvider.getQuizDetails(questionId);
      print(result?.title);
      if(result != null){
        quiz.value = result;
        await createAnswers(quiz.value.questionViewModel);
        hasPageView.value = true;
      }
      isLoading.value = false;
    }
    getAnswers();
  }

  Future<void> getAnswers() async {
    final answersAux = await _hiveProvider.getAnswers();
    if(answersAux.length == answers.length){
      answers.clear();
      answers.addAll(await _hiveProvider.getAnswers());
    }
    print(answers);
    indexAnswer.clear();
    for(int i = 0; i < quiz.value.questionViewModel.length; i++){
      if(quiz.value.questionViewModel[i].typeResponse == 2 && answers.length < i){
        indexAnswer.add(quiz.value.questionViewModel[i].description
            .indexWhere((element) => element.description == answers[i].answerDescription));
      }else{
        indexAnswer.add(0);
      }
    }
  }

  Future<void> createAnswers(List<QuestionResponse> questions) async {
    int index = 0;
    while (index < questions.length) {
      answers.add(
        Answer(
          questionId: questions[index].id,
          answerDescription: '',
          questionDescriptionId: [],
        ),
      );
      indexAnswer.add(0);
      final RxList<bool> initialValue = <bool>[].obs;
      valueAnswer.add(initialValue);
      index++;
    }
  }

  List<String> getDescriptionAnswers(
      List<Description> descriptions, int index) {
    final List<String> answers = [];
    for (Description description in descriptions) {
      answers.add(description.description);
      valueAnswer[index].add(false);
    }
    return answers;
  }

  Future<void> postAnswers() async {
    isLoading.value = true;
    try {
      final response = await _quizProvider.registerQuiz(
        userId,
        quiz.value.id,
        answers,
      );
      // for (var answer in answers) {
      //   print(userId);
      //   print(quiz.value.id);
      //   print(answer.toJson());
      // }

      Get.back();
      Get.back();
      // Get.toNamed(Routes.ANSWERS, arguments: quiz.value.id);
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

  Future<void> verifyAnswer(int index) async {
    final questions = quiz.value.questionViewModel;

    if (questions[index].typeResponse == 1) {
      int i = 0;
      String response = '';
      answers[index].questionDescriptionId!.clear();
      for (bool value in valueAnswer[index]) {
        if (value) {
          answers[index]
              .questionDescriptionId!
              .add(questions[index].description[i].id);
          response += '${questions[index].description[i].description} ';
        }
        i++;
      }
      if (response.isEmpty) {
        Get.snackbar(
          'Algo deu errado!',
          'Selecione pelo menos uma resposta',
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.strawberry,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        answers[index].answerDescription = response;
      }
    } else {
      if (answers[index].answerDescription!.isEmpty) {
        if (questions[index].typeResponse == 0) {
          Get.snackbar(
            'Algo deu errado!',
            'Digite uma resposta para prosseguir',
            colorText: MoralarColors.veryLightPink,
            backgroundColor: MoralarColors.strawberry,
            snackPosition: SnackPosition.TOP,
          );
          return;
        } else {
          answers[index].answerDescription =
              questions[index].description[0].description;
          answers[index]
              .questionDescriptionId!
              .add(questions[index].description[0].id);
        }
      }
    }

    if (index + 1 == questions.length) {
      if (await hasNetwork()) {
        postAnswers();
      }else{
        _hiveProvider.saveAnswers(answers);
        Get.snackbar(
          'Sem conexão!',
          "Você está sem conexão com a internet, porém suas respostas foram salvas!",
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.strawberry,
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if(ids[0] != null){
      questionId = ids[0]!;
    }
    if(ids[1] != null){
      userId = ids[1]!;
    }
    getQuizDetails();
  }
}
