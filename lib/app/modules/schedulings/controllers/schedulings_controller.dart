import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/profile_provider.dart';
import '../../../providers/registration_data_provider.dart';
import '../../../providers/scheduling_provider.dart';

class SchedulingsController extends GetxController {
  final _profileProvider = Get.find<ProfileProvider>();
  final _registrationDataProvider = Get.find<RegistrationDataProvider>();
  final _schedulingProvider = Get.find<SchedulingProvider>();
  final PageController pageController = PageController();
  final isLoading = false.obs;

  final TextEditingController search = TextEditingController();
  String searchStatus = "-1";
  String searchType = "-1";
  DateRangeModel searchDate = DateRangeModel(startDate: 0, endDate: 0);
  DateTimeRange? searchRangeDates;
  RxBool? cleanFilterOpen = false.obs;

  //Classes
  final user = TTS(jobPost: '', name: '', cpf: '', email: '', id: '').obs;
  FamilyUser familyUser = FamilyUser(
    holder:
        FamilyHolder.fromJson(MegaFlutter.instance.auth.currentUser!.toJson()),
    spouse: Spouse(name: '', birthday: 0),
    members: [FamilyMember(name: '', birthday: 0, kinShip: 0)],
    id: '',
  );
  final nextSchedulings = <ScheduleDetails>[].obs;
  final historicSchedulings = <ScheduleDetails>[].obs;

  List<Map<String, String>> multipleSearch = [
    {'name': 'N° de cadastro', 'value': 'holderNumber'},
    {'name': 'Nome do morador titular', 'value': 'holderName'},
    {'name': 'CPF do morador titular', 'value': 'holderCpf'},
  ];

  final Map<String, TextEditingController> multipleInputsControllers = {
    'holderNumber': TextEditingController(),
    'holderName': TextEditingController(),
    'holderCpf': TextEditingController(),
  };

  Future<void> getInfo() async {
    isLoading.value = true;
    try {
      user.value = await _profileProvider.getInfo();
      await getSchedulings(true, "", {}, null);
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

  Future<void> getSchedulings(bool started, String search,
      Map<String, String> searchList, DateTimeRange? searchRangeDates) async {
    isLoading.value = true;
    nextSchedulings.value = await _schedulingProvider.getSchedulings(started,
        search, searchList, searchStatus, searchType, searchRangeDates);
    isLoading.value = false;
  }

  Future<void> getSchedulingsHistory() async {
    isLoading.value = true;
    historicSchedulings.value =
        await _schedulingProvider.getSchedulingHistory(user.value.id);
    isLoading.value = false;
  }

  Map<String, String> getNonEmptyValues(
      Map<String, TextEditingController> controllers) {
    Map<String, String> result = {};

    controllers.forEach((key, controller) {
      if (controller.text.isNotEmpty) {
        result.addAll({key: controller.text});
      }
    });

    return result;
  }

  @override
  void onInit() {
    super.onInit();
    getInfo();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}
}
