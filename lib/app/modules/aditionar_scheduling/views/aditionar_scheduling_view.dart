import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:validatorless/validatorless.dart';

import '../controllers/aditionar_scheduling_controller.dart';

class AditionarSchedulingView extends GetView<AditionarSchedulingController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Adicionar agendamento',
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
                  height: 570,
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
                  child: Container(
                      width: 120,
                      height: 250,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(24),
                      child: Column(children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Morador',
                            style: textTheme.headlineLarge,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        MoralarTextField(
                            controller: controller.number,
                            waitFinishWrite: (i) {
                              controller.moradorDropdownValue.value = "-1";
                              controller.loadFamiliesData('number', i);
                            },
                            label: 'Número do cadastro',
                            color: MoralarColors.darkBlueGrey,
                            labelStyle: textTheme.bodyLarge?.copyWith(
                                color: MoralarColors.darkBlueGrey,
                                fontSize: 16),
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(top: 15),
                              child:
                                  const Icon(FontAwesomeIcons.search, size: 16),
                            )),
                        const SizedBox(height: 24),
                        MoralarTextField(
                            controller: controller.holderName,
                            waitFinishWrite: (i) {
                              controller.moradorDropdownValue.value = "-1";
                              controller.loadFamiliesData('holderName', i);
                            },
                            label: 'Nome do titular',
                            color: MoralarColors.darkBlueGrey,
                            labelStyle: textTheme.bodyLarge?.copyWith(
                                color: MoralarColors.darkBlueGrey,
                                fontSize: 16),
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(top: 15),
                              child:
                                  const Icon(FontAwesomeIcons.search, size: 16),
                            )),
                        const SizedBox(height: 24),
                        MoralarTextField(
                            controller: controller.holderCpf,
                            waitFinishWrite: (i) {
                              controller.moradorDropdownValue.value = "-1";
                              controller.loadFamiliesData('holderCpf', i);
                            },
                            label: 'CPF do titular',
                            color: MoralarColors.darkBlueGrey,
                            labelStyle: textTheme.bodyLarge?.copyWith(
                                color: MoralarColors.darkBlueGrey,
                                fontSize: 16),
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(top: 15),
                              child:
                                  const Icon(FontAwesomeIcons.search, size: 16),
                            )),
                        const SizedBox(height: 20),
                        Obx(
                          () => Visibility(
                              visible: !controller.isDropdownLoading.value,
                              child: DropdownList(
                                isDynamicData: true,
                                dropdownValue: '-1',
                                title: 'Morador',
                                touched: false.obs,
                                filterHint: '',
                                visible: !controller.isDropdownLoading.value,
                                // ignore: invalid_use_of_protected_member
                                data: controller.familiesDropdownData.value,
                                moralarColor: MoralarColors.darkBlueGrey,
                                onChanged: (i) {
                                  controller.moradorDropdownValue.value =
                                      i.toString();
                                },
                              )),
                        )
                      ])),
                )),
                const SizedBox(height: 48),
                InkWell(
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        height: 770,
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
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    'Agendamento',
                                    style: textTheme.headlineLarge,
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
                                  dropdownValue: '-1',
                                  title: 'Assunto',
                                  filterHint: '',
                                  required: true,
                                  validators: [
                                    // ignore: lines_longer_than_80_chars
                                    Validatorless.required(
                                        'Por favor, informe esse campo.'),
                                  ],
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
                                        dropdownValue: '-1',
                                        title:
                                            // ignore: lines_longer_than_80_chars
                                            'Questionário que será disponibilizado 30 dias após a etapa de mudança.',
                                        touched: false.obs,
                                        required: true,
                                        validators: [
                                          // ignore: lines_longer_than_80_chars
                                          Validatorless.required(
                                              'Por favor, informe esse campo.'),
                                        ],
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
                    disabled: controller.moradorDropdownValue.value == '-1',
                    onPressed: () {
                      DropdownList(dropdownValue: '-1', touched: true.obs);
                      controller.submitAditionar();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('Adicionar', style: textTheme.labelLarge),
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
