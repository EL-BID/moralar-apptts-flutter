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
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.ellipsisV, color: Colors.black),
            onPressed: Get.back,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Obx(() {
                return FilterCard(
                  filterHint: controller.hintStatus.value,
                  filterStatus: controller.filterStatus,
                  onChanged: (s) {
                    controller.hintStatus.value = s!;
                  },
                  onPressed: () {
                    print('buscar');
                  },
                );
              }),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(4, (index) {
                  return FamilyCard(
                    status: index,
                    function: () => Get.toNamed(
                      Routes.TIMELINE_DETAILS,
                      arguments: index,
                    ),
                  );
                }),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: MoralarButton(
                  onPressed: () {},
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Extrair Relatório',
                      style: textTheme.button,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
