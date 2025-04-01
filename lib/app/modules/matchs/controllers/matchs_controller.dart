import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/matchs_provider.dart';

class MatchsController extends GetxController {
  final _matchsProvider = Get.find<MatchsProvider>();
  final isLoading = false.obs;

  final TextEditingController search = TextEditingController();

  //Classes
  final matchs = <Match>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadMatchs("");
  }

  Future<bool> extractReport(String searchText) async {
    isLoading.value = true;
    try {
      await _matchsProvider.extractReport(
        searchText,
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
    return true;
  }

  Future<void> loadMatchs(String? search) async {
    isLoading.value = true;
    try {
      final body = {
        "columns[0][data]": "holderNumber",
        "columns[0][name]": "HolderNumber",
        "columns[0][searchable]": "true",
        "columns[1][data]": "holderName",
        "columns[1][name]": "HolderName",
        "columns[1][searchable]": "true",
        "columns[2][data]": "holderCpf",
        "columns[2][name]": "HolderCpf",
        "columns[2][searchable]": "true",
        "columns[3][data]": "residencialCode",
        "columns[3][name]": "ResidencialCode",
        "columns[3][searchable]": "true",
        "start": "0",
        "length": "50",
        "order[0][column]": "1",
        "order[0][dir]": "asc",
        "search[value]": search.toString(),
        "holderNumber": "",
        "holderName": "",
        "holderCpf": "",
        "residencialCode": ""
      };
      matchs.value = await _matchsProvider.getMatchs(body);
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
