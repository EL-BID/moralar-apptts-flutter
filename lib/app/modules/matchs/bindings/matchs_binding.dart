import 'package:get/get.dart';

import '../controllers/matchs_controller.dart';

class MatchsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MatchsController>(
      () => MatchsController(),
    );
  }
}
