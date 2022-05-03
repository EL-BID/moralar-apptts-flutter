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
                  replacement: controller.scheduleDetails.value.date != null ? Visibility(
                    visible: controller.user.typeSubject != 4,
                    child: SchedulingTTSCard(
                      status: controller.user.typeSubject,
                      schedule: controller.scheduleDetails.value,
                      function: () {
                        controller.changeTypeSubject(8);
                      },
                    ),
                    replacement: Obx(() {
                      return Container(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: MoralarButton(
                          isLoading: controller.isButtonLoading.value,
                          child: Container(
                            alignment: Alignment.center,
                            child:
                                Text('Liberar Etapa', style: textTheme.button),
                          ),
                          onPressed: () {
                            controller.changeTypeSubject(2);
                          },
                        ),
                      );
                    }),
                  ) : SizedBox(),
                );
              }),
              if(controller.user.typeSubject == 4) FamilyInfoCard(
                title: 'Imóveis escolhidos',
                cards: Obx(() {
                  return Visibility(
                    visible: controller.isMatchsLoading.value,
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
                      visible: controller.properties.isNotEmpty,
                      child: Column(
                        children:
                            List.generate(controller.properties.length, (index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 24),
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  // spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Image.network(
                                  controller.properties[index].photo![0],
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MegaListTile(
                                  title: controller.properties[index].code ?? "",
                                  leading: Text("Código:", style: textTheme.bodyText1),
                                  style: textTheme.bodyText1,
                                ),
                                MegaListTile(
                                  title: (controller.properties[index].residencialPropertyFeatures.typeProperty == 0) ? 'Casa' : 'Apartamento',
                                  leading: Icon(
                                    (controller.properties[index].residencialPropertyFeatures.typeProperty == 0) ? Icons.house_outlined : Icons.apartment,
                                    size: 16,
                                    color: MoralarColors.brownGrey,
                                  ),
                                  style: textTheme.bodyText1,
                                ),
                                MegaListTile(
                                  title: controller.properties[index].residencialPropertyAdress.neighborhood ?? "",
                                  leading: const Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                    color: MoralarColors.brownGrey,
                                  ),
                                  style: textTheme.bodyText1,
                                ),
                                MegaListTile(
                                  title: "${controller.properties[index].residencialPropertyFeatures.squareFootage.toString()} m\u00B2",
                                  leading: const Icon(
                                    Icons.edit_outlined,
                                    size: 16,
                                    color: MoralarColors.brownGrey,
                                  ),
                                  style: textTheme.bodyText1,
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      replacement: Container(
                        padding: const EdgeInsets.symmetric(vertical: 64),
                        child: Text(
                          'Nenhum imóvel encontrado',
                          style: textTheme.headline1,
                        ),
                      ),
                    ),
                  );
                }),
              ),
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
                              }else {
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
