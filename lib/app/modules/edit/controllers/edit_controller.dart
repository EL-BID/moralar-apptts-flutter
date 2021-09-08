import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/timeline_provider.dart';
import '../../timeline/controllers/timeline_controller.dart';

class EditController extends GetxController {
  final _timelineProvider = Get.find<TimelineProvider>();
  final _timelineController = Get.find<TimelineController>();
  final isLoading = false.obs;
  final buttonLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  //Classes
  final user = TTS(jobPost: '', name: '', cpf: '', email: '').obs;

  //TextEditingController
  final name = TextEditingController();
  final job = TextEditingController();
  final cpf = TextEditingController();
  final email = TextEditingController();
  final tel = TextEditingController();

  Future<void> getInfo() async {
    isLoading.value = true;
    try {
      user.value = await _timelineProvider.getInfo();
      name.text = user.value.name;
      job.text = user.value.jobPost;
      cpf.text = UtilBrasilFields.obterCpf(user.value.cpf);
      email.text = user.value.email;
      tel.text = user.value.phone ?? '';
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

  Future<void> editProfile() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      buttonLoading.value = true;
      await _timelineController.getInfo();
      buttonLoading.value = false;
    }
  }

  @override
  void onInit() {
    getInfo();
    super.onInit();
  }
}
