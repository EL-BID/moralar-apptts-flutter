import 'package:get/get.dart';

class TimelineDetailsController extends GetxController {
  //TODO: Implement TimelineDetailsController

  final count = 0.obs;

  final int status = Get.arguments;
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
