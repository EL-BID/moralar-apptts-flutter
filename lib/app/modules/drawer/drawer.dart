import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../routes/app_pages.dart';

class TTSDrawer extends StatelessWidget {
  const TTSDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = MegaFlutter.instance.auth.currentUser as TTS;
    return MoralarDrawer(
      header: MoralarDrawerHeader(
        title: user.name,
        subtitle: user.jobPost,
      ),
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
        await MegaFlutter.instance.auth.signOut();
        Get.offAndToNamed(Routes.SPLASH);
      },
    );
  }
}
