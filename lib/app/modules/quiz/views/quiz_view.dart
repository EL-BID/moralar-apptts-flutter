import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final PageController pageController = PageController();

    _content() {
      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const QuizHeader(quizLength: 10, number: 1),
                  const SizedBox(height: 64),
                  OpenQuestion(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          MoralarButton(
            onPressed: () => pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Continuar',
                style: textTheme.button,
              ),
            ),
          ),
        ],
      );
    }

    _content2() {
      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const QuizHeader(quizLength: 10, number: 2),
                  const SizedBox(height: 64),
                  Obx(() {
                    return ListQuestion(
                      index: controller.indexAnswer.value,
                      answers: controller.answers,
                      onChanged: controller.handleSuspenseList,
                    );
                  }),
                ],
              ),
            ),
          ),
          MoralarButton(
            onPressed: () => pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Continuar',
                style: textTheme.button,
              ),
            ),
          ),
        ],
      );
    }

    _content3() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const QuizHeader(quizLength: 10, number: 3, onlyAnswer: true),
                  Obx(() {
                    return CloseQuestion(
                      questionIndex: controller.indexAnswer.value,
                      answers: controller.answers,
                      onChanged: controller.handleQuestionValueChange,
                    );
                  }),
                ],
              ),
            ),
          ),
          MoralarButton(
            onPressed: () => pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Continuar',
                style: textTheme.button,
              ),
            ),
          ),
        ],
      );
    }

    _content4() {
      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const QuizHeader(quizLength: 10, number: 4),
                  Obx(() {
                    return CloseQuestion(
                      questionIndex: controller.indexAnswer.value,
                      answers: const ['1', '2', '3', '4', '5', '6'],
                      onChanged: controller.handleQuestionValueChange,
                    );
                  }),
                ],
              ),
            ),
          ),
          MoralarButton(
            onPressed: () => pageController.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Continuar',
                style: textTheme.button,
              ),
            ),
          ),
        ],
      );
    }

    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Questionário',
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: PageView(
          controller: pageController,
          children: [_content(), _content2(), _content3(), _content4()],
        ),
      ),
    );
  }
}
