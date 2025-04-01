import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/dashboard_provider.dart';

class DashboardController extends GetxController {
  final _dashboardProvider = Get.find<DashboardProvider>();
  final isLoading = false.obs;

  //Classes
  var dashboard = Dashboard(
    amountFamilies: 0,
    percentageAmoutReuniaoPgm: 0.0,
    percentageAmoutChooseProperty: 0.0,
    percentageAmoutChangeProperty: 0.0,
    percentageAmoutPosMudanca: 0.0,
    availableForSale: 0,
    residencialPropertySaled: 0,
  ).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadDashboard();
  }

  Future<void> loadDashboard() async {
    isLoading.value = true;
    try {
      dashboard.value = await _dashboardProvider.getDashboard();
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

  String convertToShortPercentage(double value) {
    // Convert the value to a percentage and round to two decimal places
    return value.toStringAsFixed(2).toString();
  }
}
