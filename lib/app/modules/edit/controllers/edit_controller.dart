import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/profile_provider.dart';
import '../../timeline/controllers/timeline_controller.dart';

class EditController extends GetxController {
  final _profileProvider = Get.find<ProfileProvider>();
  final _timelineController = Get.find<TimelineController>();
  final isLoading = false.obs;
  final buttonLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  //Classes
  final user = TTS(jobPost: '', name: '', cpf: '', email: '', id: '').obs;

  //TextEditingController
  final name = TextEditingController();
  final job = TextEditingController();
  final cpf = TextEditingController();
  final email = TextEditingController();
  final tel = TextEditingController();

  Future<void> getInfo() async {
    isLoading.value = true;
    try {
      user.value = await _profileProvider.getInfo();
      name.text = user.value.name;
      job.text = user.value.jobPost;
      cpf.text = UtilBrasilFields.obterCpf(user.value.cpf);
      email.text = user.value.email;
      if (user.value.phone != null && user.value.phone != "") {
        if(user.value.phone!.length > 11){
          tel.text = UtilBrasilFields.obterTelefone(user.value.phone!.substring(2, 13));
        }else if(user.value.phone!.length >= 10){
          tel.text = UtilBrasilFields.obterTelefone(user.value.phone!);
        }else{
          tel.text = user.value.phone ?? "";
        }
      }
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
      user.value.jobPost = job.text;
      user.value.name = name.text;
      user.value.phone = Formats.unmaskTel(tel.text);
      user.value.email = email.text;
      buttonLoading.value = true;
      debugPrint('${user.value.toJson()}');
      try {
        final response = await _profileProvider.editProfile(user.value);

        if (response) {
          await _timelineController.getInfo();
          buttonLoading.value = false;
          Get.back();
          Get.back();
          Get.snackbar(
            'Perfil atualizado.',
            'Seus dados foram atualizados com sucesso',
            colorText: MoralarColors.veryLightPink,
            backgroundColor: MoralarColors.kellyGreen,
            snackPosition: SnackPosition.TOP,
          );
        }
      } on MegaResponseException catch (e) {
        buttonLoading.value = false;
        Get.snackbar(
          'Algo deu errado!',
          e.message!,
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.strawberry,
          snackPosition: SnackPosition.TOP,
        );
      }
      buttonLoading.value = false;
    }
  }

  @override
  void onInit() {
    getInfo();
    super.onInit();
  }
}
