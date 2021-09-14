import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/answers_controller.dart';

class AnswersView extends GetView<AnswersController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    _content(int index) {
      return Visibility(
        visible: controller.answer[index].typeResponse == 0,
        child: OpenQuestion(
          controller: TextEditingController(
            text: controller.answer[index].answers[0],
          ),
          readOnly: true,
          onChanged: (s) {},
        ),
        replacement: Visibility(
          visible: controller.answer[index].typeResponse == 1,
          child: MultiplyQuestion(
            questionValue: List.generate(
              controller.answer[index].answers.length,
              (index) {
                return true;
              },
            ),
            answers: controller.answer[index].answers,
            onChanged: (i) {},
          ),
          replacement: Visibility(
            visible: controller.answer[index].typeResponse == 2,
            child: CloseQuestion(
              questionIndex: 0,
              answers: controller.answer[index].answers,
              onChanged: (i) {},
            ),
            replacement: ListQuestion(
              index: 0,
              answers: controller.answer[index].answers,
              onChanged: (s) {},
            ),
          ),
        ),
      );
    }

    return Obx(() {
      return MoralarScaffold(
        appBar: MoralarAppBar(
          titleText: controller.title.value,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Visibility(
              visible: controller.isLoading.value,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 256),
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
              replacement: Column(
                children: List.generate(controller.answer.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.answer[index].question,
                        style: textTheme.bodyText2?.copyWith(
                          color: MoralarColors.waterBlue,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _content(index),
                      const SizedBox(height: 32),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      );
    });
  }
}
