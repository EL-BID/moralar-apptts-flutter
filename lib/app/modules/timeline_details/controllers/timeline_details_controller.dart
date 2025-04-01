import 'dart:io';

import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_tts/app/providers/hive_provider.dart';
import 'package:moralar_tts/app/providers/matchs_provider.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/profile_provider.dart';
import '../../timeline/controllers/timeline_controller.dart';

class TimelineDetailsController extends GetxController {
  final _profileProvider = Get.find<ProfileProvider>();
  final _timelineController = Get.find<TimelineController>();
  final _matchsProvider = Get.find<MatchsProvider>();
  final _hiveProvider = Get.find<HiveProvider>();
  final isLoading = false.obs;
  final isLoadingNextStage = false.obs;
  // final isScheduleLoading = false.obs;
  // final isMatchsLoading = false.obs;
  // final isQuestLoading = false.obs;
  // final isEnqLoading = false.obs;
  // final isCourseLoading = false.obs;
  final isButtonLoading = false.obs;

  //Classes
  final FamilyTTS familyUser = Get.arguments;
  final user = <FamilyTTS>[].obs;
  // final properties = <Property>[].obs;
  // final quest = <Quiz>[].obs;
  // final enq = <Quiz>[].obs;
  // final courses = <CourseTTS>[].obs;
  // final scheduleDetails = ScheduleDetails(familyId: '', id: '').obs;

  Future<void> getDetailTimeLine() async {
    isLoading.value = true;
    if (await hasNetwork()) {
      try {
        final result = await _profileProvider.getDetailTimeline(
            familyUser.familyId, familyUser.typeSubject);
        user.add(result);
        _hiveProvider.saveFamily(result);
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
      final result = await _hiveProvider.getFamily(familyUser.familyId);
      if (result != null) {
        user.add(result);
      }
      isLoading.value = false;
    }
  }

  Future<void> nextStage() async {
    isLoadingNextStage.value = true;
    try {
      final result = await _profileProvider.nextStage(familyUser.familyId);
      Get.snackbar(
        'Sucesso!',
        result,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.kellyGreen,
        snackPosition: SnackPosition.TOP,
      );
      isLoadingNextStage.value = false;
      getDetailTimeLine();
    } on MegaResponseException catch (e) {
      isLoadingNextStage.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Future<void> getProperties() async {
  //   isMatchsLoading.value = true;
  //   try {
  //     properties.value = await _matchsProvider.getMatchs(user.familyId);
  //     isMatchsLoading.value = false;
  //   } on MegaResponseException catch (e) {
  //     isMatchsLoading.value = false;
  //     Get.snackbar(
  //       'Algo deu errado!',
  //       e.message!,
  //       colorText: MoralarColors.veryLightPink,
  //       backgroundColor: MoralarColors.strawberry,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //   }
  // }
  //
  // Future<void> getQuests() async {
  //   isQuestLoading.value = true;
  //   try {
  //     quest.value = await _profileProvider.quizByFamily(user.familyId, 'Quiz');
  //     isQuestLoading.value = false;
  //   } on MegaResponseException catch (e) {
  //     isQuestLoading.value = false;
  //     Get.snackbar(
  //       'Algo deu errado!',
  //       e.message!,
  //       colorText: MoralarColors.veryLightPink,
  //       backgroundColor: MoralarColors.strawberry,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //   }
  // }
  //
  // Future<void> getEnqs() async {
  //   isEnqLoading.value = true;
  //   try {
  //     enq.value = await _profileProvider.quizByFamily(user.familyId, 'Enquete');
  //     isEnqLoading.value = false;
  //   } on MegaResponseException catch (e) {
  //     isEnqLoading.value = false;
  //     Get.snackbar(
  //       'Algo deu errado!',
  //       e.message!,
  //       colorText: MoralarColors.veryLightPink,
  //       backgroundColor: MoralarColors.strawberry,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //   }
  // }
  //
  // Future<void> getCourse() async {
  //   isCourseLoading.value = true;
  //   try {
  //     courses.value = await _profileProvider.courseByFamily(user.familyId);
  //     isCourseLoading.value = false;
  //   } on MegaResponseException catch (e) {
  //     isCourseLoading.value = false;
  //     Get.snackbar(
  //       'Algo deu errado!',
  //       e.message!,
  //       colorText: MoralarColors.veryLightPink,
  //       backgroundColor: MoralarColors.strawberry,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //   }
  // }
  //
  // Future<void> getScheduleDetails() async {
  //   isScheduleLoading.value = true;
  //   try {
  //     await getReunionPGM();
  //     isScheduleLoading.value = false;
  //   } on MegaResponseException catch (e) {
  //     isScheduleLoading.value = false;
  //     Get.snackbar(
  //       'Algo deu errado!',
  //       e.message!,
  //       colorText: MoralarColors.veryLightPink,
  //       backgroundColor: MoralarColors.strawberry,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //   }
  // }
  //
  // Future<void> getReunionPGM() async {
  //   scheduleDetails.value =
  //       await _profileProvider.detailsReunionPGM(user.familyId);
  // }

  Future<void> changeTypeSubject(int typeSubject) async {
    isButtonLoading.value = false;
    try {
      final response =
          await _profileProvider.changeTypeSubject(familyUser, typeSubject);
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

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void onInit() {
    // getProperties();
    // getScheduleDetails();
    // getCourse();
    // getEnqs();
    // getQuests();
    getDetailTimeLine();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }
}
