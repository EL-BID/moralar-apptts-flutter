import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/profile_provider.dart';

class TimelineController extends GetxController {
  final _profileProvider = Get.find<ProfileProvider>();
  final isLoading = false.obs;

  //classes
  final user = TTS(jobPost: '', name: '', cpf: '', email: '', id: '').obs;

  final hintStatus = 'Selecionar'.obs;
  final filterStatus = [
    'Reunião PGM',
    'Escolha do imóvel',
    'Mudança',
    'Acompanhamento pós-mudança',
  ];

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

  @override
  void onInit() {
    getInfo();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }
}
