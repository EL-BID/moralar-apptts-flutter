import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../routes/app_pages.dart';
import '../timeline/controllers/timeline_controller.dart';

class DrawerView extends GetView<TimelineController> {
  @override
  Widget build(BuildContext context) {
    return MoralarDrawer(
      header: Obx(() {
        return MoralarDrawerHeader(
          title: controller.user.value.name,
          subtitle: controller.user.value.jobPost,
        );
      }),
      options: [
        MoralarDrawerListTile(
          titleText: 'Famílias',
          icon: FontAwesomeIcons.bars,
          onTap: () {
            Get.toNamed(Routes.TIMELINE);
          },
        ),
        MoralarDrawerListTile(
          titleText: 'Matchs',
          icon: FontAwesomeIcons.home,
          onTap: () {
            Get.toNamed(Routes.MATCHS);
          },
        ),
        // MoralarDrawerListTile(
        //   titleText: 'Questionários',
        //   icon: FontAwesomeIcons.solidQuestionCircle,
        //   onTap: () {
        //     Get.toNamed(Routes.QUIZZES);
        //   },
        // ),
        MoralarDrawerListTile(
          titleText: 'Editar Perfil',
          icon: FontAwesomeIcons.userAlt,
          onTap: () {
            Get.toNamed(Routes.EDIT);
          },
        ),
        MoralarDrawerListTile(
          titleText: 'Alterar Senha',
          icon: FontAwesomeIcons.lock,
          onTap: () {
            Get.toNamed(Routes.CHANGE_PASSWORD);
          },
        ),
      ],
      signOut: () async {
        await MegaFlutter.instance.auth.signOut();
        Get.offAndToNamed(Routes.SPLASH);
      },
    );
  }
}
