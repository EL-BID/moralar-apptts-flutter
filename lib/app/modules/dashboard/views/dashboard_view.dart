import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.find<DashboardController>();

    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Dashboard',
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Visibility(
            visible: !controller.isLoading.value,
            child: Column(
              // Changed from Row to Column
              children: [
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(
                        right: 30, bottom: 24, top: 20, left: 30),
                    height: 630,
                    width: 490,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                                right: 0, left: 25, top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Famílias de moradores',
                                  style: textTheme.headlineLarge?.copyWith(
                                      color: MoralarColors.waterBlue),
                                ),
                                const SizedBox(height: 8),
                                TextElementCard(
                                  title: 'Total',
                                  vertical: true,
                                  value: controller
                                      .dashboard.value.amountFamilies
                                      .toString(),
                                ),
                                const SizedBox(height: 28),
                                Text("Etapas",
                                    style: textTheme.bodyMedium?.copyWith(
                                        color: MoralarColors.waterBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                TextElementCard(
                                  title: 'Reunião PGM',
                                  vertical: true,
                                  value:
                                      '${controller.convertToShortPercentage(controller.dashboard.value.percentageAmoutReuniaoPgm)}%',
                                ),
                                TextElementCard(
                                  title: 'Escolha do imóvel',
                                  vertical: true,
                                  value:
                                      '${controller.convertToShortPercentage(controller.dashboard.value.percentageAmoutChooseProperty)}%',
                                ),
                                TextElementCard(
                                  title: 'Mudança',
                                  vertical: true,
                                  value:
                                      '${controller.convertToShortPercentage(controller.dashboard.value.percentageAmoutChangeProperty)}%',
                                ),
                                TextElementCard(
                                  title: 'Acompanhamento pós-mudança',
                                  vertical: true,
                                  value:
                                      '${controller.convertToShortPercentage(controller.dashboard.value.percentageAmoutPosMudanca)}%',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(
                        right: 30, bottom: 24, top: 20, left: 30),
                    height: 300,
                    width: 490,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                                right: 0, left: 25, top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Imóveis',
                                  style: textTheme.headlineLarge?.copyWith(
                                      color: MoralarColors.waterBlue),
                                ),
                                const SizedBox(height: 8),
                                TextElementCard(
                                  title: 'Disponíveis para compra',
                                  vertical: true,
                                  value: controller
                                      .dashboard.value.availableForSale
                                      .toString(),
                                ),
                                TextElementCard(
                                  title: 'Vendidos',
                                  vertical: true,
                                  value: controller
                                      .dashboard.value.residencialPropertySaled
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
