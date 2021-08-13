import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../modules/answers/bindings/answers_binding.dart';
import '../modules/answers/views/answers_view.dart';
import '../modules/edit/bindings/edit_binding.dart';
import '../modules/edit/views/edit_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/quiz/bindings/quiz_binding.dart';
import '../modules/quiz/views/quiz_view.dart';
import '../modules/quizzes/views/quizzes_view.dart';
import '../modules/timeline/bindings/timeline_binding.dart';
import '../modules/timeline/views/timeline_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(
        onDelayCompleted: () => Get.offAndToNamed(Routes.TIMELINE),
      ),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.EDIT,
      page: () => EditView(),
      binding: EditBinding(),
    ),
    GetPage(
      name: _Paths.QUIZZES,
      page: () => QuizzesView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () => QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.RECOVERY_PASSWORD,
      page: () => RecoveryPasswordView(),
      binding: RecoveryPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => MoralarDrawer(
        header: const MoralarDrawerHeader(
          title: 'Lucas',
          subtitle: 'Desenvolvedor Mobile',
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
              Get.toNamed(Routes.RECOVERY_PASSWORD);
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
      ),
    ),
    GetPage(
      name: _Paths.TIMELINE,
      page: () => TimelineView(),
      binding: TimelineBinding(),
    ),
    GetPage(
      name: _Paths.ANSWERS,
      page: () => AnswersView(),
      binding: AnswersBinding(),
    ),
  ];
}
