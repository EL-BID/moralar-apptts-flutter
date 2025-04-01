import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../modules/aditionar_scheduling/bindings/aditionar_scheduling_binding.dart';
import '../modules/aditionar_scheduling/views/aditionar_scheduling_view.dart';
import '../modules/answers/bindings/answers_binding.dart';
import '../modules/answers/views/answers_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/drawer/drawer.dart';
import '../modules/edit/bindings/edit_binding.dart';
import '../modules/edit/views/edit_view.dart';
import '../modules/matchs/bindings/matchs_binding.dart';
import '../modules/matchs/views/matchs_view.dart';
import '../modules/quiz/bindings/quiz_binding.dart';
import '../modules/quiz/views/quiz_view.dart';
import '../modules/quizzes/bindings/quizzes_binding.dart';
import '../modules/quizzes/views/quizzes_view.dart';
import '../modules/rescheduling/bindings/rescheduling_binding.dart';
import '../modules/rescheduling/views/rescheduling_view.dart';
import '../modules/scheduling/bindings/scheduling_binding.dart';
import '../modules/scheduling/views/scheduling_view.dart';
import '../modules/schedulings/bindings/schedulings_binding.dart';
import '../modules/schedulings/views/schedulings_view.dart';
import '../modules/timeline/bindings/timeline_binding.dart';
import '../modules/timeline/views/timeline_view.dart';
import '../modules/timeline_details/bindings/timeline_details_binding.dart';
import '../modules/timeline_details/views/timeline_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(
        onDelayCompleted: () {
          if (MegaFlutter.instance.auth.currentUser != null) {
            final user = MegaFlutter.instance.auth.currentUser as TTS;
            debugPrint('BEARER TOKEN ${user.token.accessToken}');
            Get.offAndToNamed(Routes.DASHBOARD);
          } else {
            Get.offAndToNamed(Routes.LOGIN);
          }
        },
      ),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(
        onSignedIn: () => Get.offAndToNamed(Routes.TIMELINE),
        recoveryPassword: () => Get.toNamed(Routes.RECOVERY_PASSWORD),
      ),
    ),
    GetPage(
      name: _Paths.EDIT,
      page: () => EditView(),
      binding: EditBinding(),
    ),
    GetPage(
      name: _Paths.QUIZZES,
      page: () => QuizzesView(),
      binding: QuizzesBinding(),
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
      page: () => DrawerView(),
      binding: TimelineBinding(),
      transition: Transition.leftToRightWithFade,
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
    GetPage(
      name: _Paths.TIMELINE_DETAILS,
      page: () => TimelineDetailsView(),
      binding: TimelineDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MATCHS,
      page: () => MatchsView(),
      binding: MatchsBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULINGS,
      page: () => SchedulingsView(),
      binding: SchedulingsBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULING,
      page: () => SchedulingView(),
      binding: SchedulingBinding(),
    ),
    GetPage(
      name: _Paths.ADITIONARSCHEDULING,
      page: () => AditionarSchedulingView(),
      binding: AditionarSchedulingBinding(),
    ),
    GetPage(
      name: _Paths.RESCHEDULING,
      page: () => ReSchedulingView(),
      binding: ReSchedulingBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
  ];
}
