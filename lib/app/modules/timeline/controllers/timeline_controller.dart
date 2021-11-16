import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/profile_provider.dart';

class TimelineController extends GetxController {
  final _profileProvider = Get.find<ProfileProvider>();
  final isLoading = false.obs;
  final isLoadingReport = false.obs;

  //classes
  final user = TTS(jobPost: '', name: '', cpf: '', email: '', id: '').obs;
  final familys = <FamilyTTS>[].obs;

  final TextEditingController familySearch = TextEditingController();
  final hintStatus = 'Selecionar'.obs;
  final filterStatus = [
    'Reunião PGM',
    'Escolha do imóvel',
    'Mudança',
    'Acompanhamento pós-mudança',
  ];

  Future<void> searchTimeline() async {
    String typeSubject = '';

    if (hintStatus.value != 'Selecionar') {
      typeSubject = hintStatus.value;
    }

    if (familySearch.text.isEmpty && typeSubject.isEmpty) {
      Get.snackbar(
        'Algo deu errado!',
        'Preencha pelo menos um campo.',
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      isLoading.value = true;
      try {
        familys.value = await _profileProvider.searchTimeline(
          familySearch.text,
          typeSubject,
        );
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

  Future<bool> extractReport() async{


    String typeSubject = '';

    if (hintStatus.value != 'Selecionar') {
      typeSubject = hintStatus.value;
    }

    if (familySearch.text.isEmpty && typeSubject.isEmpty) {
      Get.snackbar(
        'Algo deu errado!',
        'Preencha pelo menos um campo.',
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      isLoadingReport.value = true;
      try {
        bool value = await _profileProvider.extractReport(
          familySearch.text,
          typeSubject,
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
    }
    return true;
  }

  @override
  void onInit() {
    getInfo();
    super.onInit();
  }
}
