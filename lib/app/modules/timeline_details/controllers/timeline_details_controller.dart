import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class TimelineDetailsController extends GetxController {
  final count = 0.obs;

  final FamilyTTS user = Get.arguments;
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
