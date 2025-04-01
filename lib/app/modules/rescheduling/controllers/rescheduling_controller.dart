import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/quiz_provider.dart';
import '../../../providers/scheduling_provider.dart';
import '../../../routes/app_pages.dart';

class ReSchedulingController extends GetxController {
  final _schedulingProvider = Get.find<SchedulingProvider>();
  final _quizProvider = Get.find<QuizProvider>();
  final isLoading = true.obs;
  final isDropdownLoading = true.obs;
  final isQuizDropdownLoading = true.obs;

  final formKey = GlobalKey<FormState>();

  TextEditingController number = TextEditingController();

  RxString assunto = '-1'.obs;
  TextEditingController local = TextEditingController();
  TextEditingController description = TextEditingController();

  Rx<DateTime> dateOfAgendamento = DateTime.now()
      .toUtc()
      .subtract(Duration(hours: MoralarWidgets.instance.regionUtcSubstract))
      .obs;

  final familiesDropdownData = <Map<String, String>>[].obs;
  final quizesDropdownData = <Map<String, String>>[].obs;
  List<QuizLoadData> quizesData = [];

  RxString quizDropdownValue = '-1'.obs;

  //Classes
  final scheduling = ScheduleDetails(
    familyId: '',
    id: '',
    typeScheduleStatus: 4,
  ).obs;

  final Rx<ScheduleDetails> schedule =
      ScheduleDetails(familyId: null, id: "").obs;

  final List<Map<String, String>> assuntoDataDropdown = [
    {"id": "-1", 'name': "Selecione"},
    {"id": "0", 'name': "Visita do TTS"},
    {"id": "1", 'name': "Reunião com TTS"},
    {"id": "2", 'name': 'Reunião PGM'},
    {"id": "3", 'name': "Visita ao imóvel"},
    {"id": "4", 'name': 'Escolha do imóvel'},
    {"id": "5", 'name': "Demolição"},
    {"id": "6", 'name': "Outros"},
    {"id": "7", 'name': 'Mudança'},
    {"id": "8", 'name': 'Acompanhamento pós-mudança'},
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = false;
  }

  Future<void> receiveData(ScheduleDetails data) async {
    schedule.value = data;
  }

  Future<void> toggleQuizDropdown(String assuntoId) async {
    if (assuntoId == '7') {
      await loadQuizLoadData('');
    } else {
      isQuizDropdownLoading.value = true;
    }
  }

  Future<void> loadQuizLoadData(String search) async {
    isLoading.value = true;

    try {
      final StreamedResponse sResponse =
          await _quizProvider.getResponseQuizedLoadDataByDropdown(search);

      final streamString = sResponse.stream.bytesToString();
      quizesDropdownData.value =
          await QuizProvider.getDropdownDataBySResponse(await streamString);

      quizesData =
          await QuizProvider.bytesToListQuizLoadData(await streamString);

      isQuizDropdownLoading.value = false;
      isLoading.value = false;
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      isQuizDropdownLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> submitReagendar() async {
    isLoading.value = true;
    if (formKey.currentState!.validate() && !_invalidData()) {
      formKey.currentState!.save();

      final ScheduleDetails schedule = _setDataToReAgendar();

      final success = await handleChangeStatusSchedule(schedule, 2);
      isLoading.value = false;
      if (success) {
        Timer(const Duration(seconds: 4), () {
          Get.offNamedUntil(Routes.SCHEDULINGS, (route) => false);
        });
      }
    } else {
      isLoading.value = false;
    }
  }

  ScheduleDetails _setDataToReAgendar() {
    final ScheduleDetails scheduleRe = schedule.value;
    scheduleRe.date =
        MoralarDate.simpleFormatDateToNumber(dateOfAgendamento.value);
    scheduleRe.place = local.text;
    scheduleRe.description = description.text;
    return scheduleRe;
  }

  Future<bool> handleChangeStatusSchedule(
      ScheduleDetails schedule, int typeScheduleStatus) async {
    schedule.typeScheduleStatus = typeScheduleStatus;
    return await updateSchedule(schedule);
  }

  Future<bool> updateSchedule(ScheduleDetails schedule) async {
    isLoading.value = true;
    try {
      final response = await _schedulingProvider.editStatus(schedule);
      if (response) {
        Get.snackbar(
          'Sucesso',
          '',
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.kellyGreen,
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoading.value = false;
        return true;
      } else {
        return false;
      }
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  bool _invalidData() {
    bool invalid = false;

    if (assunto.value == '-1') {
      invalid = true;
    }

    return invalid;
  }

  @override
  void onClose() {}
}
