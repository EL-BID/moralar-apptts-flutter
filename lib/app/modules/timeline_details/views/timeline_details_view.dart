import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/timeline_details_controller.dart';

class TimelineDetailsView extends GetView<TimelineDetailsController> {
  @override
  Widget build(BuildContext context) {
    return MoralarScaffold(
      appBar: MoralarAppBar(
        titleText: 'Detalhes',
        backgroundColor: Family.statusColor(controller.status),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              FamilyCard(status: controller.status, isDetail: true),
              Visibility(
                visible: controller.status != 1,
                child: SchedulingTTSCard(status: controller.status),
                replacement: const PropertyTTSCard(isHouse: true),
              ),
              FamilyInfoCard(
                title: 'Questionários Respondidos',
                cards: List.generate(4, (index) {
                  return MoralarTTSCard(
                    status: index % 2,
                    isCourse: false,
                  );
                }),
              ),
              FamilyInfoCard(
                title: 'Enquetes',
                cards: List.generate(2, (index) {
                  return MoralarTTSCard(
                    status: index % 2,
                    isCourse: false,
                  );
                }),
              ),
              FamilyInfoCard(
                title: 'Cursos',
                cards: List.generate(2, (index) {
                  return MoralarTTSCard(
                    status: index % 2,
                    isCourse: true,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
