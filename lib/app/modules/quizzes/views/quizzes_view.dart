import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/quizzes_controller.dart';

List<Widget> list = [
  // MoralarCard(
  //     status: 1, isQuiz: true, function: () => Get.toNamed(Routes.QUIZ)),
  // MoralarCard(
  //     status: 0, isQuiz: true, function: () => Get.toNamed(Routes.QUIZ)),
  // MoralarCard(
  //     status: 0, isQuiz: true, function: () => Get.toNamed(Routes.QUIZ)),
];

class QuizzesView extends GetView<QuizzesController> {
  @override
  Widget build(BuildContext context) {
    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Questionários',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: list,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
