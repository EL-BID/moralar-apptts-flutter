import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/timeline_controller.dart';

class TimelineView extends GetView<TimelineController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MoralarScaffold(
      appBar: MoralarAppBar(
        titleText: 'Famílias',
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.bars, color: Colors.black),
          onPressed: () => Get.toNamed(Routes.MENU),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Obx(() {
                return Column(
                  children: [
                    FilterCard(
                      searchFamily: controller.familySearch,
                      filterHint: controller.hintStatus.value,
                      filterStatus: controller.filterStatus,
                      onChanged: (s) {
                        controller.hintStatus.value = s!;
                      },
                      onPressed: () {
                        print(controller.familySearch.text);
                        print(controller.hintStatus.value);
                        controller.searchTimeline(false);
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: MoralarButton(
                        onPressed: () {
                          controller.extractReport();
                        },
                        child: controller.isLoadingReport.value
                            ? const Center(
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Extrair Relatório',
                                  style: textTheme.labelLarge,
                                ),
                              ),
                      ),
                    ),
                    Visibility(
                      visible: controller.isLoading.value,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 128),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      replacement: Visibility(
                        visible: controller.familys.isNotEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              List.generate(controller.familys.length, (index) {
                            return FamilyCard(
                              family: controller.familys[index],
                              function: () => Get.toNamed(
                                Routes.TIMELINE_DETAILS,
                                arguments: controller.familys[index],
                              ),
                            );
                          }),
                        ),
                        replacement: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 128),
                          child: Text(
                            'Nenhuma família encontrada.\n\nPesquise acima.',
                            style: textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
