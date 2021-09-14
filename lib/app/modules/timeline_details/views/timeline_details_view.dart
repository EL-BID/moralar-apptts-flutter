import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/timeline_details_controller.dart';

class TimelineDetailsView extends GetView<TimelineDetailsController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MoralarScaffold(
      appBar: MoralarAppBar(
        titleText: 'Detalhes',
        backgroundColor: Family.statusColor(controller.user.typeSubject),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              FamilyCard(family: controller.user, isDetail: true),
              Obx(() {
                return Visibility(
                  visible: controller.isScheduleLoading.value,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 64),
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  replacement: Visibility(
                    visible: controller.user.typeSubject != 4,
                    child: SchedulingTTSCard(
                      status: controller.user.typeSubject,
                      schedule: controller.scheduleDetails.value,
                    ),
                    replacement: const PropertyTTSCard(isHouse: true),
                  ),
                );
              }),
              FamilyInfoCard(
                title: 'Questionários Respondidos',
                cards: Obx(() {
                  return Visibility(
                    visible: controller.isQuestLoading.value,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 64),
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    replacement: Visibility(
                      visible: controller.quest.isNotEmpty,
                      child: Column(
                        children:
                            List.generate(controller.quest.length, (index) {
                          return QuizTTSCard(
                            quiz: controller.quest[index],
                            function: () {
                              if (controller.quest[index].typeStatus == 1) {
                                Get.toNamed(
                                  Routes.ANSWERS,
                                  arguments: [
                                    controller.quest[index].id,
                                    controller.user.familyId,
                                  ],
                                );
                              } else {
                                Get.toNamed(
                                  Routes.QUIZ,
                                  arguments: [
                                    controller.quest[index].id,
                                    controller.user.familyId,
                                  ],
                                );
                              }
                            },
                          );
                        }),
                      ),
                      replacement: Container(
                        padding: const EdgeInsets.symmetric(vertical: 64),
                        child: Text(
                          'Nenhum Questionário encontrado',
                          style: textTheme.headline1,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              FamilyInfoCard(
                title: 'Enquetes',
                cards: Obx(() {
                  return Visibility(
                    visible: controller.isEnqLoading.value,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 64),
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    replacement: Visibility(
                      visible: controller.enq.isNotEmpty,
                      child: Column(
                        children: List.generate(controller.enq.length, (index) {
                          return QuizTTSCard(
                            quiz: controller.enq[index],
                            function: () {
                              if (controller.enq[index].typeStatus == 1) {
                                Get.toNamed(
                                  Routes.ANSWERS,
                                  arguments: [
                                    controller.enq[index].id,
                                    controller.user.familyId,
                                  ],
                                );
                              } else {
                                Get.toNamed(
                                  Routes.QUIZ,
                                  arguments: [
                                    controller.enq[index].id,
                                    controller.user.familyId,
                                  ],
                                );
                              }
                            },
                          );
                        }),
                      ),
                      replacement: Container(
                        padding: const EdgeInsets.symmetric(vertical: 64),
                        child: Text(
                          'Nenhuma Enquete encontrada',
                          style: textTheme.headline1,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              FamilyInfoCard(
                title: 'Cursos',
                cards: Obx(() {
                  return Visibility(
                    visible: controller.isCourseLoading.value,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 64),
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    replacement: Visibility(
                      visible: controller.courses.isNotEmpty,
                      child: Column(
                        children:
                            List.generate(controller.courses.length, (index) {
                          return CourseTTSCard(
                            course: controller.courses[index],
                          );
                        }),
                      ),
                      replacement: Container(
                        padding: const EdgeInsets.symmetric(vertical: 64),
                        child: Text(
                          'Nenhum Curso encontrado',
                          style: textTheme.headline1,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
