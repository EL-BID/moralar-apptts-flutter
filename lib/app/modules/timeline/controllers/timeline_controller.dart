import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_tts/app/providers/hive_provider.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/profile_provider.dart';

class TimelineController extends GetxController {
  final _profileProvider = Get.find<ProfileProvider>();
  final _hiveProvider = Get.find<HiveProvider>();
  final isLoading = false.obs;
  final isLoadingReport = false.obs;

  //classes
  final user = TTS(jobPost: '', name: '', cpf: '', email: '', id: '').obs;
  final familys = <FamilyTTS>[].obs;

  final TextEditingController familySearch = TextEditingController();
  final hintStatus = 'Selecionar'.obs;
  final filterStatus = [
    "Visita do TTS",
    "Reunião com TTS",
    'Reunião PGM',
    "Visita ao imóvel",
    'Escolha do imóvel',
    "Demolição",
    "Outros",
    'Mudança',
    'Acompanhamento pós-mudança',
  ];

  Future<void> searchTimeline(bool initial) async {
    String typeSubject = '';

    if (hintStatus.value != 'Selecionar') {
      typeSubject = hintStatus.value;
    }

    if (!initial && familySearch.text.isEmpty && typeSubject.isEmpty) {
      Get.snackbar(
        'Algo deu errado!',
        'Preencha pelo menos um campo.',
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      isLoading.value = true;
      if (await hasNetwork()) {
        try {
          familys.value = await _profileProvider.searchTimeline(
            familySearch.text,
            typeSubject,
          );
          _hiveProvider.saveTimeline(familys.value);
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
      } else {
        familys.value = await _hiveProvider.getTimeline();
        isLoading.value = false;
      }
    }
  }

  Future<void> getInfo() async {
    isLoading.value = true;
    try {
      user.value = await _profileProvider.getInfo();
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

  Future<bool> extractReport() async {
    String typeSubject = '';

    if (hintStatus.value != 'Selecionar') {
      typeSubject = hintStatus.value;
    }

    isLoadingReport.value = true;
    try {
      await _profileProvider.extractReport(
        familySearch.text,
        getEnum(typeSubject),
      );
      isLoadingReport.value = false;
    } on MegaResponseException catch (e) {
      isLoadingReport.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
    return true;
  }

  int getEnum(String value) {
    switch (value) {
      case "Visita do TTS":
        return 0;
      case "Reunião com TTS":
        return 1;
      case "Reunião PGM":
        return 2;
      case "Visita ao imóvel":
        return 3;
      case "Escolha do imóvel":
        return 4;
      case "Demolição":
        return 5;
      case "Outros":
        return 6;
      case "Mudança":
        return 7;
      case "Acompanhamento pós-mudança":
        return 8;
    }
    return 0;
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> loadDataFamilies(String? search) async {
    isLoading.value = true;
    try {
      final body = {
        "columns[0][data]": "created",
        "columns[0][name]": "Created",
        "columns[0][searchable]": "false",
        "columns[1][data]": "number",
        "columns[1][name]": "Number",
        "columns[1][searchable]": "true",
        "columns[2][data]": "name",
        "columns[2][name]": "Name",
        "columns[2][searchable]": "true",
        "columns[3][data]": "cpf",
        "columns[3][name]": "Cpf",
        "columns[3][searchable]": "true",
        "start": "0",
        "length": "10",
        "order[0][column]": "0",
        "order[0][dir]": "desc",
        "search[value]": search.toString(),
        "typeSubject": "",
      };
      familys.value = await _profileProvider.getFamiliesTimelineLoadData(body);
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

  @override
  Future<void> onInit() async {
    getInfo();
    super.onInit();
    await searchTimeline(true);
  }
}
