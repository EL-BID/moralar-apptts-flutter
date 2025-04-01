import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/schedulings_controller.dart';

class SchedulingsView extends GetView<SchedulingsController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    RxBool needRefresh = false.obs;

    Widget _content(List<Widget> list, int index) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            MoralarButton(
              color: MoralarColors.darkBlueGrey,
              onPressed: () {
                Get.toNamed(Routes.ADITIONARSCHEDULING);
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Adicionar',
                  style: textTheme.labelLarge,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Obx(() {
              if (!needRefresh.value) {
                return FilterCard(
                    isMatch: true,
                    cleanFilterOpen: controller.cleanFilterOpen,
                    search: controller.search,
                    isMultipleSearch: true,
                    generalSearchMessage: '',
                    multipleSearch: controller.multipleSearch,
                    multipleSearchControllers:
                        controller.multipleInputsControllers,
                    showFilterStatus: true,
                    showFilterType: true,
                    searchStatus: (value) {
                      controller.searchStatus = value;
                    },
                    searchType: (value) {
                      controller.searchType = value;
                    },
                    searchDate: (value) {
                      controller.searchDate = value;
                    },
                    searchRangeDates: (value) {
                      controller.searchRangeDates = value;
                    },
                    onPressed: () {
                      controller.getSchedulings(
                          false,
                          "",
                          controller.getNonEmptyValues(
                              controller.multipleInputsControllers),
                          controller.searchRangeDates);
                    },
                    onCleanFilters: () {
                      controller.cleanFilterOpen = false.obs;
                      // Reset all values directly
                      controller.search.value = TextEditingValue.empty;
                      controller.multipleInputsControllers
                          .forEach((key, controller) {
                        controller.clear();
                      });
                      controller.searchStatus = '';
                      controller.searchType = '';
                      controller.searchDate =
                          DateRangeModel(startDate: 0, endDate: 0);
                      controller.searchRangeDates = null;

                      needRefresh.value = true;
                      Timer(const Duration(milliseconds: 60), () {
                        needRefresh.value = false;
                        controller.getSchedulings(true, "", {}, null);
                      });
                    });
              } else {
                return Container(); // or SizedBox.shrink() to take no space
              }
            }),
            Container(
              padding: const EdgeInsets.all(4),
              child: Visibility(
                visible: controller.isLoading.value,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 256),
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      MoralarColors.darkBlueGrey,
                    ),
                  ),
                ),
                replacement: Visibility(
                  visible: list.isNotEmpty,
                  child: Column(
                    children: list,
                  ),
                  replacement: Container(
                    padding: const EdgeInsets.symmetric(vertical: 56),
                    child: Text(
                      'Nenhum agendamento encontrado',
                      style: textTheme.headlineLarge,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Agendamentos',
      ),
      body: Obx(() {
        return PageView(
          controller: controller.pageController,
          children: [
            _content(
              List.generate(
                controller.nextSchedulings.length,
                (index) => ScheduleCard(
                  scheduleDetails: controller.nextSchedulings[index],
                  function: () {
                    Get.toNamed(
                      Routes.SCHEDULING,
                      arguments: controller.nextSchedulings[index].id,
                    );
                  },
                ),
              ),
              0,
            ),
            _content(
              List.generate(
                controller.historicSchedulings.length,
                (index) => ScheduleCard(
                  scheduleDetails: controller.historicSchedulings[index],
                  function: () {
                    Get.toNamed(
                      Routes.SCHEDULING,
                      arguments: controller.historicSchedulings[index].id,
                    );
                  },
                ),
              ),
              1,
            ),
          ],
        );
      }),
    );
  }
}
