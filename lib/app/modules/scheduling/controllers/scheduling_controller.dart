import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/scheduling_provider.dart';
import '../../../routes/app_pages.dart';
import '../../schedulings/controllers/schedulings_controller.dart';

class SchedulingController extends GetxController {
  final String id = Get.arguments;
  final _schedulingProvider = Get.find<SchedulingProvider>();
  final _schedulingsController = Get.find<SchedulingsController>();
  final isLoading = true.obs;

  //Classes
  final Rx<ScheduleDetails> scheduling = ScheduleDetails(
    familyId: '',
    id: '',
    typeScheduleStatus: 4,
  ).obs;

  Future<void> getSchedulings() async {
    scheduling.value = await _schedulingProvider.getSchedulingDetails(id);
    isLoading.value = false;
  }

  Future<void> changeStatus({int status = 2}) async {
    isLoading.value = true;
    try {
      scheduling.value.typeScheduleStatus = status;
      final response = await _schedulingProvider.editStatus(scheduling.value);
      if (response) {
        await _schedulingsController.getSchedulings(false, "", {}, null);
        Get.back();
        isLoading.value = false;
      }
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
      );
      rethrow;
    }
  }

  Future<void> updateSchedule(ScheduleDetails schedule) async {
    isLoading.value = true;
    try {
      final response = await _schedulingProvider.editStatus(schedule);
      if (response) {
        Get.snackbar(
          'Sucesso',
          '',
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.kellyGreen,
          snackPosition: SnackPosition.BOTTOM,
        );
        Timer(const Duration(seconds: 4), () {
          Get.offNamedUntil(Routes.SCHEDULINGS, (route) => false);
        });
        isLoading.value = false;
      }
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
      );
      rethrow;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getSchedulings();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}

  void handleRescheduleFormSubmit(ScheduleDetails schedule) {
    // schedule.date = dateToString(schedule.date) + ' ' + schedule.time;
    //   schedule.date = dateAndTimeToSeconds(value.date);
    //   schedule.typeScheduleStatus = 2;
  }

  void handleChangeStatusSchedule(
      ScheduleDetails schedule, int typeScheduleStatus) {
    schedule.typeScheduleStatus = typeScheduleStatus;
    updateSchedule(schedule);
  }
}
