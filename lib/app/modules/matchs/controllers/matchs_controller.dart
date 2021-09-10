import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/matchs_provider.dart';

class MatchsController extends GetxController {
  final _matchsProvider = Get.find<MatchsProvider>();
  final isLoading = false.obs;

  final TextEditingController familySearch = TextEditingController();
  final TextEditingController propertySearch = TextEditingController();

  //Classes
  final matchs = <Match>[].obs;

  Future<void> searchMatchs() async {
    if (familySearch.text.isEmpty && propertySearch.text.isEmpty) {
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
        matchs.value = await _matchsProvider.searchTimeline(
          familySearch.text,
          propertySearch.text,
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
}
