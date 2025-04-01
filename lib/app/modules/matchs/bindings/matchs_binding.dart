import 'package:get/get.dart';

import '../../../providers/matchs_provider.dart';
import '../controllers/matchs_controller.dart';

class MatchsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MatchsController>(
      () => MatchsController(),
    );
    Get.lazyPut<MatchsProvider>(
      () => MatchsProvider(),
    );
  }
}
