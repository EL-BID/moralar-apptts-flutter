import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mega_flutter/mega_flutter.dart';
// ignore: prefer_relative_imports
import 'package:moralar_tts/app/routes/app_pages.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/profile_provider.dart';
import '../../../providers/quiz_provider.dart';
import '../../../providers/scheduling_provider.dart';

// ignore: camel_case_types
class ActiveFilters_AddScheduling {
  String search;
  String number;
  String holderName;
  String holderCpf;

  ActiveFilters_AddScheduling(
      {required this.search,
      required this.number,
      required this.holderName,
      required this.holderCpf});
}

class AditionarSchedulingController extends GetxController {
  final _schedulingProvider = Get.find<SchedulingProvider>();
  final _profileProvider = Get.find<ProfileProvider>();
  final _quizProvider = Get.find<QuizProvider>();
  final isLoading = true.obs;
  final isDropdownLoading = true.obs;
  final isQuizDropdownLoading = true.obs;

  final formKey = GlobalKey<FormState>();

  TextEditingController number = TextEditingController();

  RxString assunto = '-1'.obs;
  TextEditingController local = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController holderName = TextEditingController();
  TextEditingController holderCpf = TextEditingController();

  Rx<DateTime> dateOfAgendamento = DateTime.now()
      .toUtc()
      .subtract(Duration(hours: MoralarWidgets.instance.regionUtcSubstract))
      .obs;

  final familiesDropdownData = <Map<String, String>>[].obs;
  final quizesDropdownData = <Map<String, String>>[].obs;
  List<QuizLoadData> quizesData = [];

  RxString moradorDropdownValue = '-1'.obs;
  RxString quizDropdownValue = '-1'.obs;

  //Classes
  final scheduling = ScheduleDetails(
    familyId: '',
    id: '',
    typeScheduleStatus: 4,
  ).obs;

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

  final ActiveFilters_AddScheduling activeFilters = ActiveFilters_AddScheduling(
      search: "", number: "", holderName: "", holderCpf: "");

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadFamiliesData('search', '');
    isLoading.value = false;
  }

  void toggleQuizDropdown(String assuntoId) {
    if (assuntoId == '7') {
      loadQuizLoadData('');
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

  Future<void> loadFamiliesData(String type, String value) async {
    isLoading.value = true;

    _setFilter(type, value);

    try {
      final body = {
        'columns[0][data]': 'number',
        'columns[0][name]': 'Number',
        'columns[0][searchable]': 'true',
        'columns[1][data]': 'holderName',
        'columns[1][name]': 'HolderName',
        'columns[1][searchable]': 'true',
        'columns[2][data]': 'holderCpf',
        'columns[2][name]': 'SchedulesComponentCpf',
        'columns[2][searchable]': 'true',
        'start': '0',
        'length': '10',
        'order[0][column]': '0',
        'order[0][dir]': 'asc',
        'search[value]': activeFilters.search,
        'number': activeFilters.number,
        'holderName': activeFilters.holderName,
        'holderCpf': activeFilters.holderCpf,
        'status': ''
      };
      familiesDropdownData.value =
          await _profileProvider.getFamiliesLoadDataByDropdown(body);
      isDropdownLoading.value = false;
      isLoading.value = false;
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void _setFilter(String type, String value) {
    switch (type) {
      case "search":
        activeFilters.search = value;
        break;
      case "number":
        activeFilters.number = value;
        break;
      case "holderName":
        activeFilters.holderName = value;
        break;
      case "holderCpf":
        activeFilters.holderCpf = value;
        break;
    }
  }

  Future<void> submitAditionar() async {
    isLoading.value = true;
    if (formKey.currentState!.validate() && !_invalidData()) {
      final RegisterSchedule data = _getValuesToInsert();
      formKey.currentState!.save();
      final ValidationMessage response =
          await _schedulingProvider.registerSchedule(data);

      Get.snackbar(
        response.message,
        '',
        colorText: MoralarColors.veryLightPink,
        backgroundColor: (response.success)
            ? MoralarColors.kellyGreen
            : MoralarColors.strawberry,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;

      if (response.success) {
        Timer(const Duration(seconds: 4), () {
          Get.offNamedUntil(Routes.SCHEDULINGS, (route) => false);
        });
      }
    } else {
      isLoading.value = false;
    }
  }

  bool _invalidData() {
    bool invalid = false;

    if (assunto.value == '-1') {
      invalid = true;
    }

    if (moradorDropdownValue.value == '-1') {
      invalid = true;
    }

    return invalid;
  }

  RegisterSchedule _getValuesToInsert() {
    return RegisterSchedule(
      date: dateOfAgendamento.value.millisecondsSinceEpoch ~/ 1000,
      description: description.text,
      familyId: moradorDropdownValue.value,
      place: local.text,
      time: MoralarDate.formatTime(dateOfAgendamento.value),
      typeSubject: int.parse(assunto.value),
      quiz: _getQuizLoadDataFromDropdown(),
    );
  }

  QuizLoadData? _getQuizLoadDataFromDropdown() {
    if ((!isQuizDropdownLoading.value) &&
        quizesData.isNotEmpty &&
        assunto.value == '7') {
      return quizesData.where((i) => i.id == quizDropdownValue.value).first;
    } else {
      return null;
    }
  }

  @override
  void onClose() {}
}
