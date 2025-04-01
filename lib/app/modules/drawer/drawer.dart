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
          titleText: 'Dashboard',
          icon: FontAwesomeIcons.tachometerAlt,
          onTap: () {
            Get.toNamed(Routes.DASHBOARD);
          },
        ),
        MoralarDrawerListTile(
          titleText: 'Famílias',
          icon: FontAwesomeIcons.houseUser,
          onTap: () {
            Navigator.of(context)
                .popUntil(ModalRoute.withName(Routes.TIMELINE));
            // Get.toNamed(Routes.TIMELINE);
          },
        ),
        MoralarDrawerListTile(
          titleText: 'Agendamentos',
          icon: FontAwesomeIcons.calendarAlt,
          onTap: () {
            Get.toNamed(Routes.SCHEDULINGS);
          },
        ),
        MoralarDrawerListTile(
          titleText: 'Matchs',
          icon: FontAwesomeIcons.star,
          onTap: () {
            Get.toNamed(Routes.MATCHS);
          },
        ),
        MoralarDrawerListTile(
          titleText: 'Questionários',
          icon: FontAwesomeIcons.solidQuestionCircle,
          onTap: () {
            Get.toNamed(Routes.QUIZZES);
          },
        ),
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
        Get.offAndToNamed(Routes.SPLASH);
        await MegaFlutter.instance.auth.signOut();
      },
    );
  }
}
