import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/timeline_controller.dart';

class TimelineView extends GetView<TimelineController> {
  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
