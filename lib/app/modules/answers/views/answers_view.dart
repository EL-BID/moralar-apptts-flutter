import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/answers_controller.dart';

class AnswersView extends GetView<AnswersController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget _answerHeader() {
      return // ignore: lines_longer_than_80_chars
          Text(
        // ignore: lines_longer_than_80_chars
        'Lorem ipsum dolor sit amet, consecteturadipiscing  elit, sed do eiusmod tempor incididunt ut labore et  dolore magna aliqua. Ut enim ad minim veniam, quis  nostrudexercitation ullamco laboris nisi ut aliquip.',
        style: textTheme.bodyText2?.copyWith(
          color: MoralarColors.waterBlue,
        ),
      );
    }

    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Questionário',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _answerHeader(),
              OpenQuestion(
                // ignore: lines_longer_than_80_chars
                controller: TextEditingController(
                    text:
                        // ignore: lines_longer_than_80_chars
                        'ecteturadipiscing  elit, sed do eiusmod tempor incididunt ut labore et  dolore magna aliqua. Ut enim ad minim veniam, quis  nostrudexercitation ullamco'),
              ),
              const SizedBox(height: 64),
              _answerHeader(),
              ListQuestion(
                index: 0,
                answers: const ['a'],
                onChanged: (s) {},
              ),
              const SizedBox(height: 64),
              _answerHeader(),
              CloseQuestion(
                questionIndex: 0,
                answers: const ['a', 'b', 'c', 'd'],
                onChanged: (i) {},
                activeColor: MoralarColors.brownishGrey,
              ),
              const SizedBox(height: 32),
              _answerHeader(),
              CloseQuestion(
                questionIndex: 3,
                answers: const ['a', 'b', 'c', 'd', 'e', 'f'],
                onChanged: (i) {},
                activeColor: MoralarColors.brownishGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
