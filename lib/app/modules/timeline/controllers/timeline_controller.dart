import 'package:get/get.dart';

class TimelineController extends GetxController {
  //TODO: Implement TimelineController

  final count = 0.obs;
  final hintStatus = 'Selecionar'.obs;
  final filterStatus = [
    'Reunião PGM',
    'Escolha do imóvel',
    'Mudança',
    'Acompanhamento pós-mudança',
  ];
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}
  void increment() => count.value++;
}
