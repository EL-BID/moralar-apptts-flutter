import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/profile_provider.dart';
import '../../timeline/controllers/timeline_controller.dart';

class TimelineDetailsController extends GetxController {
  final _profileProvider = Get.find<ProfileProvider>();
  final _timelineController = Get.find<TimelineController>();
  final isScheduleLoading = false.obs;
  final isQuestLoading = false.obs;
  final isEnqLoading = false.obs;
  final isCourseLoading = false.obs;
  final isButtonLoading = false.obs;

  //Classes
  final FamilyTTS user = Get.arguments;
  final quest = <Quiz>[].obs;
  final enq = <Quiz>[].obs;
  final courses = <CourseTTS>[].obs;
  final scheduleDetails = ScheduleDetails(familyId: '', id: '').obs;

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

  Future<void> getScheduleDetails() async {
    isScheduleLoading.value = true;
    try {
      if (user.typeSubject != 4) {
        await getReunionPGM();
      }
      isScheduleLoading.value = false;
    } on MegaResponseException catch (e) {
      isScheduleLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> getReunionPGM() async {
    scheduleDetails.value =
        await _profileProvider.detailsReunionPGM(user.familyId);
  }

  Future<void> changeTypeSubject(int typeSubject) async {
    isButtonLoading.value = false;
    try {
      final response =
          await _profileProvider.changeTypeSubject(user, typeSubject);
      if (response) {
        isButtonLoading.value = false;
        _timelineController.familys.value = [];
        Get.back();
        Get.snackbar(
          'Nova fase do agendamento.',
          'Verifique novamente!',
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.strawberry,
          snackPosition: SnackPosition.TOP,
        );
      }
      isButtonLoading.value = false;
    } on MegaResponseException catch (e) {
      isButtonLoading.value = false;
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
    getScheduleDetails();
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
