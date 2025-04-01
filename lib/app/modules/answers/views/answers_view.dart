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
          child: MultiplyQuestionOnlyRead(
            questionValue: controller
                .getCheckboxQuestionValue(controller.answer[index].answers[0]),
            answers: controller
                .getCheckboxAnswers(controller.answer[index].answers[0]),
            onChanged: (i) {},
          ),
          replacement: Visibility(
            visible: controller.answer[index].typeResponse == 2,
            child: CloseQuestion(
              small: true,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dados do morador",
                      style: textTheme.bodyMedium?.copyWith(
                          color: MoralarColors.waterBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                  if (controller.answer.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Cadastro: ${controller.answer.first.familyNumber}",
                              style:
                                  textTheme.bodyMedium?.copyWith(fontSize: 16)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Nome: ${controller.answer.first.familyHolderName}",
                              style:
                                  textTheme.bodyMedium?.copyWith(fontSize: 16)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              "CPF: ${controller.answer.first.familyHolderCpf}",
                              style:
                                  textTheme.bodyMedium?.copyWith(fontSize: 16)),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Dados do questionário",
                      style: textTheme.bodyMedium?.copyWith(
                          color: MoralarColors.waterBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.answer.isNotEmpty &&
                            MoralarDate.secondsForDateHours(
                                        controller.answer.first.date ?? 0)
                                    .length >
                                10)
                          Text(
                              "Data: ${MoralarDate.secondsForDateHours(controller.answer.first.date ?? 0).substring(0, 10)}",
                              style:
                                  textTheme.bodyMedium?.copyWith(fontSize: 16)),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: List.generate(controller.answer.length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.answer[index].question,
                            style: textTheme.bodyMedium?.copyWith(
                              color: MoralarColors.waterBlue,
                            ),
                          ),
                          const SizedBox(height: 32),
                          _content(index),
                          const SizedBox(height: 32),
                        ],
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
