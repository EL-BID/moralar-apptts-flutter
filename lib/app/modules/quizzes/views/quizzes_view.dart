import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/quizzes_controller.dart';

class QuizzesView extends GetView<QuizzesController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Questionários',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Obx(() {
                return Visibility(
                  visible: controller.isLoading.value,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 256),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  replacement: Visibility(
                    visible: controller.quizzes.isNotEmpty,
                    child: Column(
                      children: List.generate(
                        controller.quizzes.length,
                        (index) => QuizCard(
                          quiz: controller.quizzes[index],
                          function: () {
                            if (controller.quizzes[index].typeStatus == 1) {
                              Get.toNamed(
                                Routes.ANSWERS,
                                arguments: [
                                  controller.quizzes[index].quizId,
                                  controller.quizzes[index].familyId,
                                ],
                              );
                            } else {
                              Get.toNamed(
                                Routes.QUIZ,
                                arguments: [
                                  controller.quizzes[index].quizId,
                                  controller.quizzes[index].familyId ?? "",
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    replacement: Container(
                      padding: const EdgeInsets.symmetric(vertical: 256),
                      child: Text(
                        'Nenhum Questionário encontrado',
                        style: textTheme.headlineLarge,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
