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
        backgroundColor:
            FamilyAsset.statusColor(controller.familyUser.typeSubject),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              FamilyCard(family: controller.familyUser, isDetail: true),
              Obx(() {
                if (controller.user.value.isNotEmpty &&
                    (controller.user.value.first.canNextStage ?? false)) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    child: MoralarButton(
                      onPressed: () {
                        controller.nextStage();
                      },
                      child: controller.isLoadingNextStage.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Liberar próxima etapa',
                                style: textTheme.labelLarge,
                              ),
                            ),
                    ),
                  );
                }
                return const SizedBox();
              }),
              FamilyInfoCard(
                title: 'Agendamentos',
                cards: Obx(() {
                  return Visibility(
                    visible: controller.isLoading.value,
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
                    replacement: (controller.user.value.isNotEmpty &&
                            controller.user.value.first.schedules!.isNotEmpty)
                        ? Column(
                            children: List.generate(
                                controller.user.value.first.schedules!.length,
                                (index) {
                              return SchedulingTTSCard(
                                status: controller.user.value.first
                                    .schedules![index].typeScheduleStatus!,
                                schedule: controller
                                    .user.value.first.schedules![index],
                                function: () {
                                  controller.changeTypeSubject(8);
                                },
                              );
                            }),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(vertical: 64),
                            child: Text(
                              'Nenhum agendamento encontrado',
                              style: textTheme.headlineLarge,
                            ),
                          ),
                  );
                }),
              ),
              if (controller.familyUser.typeSubject == 4)
                FamilyInfoCard(
                  title: 'Imóveis escolhidos',
                  cards: Obx(() {
                    return Visibility(
                      visible: controller.isLoading.value,
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
                      replacement: (controller.user.value.isNotEmpty &&
                              controller.user.value.first
                                  .interestResidencialProperty!.isNotEmpty)
                          ? Column(
                              children: List.generate(
                                  controller
                                      .user
                                      .value
                                      .first
                                      .interestResidencialProperty!
                                      .length, (index) {
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
                                      if (controller
                                              .user
                                              .value
                                              .first
                                              .interestResidencialProperty?[
                                                  index]
                                              .photo
                                              ?.isNotEmpty ??
                                          false)
                                        Image.network(
                                          controller
                                              .user
                                              .value
                                              .first
                                              .interestResidencialProperty![
                                                  index]
                                              .photo![0]['imageUrl'],
                                          fit: BoxFit.cover,
                                        ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MegaListTile(
                                        title: controller
                                                .user
                                                .value
                                                .first
                                                .interestResidencialProperty![
                                                    index]
                                                .code ??
                                            "",
                                        leading: Text("Código:",
                                            style: textTheme.bodyLarge),
                                        style: textTheme.bodyLarge,
                                      ),
                                      MegaListTile(
                                        title: (controller
                                                    .user
                                                    .value
                                                    .first
                                                    .interestResidencialProperty![
                                                        index]
                                                    .residencialPropertyFeatures
                                                    .typeProperty ==
                                                0)
                                            ? 'Casa'
                                            : 'Apartamento',
                                        leading: Icon(
                                          (controller
                                                      .user
                                                      .value
                                                      .first
                                                      .interestResidencialProperty![
                                                          index]
                                                      .residencialPropertyFeatures
                                                      .typeProperty ==
                                                  0)
                                              ? Icons.house_outlined
                                              : Icons.apartment,
                                          size: 16,
                                          color: MoralarColors.brownGrey,
                                        ),
                                        style: textTheme.bodyLarge,
                                      ),
                                      MegaListTile(
                                        title: controller
                                                .user
                                                .value
                                                .first
                                                .interestResidencialProperty![
                                                    index]
                                                .residencialPropertyAdress
                                                .neighborhood ??
                                            "",
                                        leading: const Icon(
                                          Icons.location_on_outlined,
                                          size: 16,
                                          color: MoralarColors.brownGrey,
                                        ),
                                        style: textTheme.bodyLarge,
                                      ),
                                      MegaListTile(
                                        title:
                                            "${controller.user.value.first.interestResidencialProperty![index].residencialPropertyFeatures.squareFootage.toString()} m\u00B2",
                                        leading: const Icon(
                                          Icons.edit_outlined,
                                          size: 16,
                                          color: MoralarColors.brownGrey,
                                        ),
                                        style: textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(vertical: 64),
                              child: Text(
                                'Nenhum imóvel encontrado',
                                style: textTheme.headlineLarge,
                              ),
                            ),
                    );
                  }),
                ),
              FamilyInfoCard(
                title: 'Questionários Respondidos',
                cards: Obx(() {
                  return Visibility(
                    visible: controller.isLoading.value,
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
                    replacement: (controller.user.value.isNotEmpty &&
                            controller.user.value.first.detailQuiz!.isNotEmpty)
                        ? Column(
                            children: List.generate(
                                controller.user.value.first.detailQuiz!.length,
                                (index) {
                              return QuizTTSCard(
                                quiz: controller
                                    .user.value.first.detailQuiz![index],
                                function: () {
                                  if (controller.user.value.first
                                          .detailQuiz![index].typeStatus ==
                                      1) {
                                    Get.toNamed(
                                      Routes.ANSWERS,
                                      arguments: [
                                        controller.user.value.first
                                            .detailQuiz![index].id,
                                        controller.familyUser.familyId,
                                      ],
                                    );
                                  } else {
                                    Get.toNamed(
                                      Routes.QUIZ,
                                      arguments: [
                                        controller.user.value.first
                                            .detailQuiz![index].id,
                                        controller.familyUser.familyId,
                                      ],
                                    );
                                  }
                                },
                              );
                            }),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(vertical: 64),
                            child: Text(
                              'Nenhum Questionário encontrado',
                              style: textTheme.headlineLarge,
                            ),
                          ),
                  );
                }),
              ),
              FamilyInfoCard(
                title: 'Enquetes',
                cards: Obx(() {
                  return Visibility(
                    visible: controller.isLoading.value,
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
                    replacement: (controller.user.value.isNotEmpty &&
                            controller
                                .user.value.first.detailEnquete!.isNotEmpty)
                        ? Column(
                            children: List.generate(
                                controller.user.value.first.detailEnquete!
                                    .length, (index) {
                              return QuizTTSCard(
                                quiz: controller
                                    .user.value.first.detailEnquete![index],
                                function: () {
                                  if (controller.user.value.first
                                          .detailEnquete![index].typeStatus ==
                                      1) {
                                    Get.toNamed(
                                      Routes.ANSWERS,
                                      arguments: [
                                        controller.user.value.first
                                            .detailEnquete![index].id,
                                        controller.familyUser.familyId,
                                      ],
                                    );
                                  }
                                },
                              );
                            }),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(vertical: 64),
                            child: Text(
                              'Nenhuma Enquete encontrada',
                              style: textTheme.headlineLarge,
                            ),
                          ),
                  );
                }),
              ),
              FamilyInfoCard(
                title: 'Cursos',
                cards: Obx(() {
                  return Visibility(
                    visible: controller.isLoading.value,
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
                    replacement: (controller.user.value.isNotEmpty &&
                            controller.user.value.first.courses!.isNotEmpty)
                        ? Column(
                            children: List.generate(
                                controller.user.value.first.courses!.length,
                                (index) {
                              return CourseTTSCard(
                                course:
                                    controller.user.value.first.courses![index],
                              );
                            }),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(vertical: 64),
                            child: Text(
                              'Nenhum Curso encontrado',
                              style: textTheme.headlineLarge,
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
