import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/profile_provider.dart';

class TimelineDetailsController extends GetxController {
  final _profileProvider = Get.find<ProfileProvider>();
  final isQuestLoading = false.obs;
  final isEnqLoading = false.obs;
  final isCourseLoading = false.obs;

  //Classes
  final FamilyTTS user = Get.arguments;
  final quest = <Quiz>[].obs;
  final enq = <Quiz>[].obs;
  final courses = <CourseTTS>[].obs;

  Future<void> getQuests() async {
    isQuestLoading.value = true;
    try {
      quest.value = await _profileProvider.quizByFamily(user.familyId, 'Quiz');
      isQuestLoading.value = false;
    } on MegaResponseException catch (e) {
      isQuestLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> getEnqs() async {
    isEnqLoading.value = true;
    try {
      enq.value = await _profileProvider.quizByFamily(user.familyId, 'Enquete');
      isEnqLoading.value = false;
    } on MegaResponseException catch (e) {
      isEnqLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> getCourse() async {
    isCourseLoading.value = true;
    try {
      courses.value = await _profileProvider.courseByFamily(user.familyId);
      isCourseLoading.value = false;
    } on MegaResponseException catch (e) {
      isCourseLoading.value = false;
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
    getCourse();
    getEnqs();
    getQuests();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }
}
