import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:validatorless/validatorless.dart';

import '../controllers/rescheduling_controller.dart';

class ReSchedulingView extends GetView<ReSchedulingController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReSchedulingController>();
    final textTheme = Theme.of(context).textTheme;

    final String olDate =
        MoralarDate.secondsForDate(controller.schedule.value.date!);

    final hour =
        MoralarDate.secondsForDateHours(controller.schedule.value.date!)
            .substring(11, 16);

    controller.assunto.value = (controller.schedule.value.typeSubject != null)
        ? controller.schedule.value.typeSubject.toString()
        : "-1";

    controller.local.text = controller.schedule.value.place.toString();
    controller.description.text =
        controller.schedule.value.description.toString();

    controller
        .toggleQuizDropdown(controller.schedule.value.typeSubject.toString());

    controller.quizDropdownValue.value =
        controller.schedule.value.quiz?.id ?? '-1';

    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Reagendar',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                InkWell(
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        height: 780,
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
                        child: IntrinsicHeight(
                          child: Container(
                              width: 120,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(24),
                              child: Column(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    'Data anterior',
                                    style: textTheme.titleSmall,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                MegaListTile(
                                  title: olDate,
                                  leading: const Icon(
                                    FontAwesomeIcons.calendar,
                                    size: 16,
                                    color: MoralarColors.darkBlueGrey,
                                  ),
                                  style: textTheme.bodyMedium,
                                ),
                                MegaListTile(
                                  title: '${hour}hrs',
                                  leading: const Icon(FontAwesomeIcons.clock,
                                      size: 16,
                                      color: MoralarColors.darkBlueGrey),
                                  style: textTheme.bodyMedium,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    'nova data de agendamento',
                                    style: textTheme.titleSmall,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Obx(() {
                                  return OmniDatePicker(
                                    onSelectDate: (date) {
                                      controller.dateOfAgendamento.value = date;
                                    },
                                    selectedDate:
                                        controller.dateOfAgendamento.value,
                                  );
                                }),
                                const SizedBox(height: 10),
                                DropdownList(
                                  dropdownValue: controller.assunto.value,
                                  title: 'Assunto',
                                  filterHint: '',
                                  disabled: true,
                                  validatorComplements:
                                      InputDecorationComplements(),
                                  visible: true,
                                  data: controller.assuntoDataDropdown,
                                  moralarColor: MoralarColors.darkBlueGrey,
                                  onChanged: (i) {
                                    controller.assunto.value = i.toString();

                                    controller.toggleQuizDropdown(i.toString());
                                  },
                                  touched: false.obs,
                                ),
                                const SizedBox(height: 10),
                                Obx(() => Visibility(
                                      visible: !controller
                                          .isQuizDropdownLoading.value,
                                      child: DropdownList(
                                        isDynamicData: true,
                                        dropdownValue:
                                            controller.quizDropdownValue.value,
                                        disabled: true,
                                        title:
                                            // ignore: lines_longer_than_80_chars
                                            'Questionário que será disponibilizado 30 dias após a etapa de mudança.',
                                        touched: false.obs,
                                        validatorComplements:
                                            InputDecorationComplements(),
                                        filterHint: '',
                                        visible: !controller
                                            .isQuizDropdownLoading.value,
                                        // ignore: invalid_use_of_protected_member
                                        data:
                                            controller.quizesDropdownData.value,
                                        moralarColor:
                                            MoralarColors.darkBlueGrey,
                                        onChanged: (i) {
                                          controller.quizDropdownValue.value =
                                              i.toString();
                                        },
                                      ),
                                    )),
                                const SizedBox(height: 24),
                                MoralarTextField(
                                  controller: controller.local,
                                  label: 'Local',
                                  validators: [
                                    // ignore: lines_longer_than_80_chars
                                    Validatorless.required(
                                        'Por favor, informe esse campo.'),
                                  ],
                                  color: MoralarColors.darkBlueGrey,
                                  labelStyle: textTheme.bodyLarge?.copyWith(
                                      color: MoralarColors.darkBlueGrey,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 24),
                                Container(
                                  height: 100, // Set the desired height
                                  child: MoralarTextField(
                                    controller: controller.description,
                                    label: 'Description',
                                    expands: true,
                                    validators: [
                                      Validatorless.required(
                                          // ignore: lines_longer_than_80_chars
                                          'Por favor, informe esse campo.'),
                                    ],
                                    color: MoralarColors.darkBlueGrey,
                                    labelStyle: textTheme.bodyLarge?.copyWith(
                                        color: MoralarColors.darkBlueGrey,
                                        fontSize: 16),
                                  ),
                                ),
                              ])),
                        ))),
                const SizedBox(height: 48),
                Obx(() {
                  return MoralarButton(
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      DropdownList(dropdownValue: '-1', touched: true.obs);
                      controller.submitReagendar();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('Reagendamento', style: textTheme.labelLarge),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
